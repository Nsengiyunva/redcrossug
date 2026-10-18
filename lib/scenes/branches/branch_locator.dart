import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:redcross/controllers/branch_locator_controller.dart';
import 'package:redcross/models/branch.dart';
import 'package:redcross/scenes/widgets/contact_sheet.dart';
import 'package:redcross/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

/// Full-screen Branch Locator: map of every URCS branch on top, a
/// "nearest to you" card, and a searchable list sorted by distance.
/// Tapping a marker or list row focuses it on the map and opens a sheet
/// with Directions / Call / "Set as my branch".
class BranchLocator extends StatefulWidget {
  const BranchLocator({super.key});

  static const String prefsKey = 'preferred_branch_id';

  @override
  State<BranchLocator> createState() => _BranchLocatorState();
}

class _BranchLocatorState extends State<BranchLocator> {
  final BranchLocatorController c = Get.put(BranchLocatorController());
  final Completer<GoogleMapController> _map = Completer();
  int? _myBranchId;

  // Geographic centre of Uganda — shows the whole country at zoom ~6.3.
  static const LatLng _ugandaCentre = LatLng(1.3733, 32.2903);

  @override
  void initState() {
    super.initState();
    _loadMyBranch();
    // Once we know where the user is, glide to them + nearest branch.
    ever(c.userPosition, (_) => _fitUserAndNearest());
  }

  Future<void> _loadMyBranch() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() => _myBranchId = prefs.getInt(BranchLocator.prefsKey));
  }

  Future<void> _setMyBranch(Branch b) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(BranchLocator.prefsKey, b.id);
    await prefs.setString('${BranchLocator.prefsKey}_name', b.name);
    if (!mounted) return;
    setState(() => _myBranchId = b.id);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${b.name} set as your branch.')),
    );
  }

  Future<void> _fitUserAndNearest() async {
    final p = c.userPosition.value;
    final n = c.nearest;
    if (p == null || n == null || !_map.isCompleted) return;
    final ctrl = await _map.future;
    final sw = LatLng(
      p.latitude < n.branch.latitude! ? p.latitude : n.branch.latitude!,
      p.longitude < n.branch.longitude! ? p.longitude : n.branch.longitude!,
    );
    final ne = LatLng(
      p.latitude > n.branch.latitude! ? p.latitude : n.branch.latitude!,
      p.longitude > n.branch.longitude! ? p.longitude : n.branch.longitude!,
    );
    try {
      await ctrl.animateCamera(
        CameraUpdate.newLatLngBounds(LatLngBounds(southwest: sw, northeast: ne), 70),
      );
    } catch (_) {
      // Bounds can throw if the map hasn't laid out yet — not critical.
    }
  }

  Future<void> _focus(Branch b) async {
    c.selected.value = b;
    if (_map.isCompleted && b.hasLocation) {
      final ctrl = await _map.future;
      await ctrl.animateCamera(
        CameraUpdate.newLatLngZoom(LatLng(b.latitude!, b.longitude!), 12),
      );
      ctrl.showMarkerInfoWindow(MarkerId('branch_${b.id}'));
    }
    if (mounted) _showBranchSheet(b);
  }

  Future<void> _openDirections(Branch b) async {
    final uri = Uri.parse(
      'https://www.google.com/maps/dir/?api=1'
      '&destination=${b.latitude},${b.longitude}',
    );
    try {
      final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (!ok && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open Maps.')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  Set<Marker> _markers() {
    return c.branches.where((b) => b.hasLocation).map((b) {
      final isNearest = c.nearest?.branch.id == b.id;
      final isMine = _myBranchId == b.id;
      final km = c.distanceKm(b);
      return Marker(
        markerId: MarkerId('branch_${b.id}'),
        position: LatLng(b.latitude!, b.longitude!),
        icon: BitmapDescriptor.defaultMarkerWithHue(
          isMine
              ? BitmapDescriptor.hueAzure
              : isNearest
                  ? BitmapDescriptor.hueGreen
                  : BitmapDescriptor.hueRed,
        ),
        infoWindow: InfoWindow(
          title: 'URCS ${b.name}',
          snippet: km != null ? '${km.toStringAsFixed(1)} km away' : b.region,
          onTap: () => _showBranchSheet(b),
        ),
        onTap: () => c.selected.value = b,
      );
    }).toSet();
  }

  void _showBranchSheet(Branch b) {
    final km = c.distanceKm(b);
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheet) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'URCS ${b.name} Branch',
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.blackColorB,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                [
                  if (b.region != null) '${b.region} Region',
                  if (km != null) '${km.toStringAsFixed(1)} km from you',
                ].join(' · '),
                style: const TextStyle(
                    fontFamily: 'Inter', color: AppColors.greyColorB),
              ),
              if (b.address != null) ...[
                const SizedBox(height: 10),
                Row(children: [
                  const Icon(Icons.place_outlined,
                      size: 18, color: AppColors.greyColorC),
                  const SizedBox(width: 6),
                  Expanded(
                      child: Text(b.address!,
                          style: const TextStyle(fontFamily: 'Inter'))),
                ]),
              ],
              const SizedBox(height: 18),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryRedColor,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 13),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      icon: const Icon(Icons.directions_rounded),
                      label: const Text('Directions',
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700)),
                      onPressed: () => _openDirections(b),
                    ),
                  ),
                  if (b.phone != null && b.phone!.isNotEmpty) ...[
                    const SizedBox(width: 10),
                    Expanded(
                      child: OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.primaryRedColor,
                          side: const BorderSide(
                              color: AppColors.primaryRedColor),
                          padding: const EdgeInsets.symmetric(vertical: 13),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        icon: const Icon(Icons.call_rounded),
                        label: const Text('Call',
                            style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700)),
                        onPressed: () => dialNumber(context, b.phone!),
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 8),
              TextButton.icon(
                onPressed: _myBranchId == b.id
                    ? null
                    : () {
                        Navigator.of(sheet).pop();
                        _setMyBranch(b);
                      },
                icon: Icon(_myBranchId == b.id
                    ? Icons.check_circle_rounded
                    : Icons.bookmark_add_outlined),
                label: Text(
                  _myBranchId == b.id ? 'This is your branch' : 'Set as my branch',
                  style: const TextStyle(
                      fontFamily: 'Inter', fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: const Text('Branch Locator',
            style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w700)),
        actions: [
          Obx(() => IconButton(
                tooltip: 'Find me',
                onPressed: c.isLocating.value ? null : c.locateUser,
                icon: c.isLocating.value
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2))
                    : const Icon(Icons.my_location_rounded),
              )),
        ],
      ),
      body: Obx(() {
        if (c.isLoading.value && c.branches.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        final nearest = c.nearest;
        final rows = c.sorted;

        return Column(
          children: [
            // ── Map ──────────────────────────────────────────────────────
            SizedBox(
              height: height * 0.40,
              child: GoogleMap(
                initialCameraPosition:
                    const CameraPosition(target: _ugandaCentre, zoom: 6.3),
                markers: _markers(),
                myLocationEnabled: c.userPosition.value != null,
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
                mapToolbarEnabled: false,
                onMapCreated: (ctrl) {
                  if (!_map.isCompleted) _map.complete(ctrl);
                  _fitUserAndNearest();
                },
              ),
            ),

            // ── Nearest card / location status ──────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 6),
              child: nearest != null
                  ? _NearestCard(
                      item: nearest,
                      onTap: () => _focus(nearest.branch),
                    )
                  : _StatusCard(
                      text: c.isLocating.value
                          ? 'Finding your location…'
                          : (c.locationError.value.isNotEmpty
                              ? c.locationError.value
                              : 'Allow location to see your nearest branch.'),
                      onRetry: c.isLocating.value ? null : c.locateUser,
                    ),
            ),

            // ── Search ──────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              child: TextField(
                onChanged: (v) => c.query.value = v,
                decoration: InputDecoration(
                  hintText: 'Search branch or region',
                  prefixIcon: const Icon(Icons.search_rounded),
                  isDense: true,
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.greyColorH),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.greyColorH),
                  ),
                ),
              ),
            ),

            // ── List ────────────────────────────────────────────────────
            Expanded(
              child: rows.isEmpty
                  ? const Center(child: Text('No branches match your search.'))
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(16, 6, 16, 20),
                      itemCount: rows.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 8),
                      itemBuilder: (_, i) {
                        final r = rows[i];
                        return _BranchRow(
                          item: r,
                          isSelected: c.selected.value?.id == r.branch.id,
                          isMine: _myBranchId == r.branch.id,
                          onTap: () => _focus(r.branch),
                        );
                      },
                    ),
            ),
          ],
        );
      }),
    );
  }
}

class _NearestCard extends StatelessWidget {
  final BranchDistance item;
  final VoidCallback onTap;
  const _NearestCard({required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFF00A86B).withOpacity(0.08),
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFF00A86B).withOpacity(0.3)),
          ),
          child: Row(
            children: [
              const Icon(Icons.near_me_rounded, color: Color(0xFF00875A)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Nearest branch',
                        style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 12,
                            color: Color(0xFF00875A),
                            fontWeight: FontWeight.w600)),
                    const SizedBox(height: 2),
                    Text(
                      'URCS ${item.branch.name}',
                      style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.blackColorB),
                    ),
                  ],
                ),
              ),
              if (item.km != null)
                Text('${item.km!.toStringAsFixed(1)} km',
                    style: const TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        color: AppColors.blackColorC)),
              const Icon(Icons.chevron_right_rounded,
                  color: AppColors.greyColorC),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusCard extends StatelessWidget {
  final String text;
  final VoidCallback? onRetry;
  const _StatusCard({required this.text, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.greyColorH),
      ),
      child: Row(
        children: [
          const Icon(Icons.location_searching_rounded,
              color: AppColors.greyColorC, size: 20),
          const SizedBox(width: 10),
          Expanded(
              child: Text(text,
                  style: const TextStyle(
                      fontFamily: 'Inter', fontSize: 13))),
          if (onRetry != null)
            TextButton(onPressed: onRetry, child: const Text('Retry')),
        ],
      ),
    );
  }
}

class _BranchRow extends StatelessWidget {
  final BranchDistance item;
  final bool isSelected;
  final bool isMine;
  final VoidCallback onTap;
  const _BranchRow({
    required this.item,
    required this.isSelected,
    required this.isMine,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected
                  ? AppColors.primaryRedColor
                  : AppColors.greyColorH,
              width: isSelected ? 1.4 : 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.redColorD,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.location_on_rounded,
                    color: AppColors.primaryRedColor, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(item.branch.name,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14.5)),
                        ),
                        if (isMine) ...[
                          const SizedBox(width: 6),
                          const Icon(Icons.bookmark_rounded,
                              size: 16, color: AppColors.blueColorA),
                        ],
                      ],
                    ),
                    if (item.branch.region != null)
                      Text('${item.branch.region} Region',
                          style: const TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 12,
                              color: AppColors.greyColorB)),
                  ],
                ),
              ),
              if (item.km != null)
                Text('${item.km!.toStringAsFixed(1)} km',
                    style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.blackColorC)),
            ],
          ),
        ),
      ),
    );
  }
}

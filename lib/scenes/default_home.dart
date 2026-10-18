import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:redcross/models/user.dart';
import 'package:redcross/scenes/ambulances/ambulance_home.dart';
import 'package:redcross/scenes/blood_donations/blood_donations_home.dart';
import 'package:redcross/scenes/branches/branch_locator.dart';
import 'package:redcross/scenes/bulletins/bulletins_list.dart';
import 'package:redcross/scenes/disasters/disaster_list.dart';
import 'package:redcross/scenes/first_aid/first_aid_home.dart';
import 'package:redcross/scenes/memberships/membership_card.dart';
import 'package:redcross/scenes/volunteer/volunteer_home.dart';
import 'package:redcross/utils/colors.dart';
import 'package:redcross/utils/storage_service.dart';
import 'package:redcross/utils/urcs_branches.dart';
import 'package:redcross/utils/urcs_contacts.dart';
import 'package:url_launcher/url_launcher.dart';

class DefaultHome extends StatefulWidget {
  const DefaultHome({super.key});

  @override
  State<DefaultHome> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<DefaultHome> {
  var time = StorageService.displayWhatTime();
  User? loggedInUser;

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  void loadUser() async {
    loggedInUser = await StorageService.getUser();
    setState(() {});
  }

  Future<void> _openAboutUsUrl(BuildContext context) async {
    final Uri uri = Uri.parse('https://redcrossug.org/');
    try {
      // Go straight to launchUrl instead of gating on canLaunchUrl.
      // On Android 11+ (API 30+), canLaunchUrl reports false for a
      // perfectly valid https:// link unless the app also declares a
      // <queries> block in AndroidManifest.xml — which was missing here,
      // so every tap fell into the "Could not open" branch even though
      // the link itself was fine. launchUrl doesn't need that check.
      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
      if (!launched && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open redcrossug.org.')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 600;
    final horizontalPadding = isTablet ? 32.0 : 20.0;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FB),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
            horizontalPadding,
            16.0,
            horizontalPadding,
            24.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 20),
              _buildAboutUsBanner(context),
              const SizedBox(height: 12),
              _buildDonateButton(context),
              const SizedBox(height: 26),
              const Text(
                'Our Services',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E1E1E),
                  letterSpacing: -0.2,
                ),
              ),
              const SizedBox(height: 14),
              _buildServiceGrid(context, isTablet),
              const SizedBox(height: 18),
              _buildQuickActionButtons(context),
              const SizedBox(height: 26),
              _buildBranchMapSection(context),
            ],
          ),
        ),
      ),
    );
  }

  /// Greeting row: avatar initial, time-of-day + name, notification bell.
  Widget _buildHeader() {
    final initial = (loggedInUser?.name.isNotEmpty ?? false)
        ? loggedInUser!.name[0].toUpperCase()
        : "U";

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [Color(0xFFE31E24), Color(0xFFB71C1C)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFE31E24).withOpacity(0.35),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Text(
                  initial,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      time,
                      style: TextStyle(
                        fontSize: 13,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[600],
                        letterSpacing: 0.2,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      loggedInUser?.name ?? "",
                      style: const TextStyle(
                        fontSize: 21,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E1E1E),
                        letterSpacing: -0.3,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        Container(
          padding: const EdgeInsets.all(11),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFEDEDF2), width: 1.2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: const Icon(
            Icons.notifications_outlined,
            color: Color(0xFF2C3E50),
            size: 22,
          ),
        ),
      ],
    );
  }

  /// Promo banner: URCS emblem on the left, "About URCS" button on the
  /// right — the descriptive paragraph that used to fill this card has
  /// been removed per request, so the banner is now a compact logo +
  /// CTA row instead of a text block.
  ///
  /// NOTE: this expects the logo at assets/images/urcs_logo.png,
  /// declared in pubspec.yaml (see the flutter: assets: section). If the
  /// asset hasn't been added yet, errorBuilder falls back to a plain
  /// cross icon so the screen doesn't crash in the meantime.
  static const String _logoAssetPath = 'assets/images/urcs_logo.png';

  Widget _buildAboutUsBanner(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(22),
      child: InkWell(
        onTap: () => _openAboutUsUrl(context),
        borderRadius: BorderRadius.circular(22),
        splashColor: Colors.white.withOpacity(0.15),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            gradient: const LinearGradient(
              colors: [Color(0xFFED1C24), Color(0xFFB0121A)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFED1C24).withOpacity(0.30),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  _logoAssetPath,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.add,
                    color: Color(0xFFED1C24),
                    size: 28,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Text(
                  'About URCS',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Inter",
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: Colors.white,
                  ),
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: Colors.white,
                size: 22,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 3-column grid of plain white, icon-badge service cards — each with a
  /// light-red icon badge and a dark label, back to the original card
  /// style instead of the red-gradient tiles used briefly before.
  ///
  /// Bulletins and Give Feedback have been pulled out of this grid — see
  /// [_buildQuickActionButtons] — so this now only holds the six core
  /// services.
  Widget _buildServiceGrid(BuildContext context, bool isTablet) {
    final services = <_ServiceItem>[
      _ServiceItem(
        icon: Icons.water_drop_rounded,
        label: 'Blood Donation',
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const BloodDonationsHome()),
        ),
      ),
      _ServiceItem(
        icon: Icons.medical_services_rounded,
        label: 'First Aid',
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const FirstAidHome()),
        ),
      ),
      _ServiceItem(
        icon: Icons.local_hospital_rounded,
        label: 'Ambulance',
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => AmbulanceHome()),
        ),
      ),
      _ServiceItem(
        icon: Icons.warning_rounded,
        label: 'Disasters',
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => DisasterList()),
        ),
      ),
      _ServiceItem(
        icon: Icons.card_membership_rounded,
        label: 'Membership',
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const MembershipCard()),
        ),
      ),
      _ServiceItem(
        icon: Icons.volunteer_activism_rounded,
        label: 'Volunteers',
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const VolunteerHome()),
        ),
      ),
    ];

    final crossAxisCount = isTablet ? 4 : 3;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: services.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.92,
      ),
      itemBuilder: (context, index) => _buildServiceCard(services[index]),
    );
  }

  // Logo red (Uganda Red Cross Society emblem) — used as the icon-badge
  // accent color on the plain white service cards below.
  static const Color _urcsRed = Color(0xFFED1C24);

  Widget _buildServiceCard(_ServiceItem item) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: item.onPressed,
        borderRadius: BorderRadius.circular(20),
        splashColor: AppColors.primaryRedColor.withOpacity(0.08),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey[200]!),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFE5E5),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    item.icon,
                    color: AppColors.primaryRedColor,
                    size: 24,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  item.label,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w700,
                    color: AppColors.blackColorB,
                    height: 1.25,
                    letterSpacing: 0.1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Bulletins and Give Feedback, rendered as full-width long buttons
  /// stacked below the services grid instead of as grid cards.
  Widget _buildQuickActionButtons(BuildContext context) {
    final actions = <_ServiceItem>[
      _ServiceItem(
        icon: Icons.campaign_rounded,
        label: 'Bulletins',
        accentColor: const Color(0xFFEC407A),
        isNew: true,
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const BulletinsList()),
        ),
      ),
      _ServiceItem(
        icon: Icons.feedback_rounded,
        label: 'Give Feedback',
        accentColor: const Color(0xFF26A69A),
        onPressed: () => _openFeedbackUrl(context),
      ),
    ];

    return Column(
      children: [
        for (int i = 0; i < actions.length; i++) ...[
          _buildLongButton(actions[i]),
          if (i != actions.length - 1) const SizedBox(height: 12),
        ],
      ],
    );
  }

  Widget _buildLongButton(_ServiceItem item) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: item.onPressed,
        borderRadius: BorderRadius.circular(18),
        splashColor: item.accentColor.withOpacity(0.12),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 14,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: item.accentColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                alignment: Alignment.center,
                child: Icon(item.icon, color: item.accentColor, size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  item.label,
                  style: const TextStyle(
                    fontSize: 14.5,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1E1E1E),
                    letterSpacing: -0.1,
                  ),
                ),
              ),
              if (item.isNew) ...[
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: const Color(0xFF00BFA5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'NEW',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 9,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.4,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
              ],
              Icon(
                Icons.chevron_right_rounded,
                color: Colors.grey.shade400,
                size: 22,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Donate ───────────────────────────────────────────────────────────────

  /// Landing-page Donate CTA. Until [UrcsContacts.donationUrl] is set it
  /// shows a "coming soon" sheet; once set, it opens the URCS website
  /// donation page externally.
  Widget _buildDonateButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: () => _onDonate(context),
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: _urcsRed,
          side: const BorderSide(color: _urcsRed, width: 1.4),
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        icon: const Icon(Icons.favorite_rounded, size: 20),
        label: const Text(
          'Donate',
          style: TextStyle(
            fontFamily: "Inter",
            fontWeight: FontWeight.w800,
            fontSize: 16,
            letterSpacing: 0.2,
          ),
        ),
      ),
    );
  }

  Future<void> _onDonate(BuildContext context) async {
    const url = UrcsContacts.donationUrl;
    if (url != null) {
      try {
        final ok = await launchUrl(Uri.parse(url),
            mode: LaunchMode.externalApplication);
        if (ok || !context.mounted) return;
      } catch (_) {}
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open the donation page.')),
        );
      }
      return;
    }
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheet) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: const BoxDecoration(
                  color: Color(0xFFFFE5E5),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.favorite_rounded,
                    color: _urcsRed, size: 28),
              ),
              const SizedBox(height: 14),
              const Text(
                'Online donations coming soon',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Inter",
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'You\'ll soon be able to support URCS directly from the app '
                'through our website. Thank you for wanting to help!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Inter",
                  fontSize: 13.5,
                  height: 1.4,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => Navigator.of(sheet).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Branch Locator map section ───────────────────────────────────────────

  /// Static (non-interactive) map preview of all URCS branches; tapping
  /// anywhere opens the full [BranchLocator] to find/select the nearest.
  Widget _buildBranchMapSection(BuildContext context) {
    void open() => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const BranchLocator()),
        );

    final markers = UrcsBranches.seed
        .where((b) => b.hasLocation)
        .map((b) => Marker(
              markerId: MarkerId('home_branch_${b.id}'),
              position: LatLng(b.latitude!, b.longitude!),
              consumeTapEvents: true,
              onTap: open,
            ))
        .toSet();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Expanded(
              child: Text(
                'URCS Branches',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E1E1E),
                  letterSpacing: -0.2,
                ),
              ),
            ),
            TextButton(
              onPressed: open,
              child: const Text(
                'View all',
                style: TextStyle(
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w600,
                  color: _urcsRed,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: SizedBox(
            height: 190,
            child: Stack(
              children: [
                GoogleMap(
                  liteModeEnabled: true, // Android static bitmap; cheap.
                  initialCameraPosition: const CameraPosition(
                    target: LatLng(1.3733, 32.2903),
                    zoom: 5.6,
                  ),
                  markers: markers,
                  zoomControlsEnabled: false,
                  mapToolbarEnabled: false,
                  myLocationButtonEnabled: false,
                  scrollGesturesEnabled: false,
                  zoomGesturesEnabled: false,
                  rotateGesturesEnabled: false,
                  tiltGesturesEnabled: false,
                ),
                // Tap-catcher above the platform view.
                Positioned.fill(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(onTap: open),
                  ),
                ),
                Positioned(
                  left: 12,
                  right: 12,
                  bottom: 12,
                  child: IgnorePointer(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.12),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.near_me_rounded,
                              color: _urcsRed, size: 20),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Find your nearest branch',
                              style: TextStyle(
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Icon(Icons.chevron_right_rounded,
                              color: Colors.grey),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  static const String _feedbackFormUrl = 'https://ee.ifrc.org/x/Nxc7RtB9';

  Future<void> _openFeedbackUrl(BuildContext context) async {
    final Uri uri = Uri.parse(_feedbackFormUrl);
    try {
      // Direct launchUrl call (no canLaunchUrl gate) — see the fix
      // applied to the About URCS / membership / volunteer links.
      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
      if (!launched && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open the feedback form.')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }
}

class _ServiceItem {
  final IconData icon;
  final String label;
  // Only used by the Bulletins/Give Feedback long buttons now — the 6
  // grid cards above all share the uniform _urcsRed styling instead.
  final Color accentColor;
  final bool isNew;
  final VoidCallback onPressed;

  _ServiceItem({
    required this.icon,
    required this.label,
    this.accentColor = _HomeScreenState._urcsRed,
    this.isNew = false,
    required this.onPressed,
  });
}

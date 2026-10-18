// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:redcross/models/branch.dart';
import 'package:redcross/utils/api_endpoints.dart';
import 'package:redcross/utils/storage_service.dart';
import 'package:redcross/utils/urcs_branches.dart';

/// A branch paired with its distance (km) from the user, when known.
class BranchDistance {
  final Branch branch;
  final double? km;
  BranchDistance(this.branch, this.km);
}

class BranchLocatorController extends GetxController {
  final isLoading = false.obs;
  final isLocating = false.obs;
  final branches = <Branch>[].obs;
  final userPosition = Rxn<Position>();
  final selected = Rxn<Branch>();
  final locationError = ''.obs;
  final query = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadBranches();
    locateUser();
  }

  /// Tries the API first; falls back to the bundled seed list.
  Future<void> loadBranches() async {
    isLoading.value = true;
    try {
      final token = await StorageService.getToken();
      final res = await http.get(
        Uri.parse(
            '${ApiEndpoints.baseUrl}/${ApiEndpoints.authEndpoints.branches}'),
        headers: {
          'Accept': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
      ).timeout(const Duration(seconds: 10));

      if (res.statusCode == 200) {
        final decoded = json.decode(res.body);
        final List raw = decoded is List
            ? decoded
            : (decoded is Map && decoded['data'] is List)
                ? decoded['data']
                : const [];
        final parsed = raw
            .whereType<Map>()
            .map((e) => Branch.fromJson(Map<String, dynamic>.from(e)))
            .where((b) => b.hasLocation)
            .toList();
        if (parsed.isNotEmpty) {
          branches.assignAll(parsed);
          return;
        }
      }
      branches.assignAll(UrcsBranches.seed);
    } catch (e) {
      print('Branch fetch failed, using bundled list: $e');
      branches.assignAll(UrcsBranches.seed);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> locateUser() async {
    isLocating.value = true;
    locationError.value = '';
    try {
      if (!await Geolocator.isLocationServiceEnabled()) {
        locationError.value = 'Turn on location to find your nearest branch.';
        return;
      }
      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        locationError.value =
            'Location permission denied — pick a branch from the list.';
        return;
      }
      userPosition.value = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium,
      ).timeout(const Duration(seconds: 15));
    } catch (e) {
      locationError.value = 'Could not get your location.';
    } finally {
      isLocating.value = false;
    }
  }

  double? distanceKm(Branch b) {
    final p = userPosition.value;
    if (p == null || !b.hasLocation) return null;
    return Geolocator.distanceBetween(
            p.latitude, p.longitude, b.latitude!, b.longitude!) /
        1000;
  }

  /// Branches filtered by the search box, nearest first when location known.
  List<BranchDistance> get sorted {
    final q = query.value.trim().toLowerCase();
    final list = branches
        .where((b) =>
            q.isEmpty ||
            b.name.toLowerCase().contains(q) ||
            (b.region ?? '').toLowerCase().contains(q))
        .map((b) => BranchDistance(b, distanceKm(b)))
        .toList();
    list.sort((a, b) {
      if (a.km != null && b.km != null) return a.km!.compareTo(b.km!);
      return a.branch.name.compareTo(b.branch.name);
    });
    return list;
  }

  BranchDistance? get nearest {
    if (userPosition.value == null || branches.isEmpty) return null;
    final all = branches.map((b) => BranchDistance(b, distanceKm(b))).toList()
      ..sort((a, b) => (a.km ?? 1e9).compareTo(b.km ?? 1e9));
    return all.first;
  }
}

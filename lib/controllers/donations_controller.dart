import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redcross/scenes/blood_donations/blood_eligibility.dart';
import 'package:redcross/utils/api_endpoints.dart';
import 'package:redcross/utils/storage_service.dart';
import 'package:http/http.dart' as http;

/// Campaign "buckets" shown as tabs on the campaigns screen.
class CampaignTab {
  static const upcoming = 'upcoming';
  static const active = 'active';
  static const completed = 'completed';
}

class DonationsController extends GetxController {
  var isLoading = false.obs;
  var isFetchingCauses = false.obs;
  var campaign_list = <Map<String, dynamic>>[].obs;
  var causes_list = [].obs;
  var filtered_campaigns = <Map<String, dynamic>>[].obs;
  var selectedTab = CampaignTab.upcoming.obs;

  /// Non-empty when the last campaigns request failed. Shown on screen
  /// with a retry button instead of a misleading "no campaigns" message.
  var campaignError = ''.obs;

  TextEditingController healthy_today = TextEditingController();
  TextEditingController donated_yet = TextEditingController();
  TextEditingController blood_group = TextEditingController();
  TextEditingController last_donation_date = TextEditingController();

  var isUploading = false.obs;

  @override
  void onInit() {
    super.onInit();
    ever(campaign_list, (_) => applyFilter());
    ever(selectedTab, (_) => applyFilter());
    fetchCampaignList();
    fetchCauses();
  }

  void setTab(String tab) {
    selectedTab.value = tab;
  }

  void goToEligibility(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const BloodEligibility(),
      ),
    );
  }

  /// Fetch only if we have nothing yet (or the last attempt failed).
  /// The controller is created with Get.put from several screens, so
  /// onInit may have run long ago, e.g. before the user signed in.
  Future<void> ensureCampaignsLoaded() async {
    if (isLoading.value) return;
    if (campaign_list.isEmpty || campaignError.value.isNotEmpty) {
      await fetchCampaignList();
    }
  }

  // ---------------------------------------------------------------------
  // Status / tab bucketing
  // ---------------------------------------------------------------------

  static const _upcomingStatuses = {
    'upcoming', 'ongoing', 'scheduled', 'pending', 'planned', 'published',
    'approved',
  };
  static const _activeStatuses = {
    'active', 'in_progress', 'in-progress', 'inprogress', 'running', 'open',
    'live', 'started',
  };
  static const _completedStatuses = {
    'completed', 'complete', 'closed', 'ended', 'finished', 'past', 'done',
    'cancelled', 'canceled', 'expired',
  };

  static DateTime? _date(dynamic v) =>
      v == null ? null : DateTime.tryParse(v.toString());

  /// Which tab a campaign belongs to. Uses the server `status` when it is a
  /// value we recognise, otherwise falls back to start/end dates.
  static String tabFor(Map<String, dynamic> c) {
    final status = (c['status'] ?? '').toString().toLowerCase().trim();
    if (_upcomingStatuses.contains(status)) return CampaignTab.upcoming;
    if (_activeStatuses.contains(status)) return CampaignTab.active;
    if (_completedStatuses.contains(status)) return CampaignTab.completed;

    final now = DateTime.now();
    final start = _date(c['start_date']);
    final end = _date(c['end_date']) ?? start;
    if (start != null && start.isAfter(now)) return CampaignTab.upcoming;
    if (end != null && end.add(const Duration(days: 1)).isBefore(now)) {
      return CampaignTab.completed;
    }
    return CampaignTab.active;
  }

  List<Map<String, dynamic>> campaignsFor(String tab) =>
      campaign_list.where((c) => tabFor(c) == tab).toList();

  int countFor(String tab) => campaignsFor(tab).length;

  /// Campaigns worth showing on the Blood home screen: upcoming and active
  /// first, soonest first.
  List<Map<String, dynamic>> get featuredCampaigns {
    final list = campaign_list
        .where((c) => tabFor(c) != CampaignTab.completed)
        .toList()
      ..sort((a, b) {
        final da = _date(a['start_date']) ?? DateTime(2100);
        final db = _date(b['start_date']) ?? DateTime(2100);
        return da.compareTo(db);
      });
    return list;
  }

  void applyFilter() {
    filtered_campaigns.assignAll(campaignsFor(selectedTab.value));
  }

  // ---------------------------------------------------------------------
  // Fetching
  // ---------------------------------------------------------------------

  /// Pulls the campaign list out of whatever envelope the API uses:
  ///   [ ... ]
  ///   { "success": true, "data": [ ... ] }
  ///   { "success": true, "data": { "data": [ ... ], "last_page": 1 } }   (paginated)
  ///   { "data": { "campaigns": [ ... ] } }
  static List<Map<String, dynamic>> _extractCampaigns(dynamic body) {
    dynamic node = body;
    for (var i = 0; i < 4 && node is Map; i++) {
      if (node['data'] != null) {
        node = node['data'];
      } else if (node['campaigns'] != null) {
        node = node['campaigns'];
      } else {
        break;
      }
    }
    if (node is! List) return [];
    return node
        .whereType<Map>()
        .map((e) => Map<String, dynamic>.from(e))
        .toList();
  }

  Future<void> fetchCampaignList() async {
    isLoading(true);
    campaignError('');

    try {
      final token = await StorageService.getToken();
      final uri = Uri.parse('${ApiEndpoints.baseUrl}/blood-donation/campaigns');

      final response = await http.get(uri, headers: {
        'Accept': 'application/json',
        'X-Requested-With': 'XMLHttpRequest',
        if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
      }).timeout(const Duration(seconds: 20));

      debugPrint('GET /blood-donation/campaigns -> ${response.statusCode}: '
          '${response.body.length > 800 ? response.body.substring(0, 800) : response.body}');

      if (response.statusCode == 401 || response.statusCode == 403) {
        campaignError('Your session has expired. Please sign in again.');
        return;
      }
      if (response.statusCode != 200) {
        String? serverMessage;
        try {
          final decoded = jsonDecode(response.body);
          if (decoded is Map) serverMessage = decoded['message']?.toString();
        } catch (_) {}
        campaignError(serverMessage ??
            'Could not load campaigns (error ${response.statusCode}).');
        return;
      }

      final decoded = jsonDecode(response.body);
      if (decoded is Map && decoded['success'] == false) {
        campaignError(
            decoded['message']?.toString() ?? 'Could not load campaigns.');
        return;
      }

      campaign_list.assignAll(_extractCampaigns(decoded));
    } catch (e, st) {
      debugPrint('fetchCampaignList failed: $e\n$st');
      campaignError('Could not load campaigns. Check your connection.');
    } finally {
      isLoading(false);
    }
  }

  fetchCauses() async {
    String? token = await StorageService.getToken();
    // isFetchingCauses(true);r

    try {} finally {}
  }

  // Future<void> createAmbulanceRequest() async {
  //   Get.toNamed(
  //     "/ambulance-map",
  //   );
  // }

  Future<void> registerDonor(int campaignId) async {
    isUploading(true);
    var token = await StorageService.getToken();

    final Map<String, dynamic> payload = {
      "blood_type": blood_group.text,
      "has_donated_before": donated_yet.text,
      "last_donation_date": last_donation_date.text,
      "weight": 75,
      "medical_conditions": "None",
      "location_id": 1
    };

    final response = await http.post(
      Uri.parse("${ApiEndpoints.baseUrl}/campaigns/$campaignId/donors"),
      headers: {
        'Content-Type': 'application/json',
        'X-Requested-With': 'XMLHttpRequest',
        'Authorization': "Bearer $token",
      },
      body: jsonEncode(payload),
    );

    var result = jsonDecode(response.body);

    print("result-1 $result");

    // Get.snackbar('Success', 'Ambulance request successfully submitted.');
    // Get.toNamed("/ambulance-success-request");
    // isUploading(false);
  }
}

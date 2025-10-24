import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redcross/models/user.dart';
import 'package:redcross/scenes/blood_donations/blood_eligibility.dart';
import 'package:redcross/utils/api_endpoints.dart';
import 'package:redcross/utils/storage_service.dart';
import 'package:http/http.dart' as http;

class DonationsController extends GetxController {
  var isLoading = false.obs;
  var isFetchingCauses = false.obs;
  var campaign_list = [].obs;
  var causes_list = [].obs;
  var filtered_campaigns = <Map<String, dynamic>>[].obs;
  var selectedTab = 'ongoing'.obs;

  TextEditingController healthy_today = TextEditingController();
  TextEditingController donated_yet = TextEditingController();
  TextEditingController blood_group = TextEditingController();
  TextEditingController last_donation_date = TextEditingController();

  var isUploading = false.obs;

  @override
  Future onInit() async {
    super.onInit();
    fetchCampaignList();
    fetchCauses();

    ever(campaign_list, (_) => applyFilter());
    ever(selectedTab, (_) => applyFilter());
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

  void applyFilter() {
    if (campaign_list.isEmpty) {
      filtered_campaigns.clear();
      return;
    }

    final tab = selectedTab.value.toLowerCase();
    // filtered_campaigns.assignAll(
    //   campaign_list.where((item) {
    //     final status = (item['status'] ?? '').toString().toLowerCase();
    //     return status ==
    //         tab; // assumes API returns 'upcoming', 'active', 'completed'
    //   }).toList(),
    // );
  }

  fetchCampaignList() async {
    String? token = await StorageService.getToken();
    isLoading(true);

    try {
      http.Response response = await http.get(
          Uri.tryParse(
              '${ApiEndpoints.baseUrl}/${ApiEndpoints.authEndpoints.causes}')!,
          headers: {
            'Authorization': "Bearer $token",
            'X-Requested-With': 'XMLHttpRequest'
          });

      var results = jsonDecode(response.body);
      // print("res - $results");
      causes_list.value = results['data'];
      isFetchingCauses(false);
    } finally {
      isFetchingCauses(false);
    }
  }

  fetchCauses() async {
    String? token = await StorageService.getToken();
    isFetchingCauses(true);

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

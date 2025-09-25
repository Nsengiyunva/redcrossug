import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:redcross/models/user.dart';
import 'package:redcross/utils/api_endpoints.dart';
import 'package:redcross/utils/storage_service.dart';
import 'package:http/http.dart' as http;

class AmbulanceController extends GetxController {
  TextEditingController no_people_hurt = TextEditingController();
  TextEditingController no_ambulances = TextEditingController();
  TextEditingController no_patients = TextEditingController();
  TextEditingController location_field = TextEditingController();

  var isLoading = false.obs;
  var ambulance_list = [].obs;

  var isUploading = false.obs;

  @override
  Future onInit() async {
    super.onInit();
    fetchPendingAmbulances();
  }

  fetchPendingAmbulances() async {
    String? token = await StorageService.getToken();
    isLoading(true);

    try {
      http.Response response = await http.get(
          Uri.tryParse(
              '${ApiEndpoints.baseUrl}/${ApiEndpoints.authEndpoints.ambulance_requests}')!,
          headers: {
            'Authorization': "Bearer $token",
            'X-Requested-With': 'XMLHttpRequest'
          });

      var results = jsonDecode(response.body);
      // print("results ${results}");
      ambulance_list.value = results;
      isLoading(false);
    } catch (e) {
      print(e);
    } finally {
      isLoading(false);
    }
  }

  Future<void> createAmbulanceRequest() async {
    Get.toNamed(
      "/ambulance-map",
    );
  }

  Future<void> submitCreateRequest() async {
    isUploading(true);
    User? retrievedUser = await StorageService.getUser();
    var token = await StorageService.getToken();

    final Map<String, dynamic> payload = {
      "phone_number": retrievedUser?.phone_no,
      "number_of_people": int.tryParse(no_people_hurt.text),
      "number_of_children": int.tryParse(no_people_hurt.text),
      "number_of_critically_ill": int.tryParse(no_patients.text),
      "location": location_field.text
    };

    final response = await http.post(
      Uri.parse(
          "${ApiEndpoints.baseUrl}/${ApiEndpoints.authEndpoints.ambulance_requests}"),
      headers: {
        'Content-Type': 'application/json',
        'X-Requested-With': 'XMLHttpRequest',
        'Authorization': "Bearer $token",
      },
      body: jsonEncode(payload),
    );

    var result = jsonDecode(response.body);

    Get.snackbar('Success', 'Ambulance request successfully submitted.');
    // Get.toNamed("/ambulance-success-request");
    isUploading(false);
  }
}

import 'dart:convert';
import 'package:get/get.dart';
import 'package:redcross/utils/api_endpoints.dart';
import 'package:redcross/utils/storage_service.dart';
import 'package:http/http.dart' as http;

class DonationsController extends GetxController {
  var isLoading = false.obs;
  var campaign_list = [].obs;

  var isUploading = false.obs;

  @override
  Future onInit() async {
    super.onInit();
    fetchCampaignList();
  }

  fetchCampaignList() async {
    String? token = await StorageService.getToken();
    isLoading(true);

    try {
      http.Response response = await http.get(
          Uri.tryParse(
              '${ApiEndpoints.baseUrl}/${ApiEndpoints.authEndpoints.donations}')!,
          headers: {
            'Authorization': "Bearer $token",
            'X-Requested-With': 'XMLHttpRequest'
          });

      var results = jsonDecode(response.body);
      campaign_list.value = results;
      isLoading(false);
    } catch (e) {
      // print(e);
    } finally {
      isLoading(false);
    }
  }

  // Future<void> createAmbulanceRequest() async {
  //   Get.toNamed(
  //     "/ambulance-map",
  //   );
  // }

  // Future<void> submitCreateRequest() async {
  //   isUploading(true);
  //   User? retrievedUser = await StorageService.getUser();
  //   var token = await StorageService.getToken();

  //   final Map<String, dynamic> payload = {
  //     "phone_number": retrievedUser?.phone_no,
  //     "number_of_people": int.tryParse(no_people_hurt.text),
  //     "number_of_children": int.tryParse(no_people_hurt.text),
  //     "number_of_critically_ill": int.tryParse(no_patients.text),
  //     "location": location_field.text
  //   };

  //   final response = await http.post(
  //     Uri.parse(
  //         "${ApiEndpoints.baseUrl}/${ApiEndpoints.authEndpoints.ambulance_requests}"),
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'X-Requested-With': 'XMLHttpRequest',
  //       'Authorization': "Bearer $token",
  //     },
  //     body: jsonEncode(payload),
  //   );

  //   var result = jsonDecode(response.body);

  //   Get.snackbar('Success', 'Ambulance request successfully submitted.');
  //   Get.toNamed("/ambulance-success-request");
  //   isUploading(false);
  // }
}

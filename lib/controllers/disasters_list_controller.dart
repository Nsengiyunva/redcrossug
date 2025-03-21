import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:redcross/utils/api_endpoints.dart';
import 'package:redcross/utils/storage_service.dart';

class DisastersListController extends GetxController {
  TextEditingController donationAmount = TextEditingController();

  var isLoading = false.obs;
  var disasters = [].obs;
  var isDonating = false.obs;

  @override
  Future onInit() async {
    super.onInit();
    fetchData();
  }

  fetchData() async {
    var token = await StorageService.getToken();

    try {
      isLoading(true);
      http.Response response = await http.get(
          Uri.tryParse(
              '${ApiEndpoints.baseUrl}/${ApiEndpoints.authEndpoints.disasters}')!,
          headers: {
            'Authorization': "Bearer $token",
            'X-Requested-With': 'XMLHttpRequest'
          });
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        disasters.value = result["data"];
        isLoading(false);
      } else {
        Get.snackbar('Info', 'No disasters data was found');
      }
    } catch (e) {
      // print('Error while getting data is $e');
      Get.snackbar('Error',
          'An error occured while fetching disasters from the server.');
    } finally {
      isLoading(false);
    }
  }

  Future<void> makePayment(int id) async {
    isDonating(true);

    var token = await StorageService.getToken();
    var user = await StorageService.getUser();

    try {
      final Map<String, dynamic> payload = {
        "amount": 500,
        "phone_no": "256773917523",
        "mobile_network": "MTN"
      };

      http.Response response = await http.post(
          Uri.tryParse(
              '${ApiEndpoints.baseUrl}/disasters/$id/${ApiEndpoints.authEndpoints.donate_payment}')!,
          headers: {
            'Authorization': "Bearer $token",
            'Content-Type': 'application/json'
          },
          body: jsonEncode(payload));

      var result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        Get.snackbar('Info', '${result['message']}');
      }
    } catch (e) {
      // print("error $e");
      Get.snackbar(
          'Error', 'An error occured. Payment request could not be submitted.');
    } finally {
      isDonating(false);
    }
  }
}

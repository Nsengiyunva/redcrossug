import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:redcross/utils/api_endpoints.dart';
import 'package:redcross/utils/storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token'); // Returns null if not found
  }

  fetchData() async {
    String? token = await getToken();

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
        //data returned
        var result = jsonDecode(response.body);
        disasters.value = result["data"];
        isLoading(false);
      } else {
        // print('error fetching data');
      }
    } catch (e) {
      // print('Error while getting data is $e');
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
        "amount": int.parse(donationAmount.text),
        "phone_no": user?.phone_no,
        "mobile_network": "MTN"
      };

      final response = await http.post(
        Uri.parse(
            "${ApiEndpoints.baseUrl}/$id/${ApiEndpoints.authEndpoints.donate_payment}"),
        headers: {
          "X-Requested-With": "XMLHttpRequest",
          "Authorization": "Bearer $token"
        },
        body: jsonEncode(payload),
      );

      print("result ${jsonDecode(response.body)}");
    } catch (e) {
      print("error $e");
    } finally {
      isDonating(false);
    }
  }
}

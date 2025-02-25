import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginController {
  TextEditingController telephoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  TextEditingController noPeopleController = TextEditingController();
  TextEditingController noAmbulancesController = TextEditingController();
  TextEditingController noPatientsController = TextEditingController();

  TextEditingController newPhoneNumber = TextEditingController();

  final fieldControllers = List.generate(5, (index) => TextEditingController());
  final fieldFocusNode = List.generate(5, (index) => FocusNode());

  final Future _prefs = SharedPreferences.getInstance();
  var isLoading = false.obs;

  Future<void> loginPhoneNumber() async {
    //passwordController.text
    //telephoneController.text

    const String url = 'https://urcs-api.taufeeq.dev/api/auth/login';

    isLoading.value = true;

    final Map<String, dynamic> requestBody = {
      "phone_no": "+256775625741",
      "password": "#Satan2023#"
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      final responseData = jsonDecode(response.body);
      var responseMessage = 'Success: ${responseData['message']}';

      print(responseData["user"]);
      // await StorageService.saveToken(responseData['token']);
      // await prefs?.setString('user', responseData['user']['name'] );

      // Get.snackbar('Success', '${responseData['message']}');
      // Get.toNamed('/home', arguments: {'phone_number': "+256775625741"});
    } catch (e) {
      print("Error: $e");
      Get.snackbar('Error', 'An error occurred while signing the form');
    }
  }

  Future<void> submitForm() async {
    Get.toNamed(
      "/enter-otp",
      arguments: {'phone_number': newPhoneNumber.text},
    );
  }

  void clearOTP() {
    for (var controller in fieldControllers) {
      controller.clear();
    }
  }

  String getOtp() {
    return fieldControllers.map((c) => c.text).join();
  }
}

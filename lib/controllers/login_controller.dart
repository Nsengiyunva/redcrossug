import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redcross/models/user.dart';
import 'package:redcross/utils/api_endpoints.dart';
import 'package:redcross/utils/storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginController {
  TextEditingController telephoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  TextEditingController newPhoneNumber = TextEditingController();

  final fieldControllers = List.generate(5, (index) => TextEditingController());
  final fieldFocusNode = List.generate(5, (index) => FocusNode());

  final Future _prefs = SharedPreferences.getInstance();
  var isLoading = false.obs;

  Future<void> saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    String userJson = jsonEncode(user.toJson());
    await prefs.setString('user', userJson);
  }

  // Function to get an object
  Future<User?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString('user');
    if (userJson == null) return null;
    return User.fromJson(jsonDecode(userJson));
  }

  Future<void> loginPhoneNumber() async {
    //passwordController.text
    //telephoneController.text
    isLoading.value = true;

    final Map<String, dynamic> requestBody = {
      "phone_no": "+256775625741",
      "password": "#Satan2023#"
    };

    try {
      final response = await http.post(
        Uri.parse(
            "${ApiEndpoints.baseUrl}/${ApiEndpoints.authEndpoints.login}"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      final responseData = jsonDecode(response.body);
      var responseMessage = 'Success: ${responseData['message']}';

      User user = User(
          name: responseData["user"]["name"],
          phone_no: responseData["user"]["phone_no"]);

      await saveUser(user);

      await StorageService.saveToken(responseData['token']);

      Get.snackbar('Success', '${responseData['message']}');
      Get.toNamed('/home',
          arguments: {'phone_number': responseData["user"]["phone_no"]});
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

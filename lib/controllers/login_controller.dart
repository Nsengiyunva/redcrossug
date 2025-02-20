import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redcross/utils/storage_service.dart';
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
    print("Lets login please");
    // const String url = 'https://urcs-api.taufeeq.dev/api/auth/login';

    // isLoading.value = true;

    // final Map<String, dynamic> requestBody = {
    //   "phone_no": "+256775625741",
    //   "password": "#Satan2023#"
    // };

    // try {
    //   final response = await http.post(
    //     Uri.parse(url),
    //     headers: {'Content-Type': 'application/json'},
    //     body: jsonEncode(requestBody),
    //   );

    //   print(response);

    //   // if (response.statusCode == 201) {
    //   // Success
    //   // final responseData = jsonDecode(response.body);
    //   // var responseMessage = 'Success: ${responseData['message']}';

    //   // await StorageService.saveToken(responseData['token']);
    //   // print( responseMessage );
    //   // final SharedPreferences? prefs = await _prefs;
    //   // await prefs?.setString('token', responseData['token']);
    //   // await prefs?.setString('user', user );

    //   // Get.toNamed('/home', arguments: {'phone_number': "+256775625741"});

    //   // setState(() {
    //   //   responseMessage = 'Success: ${responseData['id']}';
    //   // });
    //   // } else {
    //   //   // Error response
    //   //   // setState(() {
    //   //   //   responseMessage = 'Error: ${response.statusCode}';
    //   //   // });
    //   // }
    // } catch (e) {
    //   print("Error: $e");
    //   Get.snackbar('Error', 'An error occurred while signing the form');
    //   // Handle exceptions like network errors
    //   // setState(() {
    //   //   responseMessage = 'Exception: $e';
    //   // });
    // }
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

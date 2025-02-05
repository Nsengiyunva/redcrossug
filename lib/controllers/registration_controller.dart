import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redcross/utils/api_endpoints.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class RegistrationController extends GetxController {
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController registerDOB = TextEditingController();
  TextEditingController nationality = TextEditingController();
  // TextEditingController nin = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  // TextEditingController newPhoneNumber = TextEditingController();

  final fieldControllers = List.generate(5, (index) => TextEditingController());
  final fieldFocusNode = List.generate(5, (index) => FocusNode());

  final Future _prefs = SharedPreferences.getInstance();
  var isLoading = false.obs;

  Future<void> registerAccount() async {
    // const String url = 'https://urcs-api.taufeeq.dev/api/auth/register';

    isLoading.value = true;

    final Map<String, dynamic> body = {
      "first_name": firstname.value.text,
      "last_name": lastname.value.text,
      "phone_no": "+256703019014",
      "nationality": nationality.value.text,
      "password": password.value.text
    };

    try {
      var url =
          Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.authEndpoints.register);
      var headers = {
        'Content-Type': 'application/json',
        'X-Requested-With': 'XMLHttpRequest'
      };

      final result =
          await http.post(url, body: jsonEncode(body), headers: headers);

      print(result);
    } catch (error) {
      print(error);
    }
  }
}

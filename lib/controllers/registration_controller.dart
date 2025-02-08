import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redcross/utils/api_endpoints.dart';
import 'package:redcross/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

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

  void showToast() {
    Fluttertoast.showToast(
      msg: "Hello, this is a toast message!",
      toastLength: Toast.LENGTH_SHORT, // or Toast.LENGTH_LONG
      gravity: ToastGravity.BOTTOM, // Position: BOTTOM, CENTER, TOP
      backgroundColor: Colors.black54,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

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

      final response =
          await http.post(url, body: jsonEncode(body), headers: headers);

      var result = jsonDecode(response.body);

      print(result);

      if (result["message"] == null) {
        Get.snackbar(
          "Success",
          'Successfully saved.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          borderRadius: 10,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 10),
          icon: const Icon(Icons.check_circle, color: Colors.white),
        );
      } else {
        print(result["message"]);
        // Get.snackbar('Error', '$result["message"]');
        Get.snackbar(
          "Error",
          '$result["message"]',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.primaryRedColor,
          colorText: Colors.white,
          borderRadius: 10,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 10),
          icon: const Icon(Icons.check_circle, color: Colors.white),
        );
      }
    } catch (error) {
      print(error);
    }
  }
}

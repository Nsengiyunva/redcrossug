import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpController extends GetxController {
  final _fieldControllers = List.generate(4, (index) => TextEditingController());
  final _otpFocusNode = List.generate(4, (index) => FocusNode());

  void clearOTP() {
    for (var controller in _fieldControllers) {
      controller.clear();
    }
  }

  String getOtp() {
    return _fieldControllers.map((c) => c.text).join();
  }
}
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redcross/models/user.dart';
import 'package:redcross/scenes/widgets/app_alert_dialog.dart';
import 'package:redcross/utils/colors.dart';
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
  var isLoggingIn = false.obs;

  Future<void> saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    String userJson = jsonEncode(user.toJson());
    await prefs.setString('user', userJson);
  }

  Future<void> loginPhoneNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoggingIn(true);

    final Map<String, dynamic> payload = {
      "phone_no": "+256${telephoneController.text}",
      "password": passwordController.text
    };

    try {
      final response = await http.post(
        Uri.parse("https://urcs-api.taufeeq.dev/api/auth/login"),
        headers: {
          'Content-Type': 'application/json',
          'X-Requested-With': 'XMLHttpRequest'
        },
        body: jsonEncode(payload),
      );

      Map<String, dynamic> responseData = {};
      try {
        final decoded = jsonDecode(response.body);
        if (decoded is Map<String, dynamic>) responseData = decoded;
      } catch (_) {
        // Non-JSON error body (e.g. a proxy/server error page) — fall
        // back to the generic error dialog below instead of crashing.
      }

      final bool isSuccess = response.statusCode >= 200 && response.statusCode < 300;

      if (isSuccess) {
        User user = User(
            name: responseData["user"]?["name"] ?? "",
            phone_no: responseData["user"]?["phone_no"] ?? "");

        await saveUser(user);
        await StorageService.saveToken(responseData['token']);
        await prefs.setBool('isLoggedIn', true);
        isLoggingIn(false);

        // A short, on-brand confirmation instead of a plain snackbar.
        // Auto-dismisses on its own, or the user can tap Continue.
        await AppAlertDialog.show(
          icon: Icons.check_rounded,
          accentColor: AppColors.deepGreenA,
          title: 'Signed in successfully',
          message: user.name.isNotEmpty
              ? "Welcome back, ${user.name}! Taking you to your dashboard..."
              : "Welcome back! Taking you to your dashboard...",
          primaryLabel: 'Continue',
          autoDismissAfter: const Duration(milliseconds: 1600),
        );

        Get.offAllNamed('/home',
            arguments: {'phone_number': responseData["user"]?["phone_no"]});
        return;
      }

      isLoggingIn(false);

      // Account genuinely doesn't exist yet — the most common reason a
      // sign-in fails, and worth a distinct, friendlier popup that nudges
      // toward registration rather than a generic error.
      if (response.statusCode == 404) {
        await AppAlertDialog.show(
          icon: Icons.person_search_rounded,
          accentColor: AppColors.primaryRedColor,
          title: "We couldn't find that account",
          message:
              "This phone number isn't registered with Red Cross Uganda "
              "yet. Double-check the number, or create a new account to "
              "get started.",
          primaryLabel: 'Create an account',
          onPrimary: () => Get.toNamed('/register-account'),
          secondaryLabel: 'Try a different number',
        );
        return;
      }

      // Account exists, but the password (or payload) was rejected.
      if (response.statusCode == 401 || response.statusCode == 422) {
        await AppAlertDialog.show(
          icon: Icons.lock_outline_rounded,
          accentColor: AppColors.primaryRedColor,
          title: 'Sign in failed',
          message: (responseData['message']?.toString().isNotEmpty ?? false)
              ? responseData['message'].toString()
              : "That phone number and password don't match. Please try "
                  "again.",
          primaryLabel: 'Try again',
        );
        return;
      }

      // Anything else (5xx, unexpected payload, etc.)
      await AppAlertDialog.show(
        icon: Icons.error_outline_rounded,
        accentColor: AppColors.primaryRedColor,
        title: 'Something went wrong',
        message: (responseData['message']?.toString().isNotEmpty ?? false)
            ? responseData['message'].toString()
            : "We couldn't sign you in right now. Please try again in a "
                "moment.",
        primaryLabel: 'Try again',
      );
    } catch (e) {
      isLoggingIn(false);
      await AppAlertDialog.show(
        icon: Icons.wifi_off_rounded,
        accentColor: AppColors.primaryRedColor,
        title: 'Connection error',
        message:
            "We couldn't reach the server. Check your internet connection "
            "and try again.",
        primaryLabel: 'Try again',
      );
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

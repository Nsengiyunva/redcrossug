import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redcross/controllers/login_controller.dart';
import 'package:redcross/scenes/widgets/form_password.dart';
import 'package:redcross/scenes/widgets/phone_number_field.dart';
import 'package:redcross/scenes/widgets/red_btn.dart';
import 'package:redcross/utils/colors.dart';
import 'package:redcross/utils/storage_service.dart';

class SignIn extends StatelessWidget {
  SignIn({super.key});

  final LoginController _loginController = Get.put(LoginController());
  String _selectedPhoneCode = "256";

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 600;
    final isDesktop = size.width > 900;

    final horizontalPadding =
        isDesktop ? size.width * 0.25 : (isTablet ? 48.0 : 25.0);
    final verticalPadding = isTablet ? 60.0 : 40.0;

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Obx(() {
        if (_loginController.isLoggingIn.value) {
          return SizedBox(
            height: size.height,
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: AppColors.primaryRedColor),
                  SizedBox(height: 25),
                  Text(
                    "Signing in...",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: "Inter",
                      color: AppColors.blackColor,
                    ),
                  )
                ],
              ),
            ),
          );
        }

        return SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding, vertical: verticalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome Back",
                  style: TextStyle(
                    fontSize: 26,
                    fontFamily: "Manrope",
                    fontWeight: FontWeight.w700,
                    color: AppColors.blackColorF,
                    letterSpacing: StorageService.getSpacing(23),
                  ),
                ),
                const SizedBox(height: 8),
                Center(
                  child: Text(
                    "Good to see you again! Ready to make an impact? Let’s get started.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 17,
                      color: AppColors.greyColorF,
                      height: 1.4,
                      letterSpacing: StorageService.getSpacing(17),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                PhoneFormField(
                  controller: _loginController.telephoneController,
                  onCountryChanged: (code) => _selectedPhoneCode = code,
                  validator: (val) {
                    if (val == null || val.isEmpty) return "Required";
                    if (val.length < 7) return "Invalid phone number";
                    return null;
                  },
                ),
                const SizedBox(height: 25),
                FormPassword(
                  question: 'Password',
                  textEditingController: _loginController.passwordController,
                ),
                const SizedBox(height: 25),
                RedBtn(
                  label: 'Continue',
                  onPressed: () => _loginController.loginPhoneNumber(),
                ),
                const SizedBox(height: 45),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.check_box_rounded,
                          color: AppColors.primaryRedColor,
                          size: 22,
                        ),
                        SizedBox(width: 6),
                        Text(
                          "Keep me Signed In",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontFamily: "Inter",
                            fontSize: 13,
                            color: AppColors.blueColorB,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Center(
                  child: Column(
                    children: [
                      const Text(
                        "Don't have an account?",
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: "Inter",
                          color: AppColors.greyColorF,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.toNamed("/register-account");
                        },
                        child: const Text(
                          "Register",
                          style: TextStyle(
                            fontFamily: "Inter",
                            fontSize: 18,
                            color: AppColors.greyColorF,
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.greyColorF,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

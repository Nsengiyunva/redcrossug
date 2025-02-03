import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redcross/controllers/login_controller.dart';
import 'package:redcross/controllers/registration_controller.dart';
import 'package:redcross/scenes/widgets/country_picker.dart';
import 'package:redcross/scenes/widgets/date_picker.dart';
import 'package:redcross/scenes/widgets/form_password.dart';
import 'package:redcross/utils/colors.dart';

import '../widgets/form_textfield.dart';
import '../widgets/red_btn.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});

  final RegistrationController _registerController =
      Get.put(RegistrationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: SingleChildScrollView(
            child: Container(
          width: double.maxFinite,
          margin: const EdgeInsets.symmetric(vertical: 30.0),
          padding: const EdgeInsets.symmetric(vertical: 80.0, horizontal: 25.0),
          child: Column(
            children: [
              const Text("Lets get to know you",
                  style: TextStyle(
                      fontSize: 20.14,
                      color: AppColors.blackColorF,
                      fontFamily: "Manrope",
                      fontWeight: FontWeight.w600)),
              const SizedBox(height: 10),
              FormTextfield(
                question: 'First Name',
                textEditingController: _registerController.firstname,
              ),
              const SizedBox(height: 10),
              FormTextfield(
                question: 'Last Name',
                textEditingController: _registerController.lastname,
              ),
              const SizedBox(height: 10),
              // FormTextfield(
              //     question: 'Email Address',
              //     textEditingController: _registerController.email),
              // const SizedBox(height: 10),
              // const DatePicker(question: 'Date of Birth'),
              // const SizedBox(height: 10),
              CountryPicker(
                  question: 'Nationality',
                  textEditingController: _registerController.nationality),
              const SizedBox(height: 10),
              // FormTextfield(
              //     question: 'NIN/Passport Number',
              //     textEditingController: _registerController.registerNIN),
              // const SizedBox(height: 10),
              FormPassword(
                  question: 'Password',
                  textEditingController: _registerController.registerPassword),
              const SizedBox(height: 10),
              FormPassword(
                  question: 'Confirm Password',
                  textEditingController:
                      _registerController.registerConfirmPassword),
              const SizedBox(height: 10),
              const Row(
                children: [
                  Icon(
                    Icons.check_box_outline_blank,
                    color: AppColors.whiteColorB,
                    size: 24.0,
                  ),
                  Text("By continuing, you accept our privacy policy",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontFamily: "Inter",
                          fontSize: 10,
                          color: AppColors.greyColorC)),
                ],
              ),
              const SizedBox(height: 5),
              RedBtn(
                label: 'Continue',
                onPressed: () {
                  _registerController.registerAccount();
                  // Get.toNamed("/account-creation-success");
                },
              )
            ],
          ),
        )));
  }
}

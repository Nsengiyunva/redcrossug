import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redcross/controllers/login_controller.dart';
import 'package:redcross/scenes/widgets/country_picker.dart';
import 'package:redcross/scenes/widgets/date_picker.dart';
import 'package:redcross/scenes/widgets/form_password.dart';

import '../widgets/form_textfield.dart';
import '../widgets/red_btn.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});

  final LoginController _loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  color: Color(0xFF545454),
                  fontFamily: "Manrope",
                  fontWeight: FontWeight.w600)),
          const SizedBox(height: 10),
          FormTextfield(
            question: 'Name',
            textEditingController: _loginController.registerName,
          ),
          const SizedBox(height: 10),
          FormTextfield(
              question: 'Email Address',
              textEditingController: _loginController.registerEmail),
          const SizedBox(height: 10),
          const DatePicker(question: 'Date of Birth'),
          const SizedBox(height: 10),
          CountryPicker(
              question: 'Country',
              textEditingController: _loginController.registerCountry),
          const SizedBox(height: 10),
          FormTextfield(
              question: 'NIN/Passport Number',
              textEditingController: _loginController.registerNIN),
          const SizedBox(height: 10),
          FormPassword(
              question: 'Password',
              textEditingController: _loginController.registerPassword),
          const SizedBox(height: 10),
          FormPassword(
              question: 'Confirm Password',
              textEditingController: _loginController.registerConfirmPassword),
          const SizedBox(height: 10),
          const Row(
            children: [
              Icon(
                Icons.check_box_outline_blank,
                color: Color(0xFFE8E8E8),
                size: 24.0,
              ),
              Text("By continuing, you accept our privacy policy",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: "Inter",
                      fontSize: 10,
                      color: Color(0xFF848484))),
            ],
          ),
          const SizedBox(height: 5),
          RedBtn(
            label: 'Continue',
            onPressed: () {
              Get.toNamed("/account-creation-success");
            },
          )
        ],
      ),
    )));
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redcross/controllers/registration_controller.dart';
import 'package:redcross/scenes/widgets/form_password.dart';
import 'package:redcross/utils/colors.dart';

import '../widgets/form_textfield.dart';
import '../widgets/red_btn.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  SignUpState createState() => SignUpState();
}

class SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final RegistrationController _registerController =
      Get.put(RegistrationController());

  void validateForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Form is valid!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: SingleChildScrollView(
            child: Container(
          width: double.maxFinite,
          margin: const EdgeInsets.symmetric(vertical: 30.0),
          padding: const EdgeInsets.symmetric(vertical: 80.0, horizontal: 25.0),
          child: Form(
              key: _formKey,
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
                    validator: (value) {
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  FormTextfield(
                      question: 'Last Name',
                      textEditingController: _registerController.lastname,
                      validator: (value) {
                        return null;
                      }),
                  const SizedBox(height: 10),
                  FormPassword(
                      question: 'Password',
                      textEditingController: _registerController.password),
                  const SizedBox(height: 10),
                  FormPassword(
                      question: 'Confirm Password',
                      textEditingController:
                          _registerController.confirmpassword),
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
              )),
        )));
  }
}

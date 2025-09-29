import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redcross/controllers/registration_controller.dart';
import 'package:redcross/scenes/auth/profile.dart';
import 'package:redcross/scenes/blood_donations/blood_eligibility.dart';
import 'package:redcross/utils/colors.dart';

import '../widgets/form_textfield.dart';
import '../widgets/red_btn.dart';

class DonationRegister extends StatefulWidget {
  const DonationRegister({super.key});

  @override
  DonationRegisterState createState() => DonationRegisterState();
}

class DonationRegisterState extends State<DonationRegister> {
  final _formKey = GlobalKey<FormState>();
  final RegistrationController _registerController =
      Get.put(RegistrationController());

  void validateForm() {
    // if (_formKey.currentState!.validate()) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(content: Text("Form is valid!")),
    //   );
    // }
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
                  const Text("Register as a Donor",
                      style: TextStyle(
                          fontSize: 20.14,
                          color: AppColors.blackColorF,
                          fontFamily: "Manrope",
                          fontWeight: FontWeight.w600)),
                  const SizedBox(height: 10),
                  FormTextfield(
                    no_question: true,
                    isNumberField: false,
                    question: 'Blood Group',
                    textEditingController: _registerController.firstname,
                    validator: (value) {
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  FormTextfield(
                      no_question: true,
                      isNumberField: false,
                      question: 'Last Donation Date',
                      textEditingController: _registerController.lastname,
                      validator: (value) {
                        return null;
                      }),
                  const SizedBox(height: 10),
                  FormTextfield(
                      no_question: true,
                      isNumberField: false,
                      question: 'Have you donated in  the last 3 Months?',
                      textEditingController: _registerController.lastname,
                      validator: (value) {
                        return null;
                      }),
                  FormTextfield(
                      no_question: true,
                      isNumberField: false,
                      question: 'Do you feel healthy today?',
                      textEditingController: _registerController.lastname,
                      validator: (value) {
                        return null;
                      }),
                  const SizedBox(height: 10),
                  RedBtn(
                    label: 'Register',
                    onPressed: () {
                      // Get.toNamed("/blood-donation-eligibility");
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const BloodEligibility()),
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const Profile()),
                      );
                    },
                    child: const Text('Edit Donor  Profile',
                        style: TextStyle(color: AppColors.primaryRedColor)),
                  ),
                ],
              )),
        )));
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redcross/controllers/ambulance_controller.dart';
import 'package:redcross/scenes/ambulances/ambulance_success.dart';
import 'package:redcross/scenes/widgets/form_textfield.dart';
import 'package:redcross/scenes/widgets/red_btn.dart';
import 'package:redcross/utils/colors.dart';

class AmbulanceForm extends StatelessWidget {
  AmbulanceForm({super.key});

  final AmbulanceController ambulanceController =
      Get.put(AmbulanceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: AppBar(
            title: const Text("Commercial Ambulance",
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w600,
                    color: AppColors.blackColor)),
            leading: const BackButton() // Back button added here
            ),
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 30.0),
            padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Ambulance Information",
                  style: TextStyle(
                      fontSize: 20.14,
                      fontFamily: "Manrope",
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF545454)),
                ),
                const SizedBox(height: 25),
                FormTextfield(
                  no_question: true,
                  isNumberField: true,
                  question: 'Ambulance Type',
                  textEditingController: ambulanceController.no_people_hurt,
                  validator: (value) {
                    return null;
                  },
                ),
                const SizedBox(height: 25),
                FormTextfield(
                  no_question: true,
                  isNumberField: true,
                  question: 'Purpose of Ambulance',
                  textEditingController: ambulanceController.no_ambulances,
                  validator: (value) {
                    return null;
                  },
                ),
                const SizedBox(height: 25),
                FormTextfield(
                  no_question: true,
                  isNumberField: true,
                  question: 'Service Duration',
                  textEditingController: ambulanceController.no_patients,
                  validator: (value) {
                    return null;
                  },
                ),
                const SizedBox(height: 25),
                FormTextfield(
                  no_question: true,
                  isNumberField: true,
                  question: 'Service Timing',
                  textEditingController: ambulanceController.no_patients,
                  validator: (value) {
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                const Row(
                  children: [
                    Icon(
                      Icons.check_box_outline_blank,
                      color: AppColors.whiteColorB,
                      size: 24.0,
                    ),
                    Text("By continuing, you accept our Ambulance Policy",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontFamily: "Inter",
                            fontSize: 10,
                            color: AppColors.greyColorC)),
                  ],
                ),
                const SizedBox(height: 10),
                RedBtn(
                    label: "Continue",
                    onPressed: () {
                      // ambulanceController.createAmbulanceRequest();
                      // Get.toNamed('/ambulance-success-request');
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const AmbulanceSuccess()),
                      );
                    })
              ],
            ),
          ),
        ));
  }
}

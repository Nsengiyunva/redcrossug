// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redcross/controllers/login_controller.dart';
import 'package:redcross/scenes/widgets/ambulance_status_item.dart';
import 'package:redcross/utils/colors.dart';

class AmbulanceStatus extends StatelessWidget {
  AmbulanceStatus({super.key});

  final LoginController _formController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: AppBar(
            title: const Text("Ambulance Status",
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Inter",
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w600)),
            leading: const BackButton() // Back button added here
            ),
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 20.0),
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 25),
            child: Column(
              children: [
                Center(
                  child: Image.asset('assets/images/ambulance.png',
                      width: 300, height: 300),
                ),
                Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 15),
                    decoration: BoxDecoration(
                        color: AppColors.whiteColorC,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(children: [
                      AmbulanceStatusItem(
                          label: 'Status', noComponent: true, value: ""),
                      const SizedBox(height: 25),
                      AmbulanceStatusItem(
                          label: 'Number of Ambulances',
                          noComponent: false,
                          value: "01"),
                      const SizedBox(height: 25),
                      AmbulanceStatusItem(
                          label: 'Ambulances',
                          noComponent: false,
                          value: "Red Cross Nakasero"),
                      const SizedBox(height: 100),
                      // GestureDetector(
                      //   onTap: () {
                      //     // Get.toNamed("/home");
                      //   },
                      //   child: const Text("Back to Home",
                      //       style: TextStyle(
                      //           fontSize: 14,
                      //           color: AppColors.blackColor,
                      //           fontFamily: "Inter")),
                      // )
                    ])),
              ],
            ),
          ),
        ));
  }
}

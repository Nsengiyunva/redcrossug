import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redcross/controllers/ambulance_controller.dart';
import 'package:redcross/scenes/ambulances/ambulance_progress_box.dart';
import 'package:redcross/scenes/widgets/ambulance_list_item.dart';
import 'package:redcross/scenes/widgets/red_btn.dart';
import 'package:redcross/scenes/widgets/red_btn_icon.dart';
import 'package:redcross/utils/colors.dart';

class AmbulanceServicesHome extends StatelessWidget {
  AmbulanceServicesHome({super.key});

  final AmbulanceController ambulanceController =
      Get.put(AmbulanceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: AppBar(
            title: const Text(""),
            leading: const BackButton() // Back button added here
            ),
        body: Obx(() {
          if (ambulanceController.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return SingleChildScrollView(
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 30.0),
              padding:
                  const EdgeInsets.symmetric(vertical: 30.0, horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Ambulance Services"),
                  Container(
                      margin: const EdgeInsets.symmetric(vertical: 15),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 25),
                      child: Column(
                        children: [
                          Center(
                            child: Image.asset('assets/images/ambulance.png',
                                width: 230, height: 214.37),
                          ),
                        ],
                      )),
                  const SizedBox(height: 10),
                  const AmbulanceProgressBox(),
                  const SizedBox(height: 10),
                  RedBtn(
                      label: 'Commercial Ambulance',
                      onPressed: () {
                        Get.toNamed("/ambulance-request-form");
                      }),
                  const SizedBox(height: 10),
                  RedBtn(
                      label: 'Emergency Response',
                      onPressed: () {
                        Get.toNamed("/ambulance-emergency-form");
                      }),
                  const SizedBox(height: 10),
                  const Center(
                      child: Column(
                    children: [
                      Center(child: Text("RedCross Ambulance Hotlines:")),
                      SizedBox(height: 25),
                      Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("+256 410 678 564"),
                          Text("+256 410 678 896")
                        ],
                      ))
                    ],
                  ))
                ],
              ),
            ),
          );
        }));
  }
}

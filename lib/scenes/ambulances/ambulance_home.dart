import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redcross/controllers/ambulance_controller.dart';
import 'package:redcross/scenes/ambulances/ambulance_form.dart';
import 'package:redcross/scenes/ambulances/ambulance_progress_box.dart';
import 'package:redcross/scenes/widgets/ambulance_list_item.dart';
import 'package:redcross/scenes/widgets/red_btn.dart';
import 'package:redcross/scenes/widgets/red_btn_icon.dart';
import 'package:redcross/utils/colors.dart';
import 'package:redcross/utils/storage_service.dart';

class AmbulanceHome extends StatelessWidget {
  AmbulanceHome({super.key});

  final AmbulanceController ambulanceController =
      Get.put(AmbulanceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.bgColor,
        body: Obx(() {
          if (ambulanceController.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return SingleChildScrollView(
            child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 103, horizontal: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Ambulance Services",
                        style: TextStyle(
                            fontFamily: "Inter",
                            fontSize: 26.33,
                            fontWeight: FontWeight.w700,
                            letterSpacing: StorageService.getSpacing(26),
                            height: StorageService.getHeight(30, 26))),
                    const SizedBox(height: 75),
                    Container(
                      child: Center(
                        child: Image.asset('assets/images/ambulance.png',
                            width: 230, height: 214.37),
                      ),
                    ),
                    const SizedBox(height: 75),
                    RedBtn(
                        label: 'Commercial Ambulance',
                        squared: true,
                        font: 14,
                        iconned: true,
                        icon_name: "alert",
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => AmbulanceForm()),
                          );
                          // Get.toNamed("/ambulance-request-form");
                        }),
                    const SizedBox(height: 10),
                    RedBtn(
                        is_white: true,
                        label: 'Emergency Response',
                        squared: true,
                        font: 14,
                        iconned: true,
                        icon_name: "alert",
                        onPressed: () {
                          // Get.toNamed("/ambulance-request-form");
                        }),
                    const SizedBox(height: 75),
                    const Center(
                        child: Text(
                      "RedCross Ambulance Hotlines:",
                      style: TextStyle(
                          fontFamily: "Inter",
                          height: 1.5,
                          fontSize: 13.16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.blackColor),
                    )),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("+256 770 123 123",
                            style: TextStyle(
                                color: AppColors.blueColorA,
                                fontSize: 14.7,
                                fontWeight: FontWeight.w400,
                                height: StorageService.getHeight(25, 14),
                                letterSpacing: StorageService.getSpacing(14),
                                fontFamily: "Inter")),
                        const SizedBox(width: 15),
                        Text("+256 410 678 896",
                            style: TextStyle(
                                color: AppColors.blueColorA,
                                fontSize: 14.7,
                                fontWeight: FontWeight.w400,
                                height: StorageService.getHeight(25, 14),
                                letterSpacing: StorageService.getSpacing(14),
                                fontFamily: "Inter")),
                      ],
                    )
                  ],
                )),
          );
        }));
  }
}

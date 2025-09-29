import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redcross/scenes/ambulances/ambulance_current.dart';
import 'package:redcross/scenes/blood_donations/blood_donation_history.dart';
import 'package:redcross/scenes/widgets/red_badge.dart';
import 'package:redcross/scenes/widgets/red_btn.dart';
import 'package:redcross/utils/colors.dart';

class BloodDonationSuccess extends StatelessWidget {
  // final String button_label;
  // final String title;
  // final String success_message;

  const BloodDonationSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: AppBar(
            title: const Text("",
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w600,
                    color: AppColors.blackColor)),
            leading: const BackButton() // Back button added here
            ),
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const RedBadge(),
                const SizedBox(height: 20),
                const SizedBox(
                  width: 152,
                  child: Text(
                    "Successful",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: 27.37,
                        color: AppColors.primaryRedColor,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(height: 15),
                const Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal:
                          16.0), // Uniform padding of 16 pixels on all sides
                  child: SizedBox(
                    width: 245.28,
                    child: Text("Thank you",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 19.07,
                            fontWeight: FontWeight.w400,
                            color: AppColors.blackColor,
                            fontFamily: "Inter")),
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  child: RedBtn(
                    label: "Check Status",
                    onPressed: () {
                      // Get.toNamed("/check-ambulance_status");
                      // Get.toNamed(
                      //   "/ambulance-home",
                      // );
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const BloodDonationHistory()),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

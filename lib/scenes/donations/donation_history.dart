import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redcross/scenes/widgets/donation_history_item.dart';
import 'package:redcross/utils/colors.dart';

class DonationHistory extends StatelessWidget {
  const DonationHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: AppBar(
          title: const Text("Back"),
        ),
        body: SingleChildScrollView(
            child: Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(vertical: 20.0),
                padding:
                    const EdgeInsets.symmetric(vertical: 30.0, horizontal: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Donation  History"),
                    const SizedBox(height: 25),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("All Donations"),
                        Text("Filter"),
                        Text("")
                      ],
                    ),
                    const SizedBox(height: 15),
                    DonationHistoryItem(onPressed: () {
                      Get.toNamed("/donation-receipt");
                    }),
                    const SizedBox(height: 10),
                    DonationHistoryItem(onPressed: () {}),
                    const SizedBox(height: 10),
                    DonationHistoryItem(onPressed: () {}),
                    const SizedBox(height: 10),
                    DonationHistoryItem(onPressed: () {}),
                    const SizedBox(height: 10),
                    TextButton(
                        onPressed: () {
                          Get.toNamed("/donation-receipt");
                        },
                        child: const Text("",
                            style: TextStyle(
                                fontFamily: "Inter",
                                fontSize: 14.81,
                                fontWeight: FontWeight.w500,
                                color: AppColors.greyColorJ)))
                  ],
                ))));
  }
}

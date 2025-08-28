import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redcross/scenes/widgets/red_btn.dart';
import 'package:redcross/scenes/widgets/text_box_area.dart';
import 'package:redcross/utils/colors.dart';

class DonationCampaignDetails extends StatelessWidget {
  const DonationCampaignDetails({super.key});

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
          padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  width: 327,
                  height: 172,
                  decoration: BoxDecoration(
                    color: AppColors.yellowColorA,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Text("Logo"),
                  )),
              const SizedBox(height: 10),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Rotary Nakawa"),
                        Text("Blood Donation Drive")
                      ],
                    ),
                    Container(
                        width: 86,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(3)),
                        child: const Center(child: Text("Upcoming"))),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                      "Join us and help save lives. All eligible donors welcome. Snacks and refreshments will  be provided.")),
              const SizedBox(height: 15),
              Container(
                  padding: const EdgeInsets.all(20),
                  child: const Row(
                    children: [
                      Text("Date:"),
                      Text("Saturday, August 10th, 2025")
                    ],
                  )),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text("Rate/Review"),
                        const Row(children: [
                          Icon(Icons.star, color: AppColors.primaryRedColor),
                          Icon(Icons.star, color: AppColors.primaryRedColor),
                          Icon(Icons.star, color: AppColors.primaryRedColor),
                          Icon(Icons.star_half,
                              color: AppColors.primaryRedColor), // half star
                          Icon(Icons.star_border,
                              color: AppColors.primaryRedColor),
                        ]),
                        const SizedBox(height: 15),
                        const TextBoxArea(),
                        const SizedBox(height: 15),
                        RedBtn(
                            label: 'Submit',
                            onPressed: () => {
                                  Get.toNamed("/blood-donation-register",
                                      arguments: {})
                                })
                      ]))
            ],
          ),
        )));
  }
}

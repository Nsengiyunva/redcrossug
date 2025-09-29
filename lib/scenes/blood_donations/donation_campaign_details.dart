import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redcross/scenes/blood_donations/donation_register.dart';
import 'package:redcross/scenes/widgets/blood_donation_detail_item.dart';
import 'package:redcross/scenes/widgets/red_btn.dart';
import 'package:redcross/scenes/widgets/text_box_area.dart';
import 'package:redcross/utils/colors.dart';
import 'package:redcross/utils/storage_service.dart';

class DonationCampaignDetails extends StatelessWidget {
  final Map<String, dynamic> campaign;

  const DonationCampaignDetails({super.key, required this.campaign});

  Map<String, dynamic> displayColor(String status) {
    switch (status) {
      case "ongoing":
        return {
          "color": AppColors.yellowColorB,
          "textColor": AppColors.deepYellowA
        };

      case "completed":
        return {
          "color": AppColors.redColorH,
          "textColor": AppColors.primaryRedColor
        };

      case "active":
        return {
          "color": AppColors.greenColorB,
          "textColor": AppColors.deepGreenA
        };
      default:
        return {};
    }
  }

  @override
  Widget build(BuildContext context) {
    var options = displayColor(campaign["status"]);
    print("${campaign["status"]}");

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
                    color: AppColors.redColorE,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.water_drop_outlined,
                      size: 106, // this sets both height & width together
                      color: AppColors.primaryRedColor,
                    ),
                  )),
              const SizedBox(height: 10),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 219,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("${campaign["name"]}",
                              style: TextStyle(
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 17,
                                  height: StorageService.getHeight(20, 17))),
                        ],
                      ),
                    ),
                    Container(
                        width: 86,
                        height: 24,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: options["color"],
                            borderRadius: BorderRadius.circular(6)),
                        child: Center(
                            child: Text(campaign["status"].toUpperCase(),
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: "Inter",
                                    color: options["textColor"],
                                    fontWeight: FontWeight.w500,
                                    letterSpacing:
                                        StorageService.getSpacing(12),
                                    height:
                                        StorageService.getHeight(12, 12))))),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Text(
                      "Join us and help save lives. All eligible donors welcome. Snacks and refreshments will  be provided.",
                      style: TextStyle(
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w400,
                          height: StorageService.getHeight(20, 12),
                          fontSize: 12))),
              const SizedBox(height: 15),
              Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                  child: Column(
                    children: [
                      const BloodDonationDetailItem(
                        label: 'Date',
                        value: 'Saturday, August 10th, 2025',
                      ),
                      const SizedBox(height: 5),
                      const BloodDonationDetailItem(
                        label: 'Time',
                        value: '9:00AM - 4:00PM',
                      ),
                      const SizedBox(height: 5),
                      const BloodDonationDetailItem(
                        label: 'Location',
                        value: 'Mulago',
                      ),
                      const SizedBox(height: 10),
                      if (campaign["status"] == "completed")
                        Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 5),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Rate/Review",
                                      style: TextStyle(
                                          fontSize: 12.16,
                                          fontFamily: "Inter",
                                          color: AppColors.primaryRedColor,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing:
                                              StorageService.getSpacing(12),
                                          height: StorageService.getHeight(
                                              14, 12))),
                                  const SizedBox(height: 5),
                                  const Row(children: [
                                    Icon(Icons.star,
                                        color: AppColors.primaryRedColor),
                                    Icon(Icons.star,
                                        color: AppColors.primaryRedColor),
                                    Icon(Icons.star,
                                        color: AppColors.primaryRedColor),
                                    Icon(Icons.star_half,
                                        color: AppColors
                                            .primaryRedColor), // half star
                                    Icon(Icons.star_border,
                                        color: AppColors.primaryRedColor),
                                  ]),
                                  const SizedBox(height: 15),
                                  const TextBoxArea(),
                                  const SizedBox(height: 15),
                                  RedBtn(
                                      label: 'Submit',
                                      squared: true,
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const DonationRegister()),
                                        );
                                        // Get.toNamed("/ambulance-request-forsm");
                                      })
                                ])),
                    ],
                  )),
            ],
          ),
        )));
  }
}

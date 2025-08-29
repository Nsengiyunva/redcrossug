import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redcross/utils/colors.dart';

class BloodDonationHistoryItem extends StatelessWidget {
  // final String title;
  // final String subtitle;
  // final String date;
  // final String location;
  // final String photo;
  // final int id;

  const BloodDonationHistoryItem({
    super.key,
    // required this.id,
    // required this.title,
    // required this.subtitle,
    // required this.date,
    // required this.location,
    // required this.photo
  });

  @override
  Widget build(BuildContext context) {
    // print("pic ${photo}");

    return GestureDetector(
      onTap: () {
        Get.toNamed("/blood-history-details",
            arguments: {'title': "Donation Campaign Details", 'id': 1});
      },
      child: Container(
          height: 66.66,
          width: 335.14,
          padding: const EdgeInsets.only(left: 10, right: 2),
          decoration: BoxDecoration(
              color: AppColors.whiteColorC,
              borderRadius: BorderRadius.circular(10)),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    width: 34.25,
                    height: 34.25,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColors.redColorE),
                    child: const Center(
                        child: Icon(Icons.water_drop,
                            size: 19.05, color: AppColors.primaryRedColor))),
                Expanded(
                    child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("NITA-U Staff Donation",
                              style: TextStyle(
                                  color: AppColors.blackColor,
                                  fontFamily: "Inter",
                                  fontSize: 12.96,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.bold,
                                  height: 1.25)),
                          Text("May 10, 2025",
                              style: TextStyle(
                                  color: AppColors.greyColorL,
                                  fontFamily: "Inter",
                                  fontSize: 11.11,
                                  fontStyle: FontStyle.normal,
                                  letterSpacing: -0.22,
                                  height: 1.32)),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Text("01"), Text("Units")],
                      )
                    ],
                  ),
                ))
              ])),
    );
  }
}

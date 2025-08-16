import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redcross/utils/colors.dart';

class DonationHistoryItem extends StatelessWidget {
  // final String title;
  // final String subtitle;
  // final String date;
  // final String location;
  // final String photo;
  // final int id;

  const DonationHistoryItem({
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
    return GestureDetector(
      onTap: () {
        // Get.toNamed("/disaster-details", arguments: {'title': title, 'id': id});
      },
      child: Container(
          height: 66.66,
          width: 335.14,
          padding: const EdgeInsets.only(left: 15, right: 5),
          decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(10)),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
                width: 34.25,
                height: 34.25,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.redColorE),
                child: const Center(
                  child: Icon(
                    Icons.water_drop_outlined,
                    color: AppColors.primaryRedColor,
                    size: 19.05,
                  ),
                )),
            Expanded(
                child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: const Column(
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
                  SizedBox(height: 5),
                  Text("May 10, 2025",
                      style: TextStyle(
                          color: AppColors.blackColor,
                          fontFamily: "Inter",
                          fontSize: 11.11,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold,
                          height: 1.25)),
                ],
              ),
            )),
            const Padding(
                padding: EdgeInsets.only(right: 15, left: 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("01",
                        style: TextStyle(
                          color: AppColors.blackColor,
                          fontFamily: "Inter",
                          fontSize: 14.81,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w700,
                        )),
                    Text("Units",
                        style: TextStyle(
                          color: AppColors.greenColorA,
                          fontFamily: "Inter",
                          fontSize: 11.11,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                        ))
                  ],
                ))
          ])),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redcross/utils/colors.dart';

class BloodDonationListItem extends StatelessWidget {
  // final String title;
  // final String subtitle;
  // final String date;
  // final String location;
  // final String photo;
  // final int id;

  const BloodDonationListItem({
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
        // Get.toNamed("/disaster-details", arguments: {'title': title, 'id': id});
      },
      child: Container(
          height: 97,
          padding: const EdgeInsets.only(left: 10, right: 2),
          decoration: const BoxDecoration(color: AppColors.whiteColor),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
              width: 87,
              height: 81,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: AppColors.yellowColorA),
            ),
            Expanded(
                child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Rotary Nakawa Blood",
                      style: TextStyle(
                          color: AppColors.blackColor,
                          fontFamily: "Inter",
                          fontSize: 14.02,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold,
                          height: 1.25)),
                  Text("Donation Drive",
                      style: TextStyle(
                          color: AppColors.blackColor,
                          fontFamily: "Inter",
                          fontSize: 14.02,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold,
                          height: 1.25)),
                  Text("Old Industrial Park, Nakawa Plot 11",
                      style: TextStyle(
                          color: AppColors.greyColorL,
                          fontFamily: "Inter",
                          fontSize: 7.82,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.22,
                          height: 1.32)),
                  SizedBox(height: 10),
                  const Padding(
                      padding: EdgeInsets.only(right: 5.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.access_time_rounded,
                            color: AppColors.primaryRedColor,
                            size: 6.21,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 2),
                            child: Text('Tuesday 23rd December | 10AM-5PM',
                                style: TextStyle(
                                    color: AppColors.primaryRedColor,
                                    fontFamily: "Inter",
                                    fontSize: 7.06,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: -0.2,
                                    height: 1.32)),
                          )
                        ],
                      ))
                ],
              ),
            ))
          ])),
    );
  }
}

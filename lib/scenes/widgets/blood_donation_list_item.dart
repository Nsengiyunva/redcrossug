import 'package:flutter/material.dart';
import 'package:redcross/utils/colors.dart';

class BloodDonationListItem extends StatelessWidget {
  final String name;
  final String location;
  final String date;
  final String time;
  // final String photo;
  // final int id;
  final VoidCallback onPressed;

  BloodDonationListItem(
      {super.key,
      // required this.id,
      required this.name,
      // required this.subtitle,
      required this.date,
      required this.time,
      required this.location,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    // print("pic ${photo}");

    return GestureDetector(
      onTap: onPressed,
      //() {
      // Get.toNamed("/donation-campaign-details",
      //     arguments: {'title': "Donation Campaign Details", 'id': 1});
      //},
      child: Container(
          height: 107,
          padding: const EdgeInsets.only(left: 10, right: 2),
          decoration: const BoxDecoration(color: AppColors.whiteColor),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
                width: 87,
                height: 81,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.redColorM,
                ),
                child: const Center(
                    child: SizedBox(
                  width: 62,
                  height: 62,
                  child: Icon(Icons.water_drop_outlined,
                      size: 49, color: AppColors.primaryRedColor),
                ))),
            Expanded(
                child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      width: 163,
                      child: Text("${name}",
                          style: const TextStyle(
                              color: AppColors.blackColor,
                              fontFamily: "Inter",
                              fontSize: 14.02,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold,
                              height: 1.25))),
                  const SizedBox(height: 5),
                  Text("${location}",
                      style: const TextStyle(
                          color: AppColors.greyColorL,
                          fontFamily: "Inter",
                          fontSize: 7.82,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.22,
                          height: 1.32)),
                  const SizedBox(height: 10),
                  Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.access_time_rounded,
                            color: AppColors.primaryRedColor,
                            size: 6.21,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 2),
                            child: Text('${date} | ${time}',
                                style: const TextStyle(
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

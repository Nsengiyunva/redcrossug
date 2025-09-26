import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redcross/scenes/widgets/donation_card_progress.dart';
import 'package:redcross/utils/colors.dart';

class DonationListingItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onPressed;
  // final String date;
  // final String location;
  // final String photo;
  // final int id;

  const DonationListingItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onPressed,
    // required this.location,
    // required this.photo
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      //() {
      // Get.toNamed("/donation-category-details");
      // },
      child: Container(
          height: 107,
          padding: const EdgeInsets.only(left: 10, right: 2),
          decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(15)),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
                width: 99,
                height: 89.42,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.black, // border color
                    width: 1.0, // border width
                  ),
                ),
                child:
                    Center(child: Image.asset('assets/images/ambulance.png'))),
            Expanded(
                child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontFamily: "Inter",
                          fontSize: 11.23,
                          fontWeight: FontWeight.w500,
                          color: AppColors.blackColorG)),
                  Text(subtitle,
                      style: const TextStyle(
                          fontFamily: "Inter",
                          fontSize: 11.23,
                          fontWeight: FontWeight.w500,
                          color: AppColors.blackColorG)),
                  const SizedBox(height: 10),
                  DonationCardProgress()
                ],
              ),
            ))
          ])),
    );
  }
}

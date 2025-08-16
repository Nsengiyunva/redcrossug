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
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text("xx")],
              ),
            ))
          ])),
    );
  }
}

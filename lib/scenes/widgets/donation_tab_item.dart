// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:redcross/utils/colors.dart';

class DonationTabItem extends StatelessWidget {
  final String label;
  final bool active;

  const DonationTabItem({super.key, required this.label, required this.active});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SizedBox(
      width: 120,
      height: 36, // custom width
      child: ElevatedButton(
        onPressed: () {
          // Get.toNamed("/donations-categories");
        },
        style: ElevatedButton.styleFrom(
          backgroundColor:
              active ? AppColors.primaryRedColor : AppColors.whiteColor,
          foregroundColor: Colors.white, // text color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5), // rounded corners
          ),
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        ),
        child: Text(label,
            style: TextStyle(
                fontFamily: "Inter",
                fontSize: 12.3,
                color: active ? AppColors.whiteColor : AppColors.blackColorG,
                fontWeight: FontWeight.bold)),
      ),
    ));
  }
}

import 'package:flutter/material.dart';
import 'package:redcross/utils/colors.dart';

class DonationTabItem extends StatelessWidget {
  final String label;

  const DonationTabItem({super.key, required this.label});

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
          backgroundColor: AppColors.whiteColor,
          foregroundColor: Colors.white, // text color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5), // rounded corners
            // side: const BorderSide(
            //     color: Colors.black,
            //     width: 0), // border
          ),
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        ),
        child: Text(label,
            style: const TextStyle(
                fontFamily: "Inter",
                fontSize: 12.3,
                fontWeight: FontWeight.bold,
                color: AppColors.blackColor)),
      ),
    ));
  }
}

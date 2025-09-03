import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redcross/utils/colors.dart';

class NavListItems extends StatelessWidget {
  final String label;
  final String subtitle;
  final VoidCallback onPressed;

  const NavListItems(
      {super.key,
      required this.label,
      required this.subtitle,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label,
                style: const TextStyle(
                    fontFamily: "Inter",
                    fontSize: 14.81,
                    fontWeight: FontWeight.w700,
                    color: AppColors.blackColor)),
            TextButton(
                onPressed: onPressed,
                //() {
                // Get.toNamed("/blood-donations-campaigns-list");
                //  },
                child: Text(subtitle,
                    style: const TextStyle(
                        fontFamily: "Inter",
                        fontSize: 14.81,
                        fontWeight: FontWeight.w500,
                        color: AppColors.greyColorJ)))
          ],
        ));
  }
}

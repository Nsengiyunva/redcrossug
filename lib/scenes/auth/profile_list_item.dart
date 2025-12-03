// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:redcross/utils/colors.dart';

class ProfileListItem extends StatelessWidget {
  String label;
  final VoidCallback onPressed;

  ProfileListItem({super.key, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: const BoxDecoration(
            border: Border(
                bottom: BorderSide(color: AppColors.greyColorE, width: 1.0))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label,
                style: const TextStyle(
                    fontSize: 13.8,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w400,
                    color: AppColors.blackColorE)),
            const Icon(
              Icons.arrow_right,
              color: AppColors.primaryRedColor,
              size: 15.51,
            ),
          ],
        ),
      ),
    );
  }
}

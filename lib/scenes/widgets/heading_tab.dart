// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:redcross/utils/colors.dart';
import 'package:redcross/utils/storage_service.dart';

class HeadingTab extends StatelessWidget {
  String title;
  bool active;
  final VoidCallback onPressed;

  HeadingTab(
      {super.key,
      required this.title,
      required this.active,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
          padding: const EdgeInsets.only(bottom: 4),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: active ? AppColors.primaryRedColor : Colors.transparent,
                width: active ? 3 : 0,
              ),
            ),
          ),
          child: Text(title.toUpperCase(),
              style: TextStyle(
                  fontFamily: "Inter",
                  fontSize: 14,
                  color:
                      active ? AppColors.primaryRedColor : AppColors.greyColorP,
                  fontWeight: FontWeight.w500,
                  letterSpacing: StorageService.getSpacing(14)))),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:redcross/utils/colors.dart';
import 'package:redcross/utils/storage_service.dart';

class HeadingTab extends StatelessWidget {
  String title;
  bool active;

  HeadingTab({super.key, required this.title, required this.active});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(bottom: 4),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: active ? AppColors.primaryRedColor : Colors.transparent,
              width: active ? 3 : 0,
            ),
          ),
        ),
        child: Text('${title}'.toUpperCase(),
            style: TextStyle(
                fontFamily: "Inter",
                fontSize: 14,
                color:
                    active ? AppColors.primaryRedColor : AppColors.greyColorP,
                fontWeight: FontWeight.w500,
                letterSpacing: StorageService.getSpacing(14))));
  }
}

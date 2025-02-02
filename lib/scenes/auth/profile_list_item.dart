import 'package:flutter/material.dart';
import 'package:redcross/utils/colors.dart';

class ProfileListItem extends StatelessWidget {
  const ProfileListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: AppColors.greyColorE, width: 1.0))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Community"),
          Icon(
            Icons.arrow_right,
            color: AppColors.primaryRedColor,
            size: 15.51,
          ),
        ],
      ),
    );
  }
}

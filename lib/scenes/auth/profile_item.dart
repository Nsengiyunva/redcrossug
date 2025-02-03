import 'package:flutter/material.dart';
import 'package:redcross/utils/colors.dart';

class ProfileItem extends StatelessWidget {
  const ProfileItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Container(
            width: 72.69,
            height: 72.69,
            margin: const EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
                color: AppColors.greyColorB,
                borderRadius: BorderRadius.circular(50),
                border:
                    Border.all(width: 1.0, color: AppColors.primaryRedColor)),
          ),
        ),
        const SizedBox(width: 15),
        const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Musoke Asadu",
                style: TextStyle(
                    fontSize: 18.39,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w600,
                    color: AppColors.blackColorD)),
            SizedBox(height: 10),
            Text("+256756798723",
                style: TextStyle(
                    fontSize: 13.79,
                    color: AppColors.blackColorD,
                    fontWeight: FontWeight.w400))
          ],
        )
      ],
    ));
  }
}

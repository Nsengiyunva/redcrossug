import 'package:flutter/material.dart';
import 'package:redcross/utils/colors.dart';

class ProfileItem extends StatelessWidget {
  final String name;
  final String phone;
  const ProfileItem({super.key, required this.name, required this.phone});

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
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(50),
                border: Border.all(width: 0, color: AppColors.whiteColor)),
          ),
        ),
        const SizedBox(width: 15),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name,
                style: const TextStyle(
                    fontSize: 18.39,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w600,
                    color: AppColors.blackColorD)),
            const SizedBox(height: 10),
            Text(phone,
                style: const TextStyle(
                    fontSize: 13.79,
                    color: AppColors.blackColorD,
                    fontWeight: FontWeight.w400))
          ],
        )
      ],
    ));
  }
}

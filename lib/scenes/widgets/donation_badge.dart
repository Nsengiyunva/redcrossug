import 'package:flutter/material.dart';
import 'package:redcross/utils/colors.dart';

class DonationBadge extends StatelessWidget {
  final String title;
  final String icon_name;
  final VoidCallback onPressed;

  const DonationBadge(
      {super.key,
      required this.title,
      required this.icon_name,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final iconMap = <String, IconData>{
      'blood_icon': Icons.bloodtype_rounded,
      'gala': Icons.wrap_text_rounded,
    };

    final iconData = iconMap[icon_name] ?? Icons.error;

    return GestureDetector(
        onTap: onPressed,
        child: Container(
            width: 160.94,
            height: 83,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 0),
            margin: const EdgeInsets.only(left: 20.0),
            decoration: BoxDecoration(
              color: AppColors.redColorD,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
              child: Column(
                children: [
                  Icon(
                    iconData,
                    color: AppColors.primaryRedColor,
                    size: 32,
                  ),
                  const SizedBox(height: 8),
                  Text(title,
                      style: const TextStyle(
                          fontFamily: "Inter",
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryRedColor)),
                ],
              ),
            )));
  }
}

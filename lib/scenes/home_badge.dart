import 'package:flutter/material.dart';
import 'package:redcross/utils/colors.dart';

class HomeBadge extends StatelessWidget {
  final String title;
  final String icon_name;

  const HomeBadge({super.key, required this.title, required this.icon_name});

  @override
  Widget build(BuildContext context) {
    final iconMap = <String, IconData>{
      'blood_icon': Icons.bloodtype_rounded,
      'gala': Icons.safety_check,
    };

    final iconData = iconMap[icon_name] ?? Icons.error;

    return Container(
        width: 172,
        height: 95,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2),
        margin: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
        decoration: BoxDecoration(
          color: const Color(0xFFFFE5E5),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 78,
                child: Text(title,
                    style: const TextStyle(
                        fontSize: 12.36,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Manrope",
                        color: AppColors.blackColor)),
              ),
              Icon(
                iconData,
                color: AppColors.primaryRedColor,
                size: 64.48,
              ),
            ],
          ),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redcross/utils/colors.dart';

class IconCard extends StatelessWidget {
  final String icon_name;
  final String label;

  const IconCard({super.key, required this.icon_name, required this.label});

  @override
  Widget build(BuildContext context) {
    final iconMap = <String, IconData>{
      'add': Icons.add_a_photo_sharp,
      'hospital': Icons.location_city,
    };

    final iconData = iconMap[icon_name] ?? Icons.error;

    return GestureDetector(
      onTap: () {
        Get.toNamed("/training-home");
      },
      child: Container(
          width: 180,
          height: 93,
          decoration: BoxDecoration(
              color: AppColors.redColorB,
              borderRadius: BorderRadius.circular(15)),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  iconData,
                  color: AppColors.redColorA,
                  size: 32.39,
                ),
                const SizedBox(height: 5),
                Text(label,
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        fontFamily: "Inter",
                        color: AppColors.redColorA))
              ],
            ),
          )),
    );
  }
}

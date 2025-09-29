import 'package:flutter/material.dart';
import 'package:redcross/utils/colors.dart';
import 'package:redcross/utils/storage_service.dart';

class CardBoard extends StatelessWidget {
  final String title;
  final String icon_name;
  final VoidCallback onPressed;

  const CardBoard(
      {super.key,
      required this.title,
      required this.icon_name,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final iconMap = <String, IconData>{
      'blood_icon': Icons.water_drop_outlined,
      'hospital': Icons.location_city,
      'ambulance': Icons.fire_truck_sharp,
      'disasters': Icons.storm_sharp,
      'membership': Icons.people_alt_sharp,
      'cash': Icons.money_sharp,
    };

    final iconData = iconMap[icon_name] ?? Icons.error;

    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Container(
        width: 170,
        height: 115.84,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
        decoration: BoxDecoration(
          color: AppColors.primaryRedColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Icon(
              iconData,
              color: AppColors.whiteColor,
              size: 36.16,
            ),
            const SizedBox(height: 5),
            Text(
              title,
              style: TextStyle(
                  fontSize: 16.55,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w600,
                  height: StorageService.getHeight(23, 16),
                  letterSpacing: StorageService.getSpacing(16),
                  color: AppColors.whiteColor),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:redcross/utils/colors.dart';
import 'package:redcross/utils/storage_service.dart';

class BloodDonationDetailItem extends StatelessWidget {
  final String label;
  final String value;

  const BloodDonationDetailItem(
      {super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      children: [
        Text("$label: ",
            style: TextStyle(
                fontSize: 12,
                fontFamily: "Inter",
                color: AppColors.blackColorZ,
                fontWeight: FontWeight.w400,
                letterSpacing: StorageService.getSpacing(12),
                height: StorageService.getHeight(20, 12))),
        Text("$value",
            style: TextStyle(
                fontSize: 12,
                fontFamily: "Inter",
                color: AppColors.blackColorZ,
                fontWeight: FontWeight.w900,
                letterSpacing: StorageService.getSpacing(12),
                height: StorageService.getHeight(20, 12)))
      ],
    ));
  }
}

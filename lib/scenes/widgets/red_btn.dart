import 'package:flutter/material.dart';
import 'package:redcross/utils/colors.dart';

class RedBtn extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  bool? squared;
  bool? iconned;
  String? icon_name;
  double? font;
  bool? is_white;

  RedBtn(
      {super.key,
      required this.label,
      required this.onPressed,
      this.squared,
      this.font,
      this.icon_name,
      this.iconned,
      this.is_white});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final iconMap = <String, IconData>{
      'alert': Icons.add_alert_outlined,
      'gala': Icons.safety_check,
    };

    final iconData = iconMap[icon_name] ?? Icons.error;

    return SizedBox(
      // height: 40,
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: squared != null
                      ? BorderRadius.circular(5)
                      : BorderRadius.circular(8)),
              backgroundColor: is_white != null
                  ? AppColors.whiteColor
                  : AppColors.primaryRedColor,
              side: BorderSide(
                color: is_white != null
                    ? AppColors.primaryRedColor
                    : Colors.transparent,
                width: is_white != null ? 2 : 0,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (iconned != null)
                  Icon(iconData,
                      color: is_white != null
                          ? AppColors.primaryRedColor
                          : AppColors.whiteColor),
                if (iconned != null) const SizedBox(width: 10),
                Text(label,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontFamily: "Inter",
                        fontSize: font ?? 14,
                        color: is_white != null
                            ? AppColors.primaryRedColor
                            : AppColors.whiteColor))
              ],
            ))
      ]),
    );
  }
}

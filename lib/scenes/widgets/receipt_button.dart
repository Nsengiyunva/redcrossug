import 'package:flutter/material.dart';
import 'package:redcross/utils/colors.dart';

class ReceiptButton extends StatelessWidget {
  final bool active;
  final String label;
  final VoidCallback onPressed;

  const ReceiptButton(
      {super.key,
      required this.active,
      required this.label,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 54,
        width: 162,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor:
                active ? AppColors.primaryRedColor : AppColors.whiteColor,
            foregroundColor: AppColors.whiteColor, // text color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5), // rounded corners
              side: BorderSide(
                  color: active
                      ? AppColors.primaryRedColor
                      : AppColors.primaryRedColor,
                  width: 1), // border
            ),
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          ),
          child: Text(label,
              style: TextStyle(
                  fontFamily: "Inter",
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: active
                      ? AppColors.whiteColor
                      : AppColors.primaryRedColor)),
        ));
  }
}

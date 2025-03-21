import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:redcross/utils/colors.dart';

class PriceTag extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool active;

  const PriceTag(
      {super.key,
      required this.label,
      required this.active,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Container(
        width: 100,
        height: 60,
        margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: active ? const Color(0xFFFFE9D9) : const Color(0xFFFFFFFF),
          border: Border.all(color: const Color(0xFFEAEAEA), width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(label,
              style: TextStyle(
                  fontFamily: "Inter",
                  fontSize: 16.85,
                  fontWeight: FontWeight.w600,
                  color: active
                      ? AppColors.primaryRedColor
                      : const Color(0xFF807B77))),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:redcross/scenes/widgets/dashed_line.dart';
import 'package:redcross/utils/colors.dart';

class ReceiptItem extends StatelessWidget {
  final String label;
  final String value;

  const ReceiptItem({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DashedLine(
          child: SizedBox(
            width: double.infinity, // take full width
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
              child: Text("$label".toUpperCase(),
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                      fontSize: 11.11,
                      color: AppColors.greenColorA,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w400)),
            ),
          ),
        ),
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Text("$value".toUpperCase(),
                textAlign: TextAlign.start,
                style: const TextStyle(
                    fontSize: 16.89,
                    color: AppColors.greenColorA,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w600)))
      ],
    ));
  }
}

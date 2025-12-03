// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:redcross/utils/colors.dart';

class AmbulanceStatusBtn extends StatelessWidget {
  String label;
  final Color fillColor;

  AmbulanceStatusBtn({super.key, required this.label, required this.fillColor });

  @override
  Widget build(BuildContext context) {

    return Container(
      child: Column(
        children: [
          Container(
            height: 6,
            width: 93,
            decoration: BoxDecoration(
              color: fillColor,
              borderRadius: BorderRadius.circular(10)
            ),
            child: null,
          ),
          const SizedBox( height: 5 ),
          Text( label, style: const TextStyle(
            fontSize: 8.99,
            fontWeight: FontWeight.w400,
            fontFamily: "Inter",
            color: AppColors.greyColorB
          ) )
        ],
      ),
    );
  }
}
// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:redcross/utils/colors.dart';

class BackButtonText extends StatelessWidget {
  const BackButtonText({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Text('Back',
          style: TextStyle(
              fontFamily: "Inter",
              color: AppColors.greyColorQ,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              height: 1.5)),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:redcross/utils/colors.dart';

class VolunteerTracking extends StatelessWidget {
  const VolunteerTracking({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.bgColor,
        body: SingleChildScrollView(
            child: Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 30.0),
          padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 15),
          child: const Text("Volunteer Tracking"),
        )));
  }
}

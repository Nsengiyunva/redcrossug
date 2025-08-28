import 'package:flutter/material.dart';
import 'package:redcross/utils/colors.dart';

class BloodDonationHistory extends StatelessWidget {
  const BloodDonationHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: AppBar(
          title: const Text("Back"),
        ),
        body: SingleChildScrollView(child: Text("Blood Donation  History")));
  }
}

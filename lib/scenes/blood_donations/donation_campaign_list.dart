import 'package:flutter/material.dart';
import 'package:redcross/utils/colors.dart';

class DonationCampaignList extends StatelessWidget {
  const DonationCampaignList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: AppBar(
          title: Text("Back"),
        ),
        body: SingleChildScrollView(
            child: Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 20.0),
          padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 10),
          child: Text("UpComing"),
        )));
  }
}

import 'package:flutter/material.dart';
import 'package:redcross/scenes/widgets/blood_donation_list_item.dart';
import 'package:redcross/utils/colors.dart';

class DonationCampaignList extends StatelessWidget {
  const DonationCampaignList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: AppBar(
          title: const Text("Back"),
        ),
        body: SingleChildScrollView(
            child: Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 20.0),
          padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 10),
          child: Column(
            children: [
              const SizedBox(
                height: 25,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Text("Upcoming",
                          style: TextStyle(
                              fontFamily: "Inter",
                              fontSize: 14,
                              fontWeight: FontWeight.w700)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 2),
                      child: Text("Active",
                          style: TextStyle(
                              fontFamily: "Inter",
                              fontSize: 14,
                              fontWeight: FontWeight.w700)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 5),
                      child: Text("Completed",
                          style: TextStyle(
                              fontFamily: "Inter",
                              fontSize: 14,
                              fontWeight: FontWeight.w700)),
                    )
                  ],
                ),
              ),
              SizedBox(height: 15),
              Container(
                  padding: EdgeInsets.only(left: 5, right: 5),
                  child: const Column(
                    children: [
                      BloodDonationListItem(),
                      SizedBox(height: 15),
                      BloodDonationListItem(),
                      SizedBox(height: 15),
                      BloodDonationListItem(),
                      SizedBox(height: 15),
                      BloodDonationListItem(),
                    ],
                  )),
            ],
          ),
        )));
  }
}

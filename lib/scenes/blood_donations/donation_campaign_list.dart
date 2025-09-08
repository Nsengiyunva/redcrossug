import 'package:flutter/material.dart';
import 'package:redcross/scenes/blood_donations/donation_campaign_details.dart';
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
              const SizedBox(height: 15),
              Container(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: Column(
                    children: [
                      BloodDonationListItem(onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) =>
                                  const DonationCampaignDetails()),
                        );
                      }),
                      const SizedBox(height: 15),
                      BloodDonationListItem(onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) =>
                                  const DonationCampaignDetails()),
                        );
                      }),
                      const SizedBox(height: 15),
                      BloodDonationListItem(onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) =>
                                  const DonationCampaignDetails()),
                        );
                      }),
                      const SizedBox(height: 15),
                      BloodDonationListItem(onPressed: () {}),
                    ],
                  )),
            ],
          ),
        )));
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redcross/scenes/blood_donations/donation_campaign_list.dart';
// import 'package:get/get.dart';
import 'package:redcross/scenes/widgets/blood_donation_list_item.dart';
import 'package:redcross/scenes/widgets/donation_badge.dart';
import 'package:redcross/scenes/widgets/donation_history_item.dart';
import 'package:redcross/scenes/widgets/nav_list_items.dart';
import 'package:redcross/utils/colors.dart';

class BloodDonationsHome extends StatelessWidget {
  const BloodDonationsHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.bgColor,
        body: SingleChildScrollView(
          child: Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 30.0),
              padding:
                  const EdgeInsets.symmetric(vertical: 30.0, horizontal: 15),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      "Blood Donation",
                      style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: 26.33,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.start, // Align text to start
                    ),
                  ),
                  const SizedBox(height: 15),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          height: 86,
                          width: 335,
                          padding: const EdgeInsets.only(right: 5, left: 10),
                          decoration: BoxDecoration(
                            color: AppColors.primaryRedColor,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: AppColors.primaryRedColor,
                              width: 1,
                            ),
                          ),
                          child: const Center(
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                SizedBox(
                                    height: 52,
                                    width: 52,
                                    child: Icon(
                                      Icons.home,
                                      color: Colors.white,
                                      size: 52,
                                    )),
                                Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Find Donation",
                                          style: TextStyle(
                                              fontFamily: "Inter",
                                              fontSize: 23.14,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.whiteColor)),
                                      Text("Campaigns",
                                          style: TextStyle(
                                              fontFamily: "Inter",
                                              fontSize: 23.14,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.whiteColor))
                                    ])
                              ]))),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Row(children: [
                    DonationBadge(
                        title: 'Eligibility to Donate',
                        icon_name: "blood_icon"),
                    DonationBadge(
                        title: 'Donation Highlights', icon_name: "gala")
                  ]),
                  const SizedBox(height: 25),
                  NavListItems(
                    label: 'Donations Campaigns',
                    subtitle: "See All",
                    onPressed: () {
                      // Get.toNamed("/blood-donations-campaigns-list");
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => DonationCampaignList()),
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          height: 107,
                          width: 335,
                          padding: const EdgeInsets.only(right: 5, left: 10),
                          decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: BloodDonationListItem(onPressed: () {})),
                    ],
                  ),
                  const SizedBox(height: 15),
                  NavListItems(
                    label: 'Donation History',
                    subtitle: "See All",
                    onPressed: () {},
                  ),
                  const SizedBox(height: 15),
                  DonationHistoryItem(
                    onPressed: () {},
                  ),
                  const SizedBox(height: 10),
                  DonationHistoryItem(onPressed: () {})
                ],
              )),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:redcross/scenes/widgets/donation_listing_item.dart';
import 'package:redcross/scenes/widgets/donation_tab_item.dart';
// import 'package:get/get.dart';
import 'package:redcross/utils/colors.dart';

class DonationCategories extends StatelessWidget {
  const DonationCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: AppBar(
            title: const Text("Back",
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w600,
                    color: AppColors.blackColor)),
            leading: const BackButton() // Back button added here
            ),
        body: SingleChildScrollView(
          child: Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 30.0),
              padding:
                  const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text("Categories",
                          style: TextStyle(
                              fontFamily: "Inter",
                              fontSize: 16,
                              color: AppColors.blackColorG,
                              fontWeight: FontWeight.w600))),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      DonationTabItem(label: "All Categories"),
                      DonationTabItem(label: "Health"),
                      DonationTabItem(label: "Education")
                    ],
                  ),
                  SizedBox(height: 15),
                  DonationListingItem(
                    title: 'Funding fair  for Red Cross 1',
                    subtitle: 'DFCU Blood Drive',
                  ),
                  SizedBox(height: 15),
                  DonationListingItem(
                    title: 'Funding fair  for Red Cross 2',
                    subtitle: 'DFCU Blood Drive',
                  ),
                  SizedBox(height: 15),
                  DonationListingItem(
                    title: 'Funding fair  for Red Cross 3',
                    subtitle: 'DFCU Blood Drive',
                  ),
                ],
              )),
        ));
  }
}

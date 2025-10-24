import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redcross/scenes/donations/donation_categories.dart';
import 'package:redcross/scenes/widgets/donation_badge.dart';
import 'package:redcross/scenes/widgets/donation_history_item.dart';
import 'package:redcross/scenes/widgets/nav_list_items.dart';
import 'package:redcross/utils/colors.dart';

class HomeDonations extends StatelessWidget {
  const HomeDonations({super.key});

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
                      "Donations",
                      style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: 26.33,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.start,
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
                          child: Center(
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                const Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Total Donations",
                                          style: TextStyle(
                                              fontFamily: "Inter",
                                              fontSize: 14.35,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.whiteColorJ)),
                                      Text("UGX  350,000",
                                          style: TextStyle(
                                              fontFamily: "Inter",
                                              fontSize: 20.49,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.whiteColor))
                                    ]),
                                SizedBox(
                                  width: 100, // custom width
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // Get.toNamed("/donations-categories");
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const DonationCategories()),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors
                                          .redColorL, // background color
                                      // foregroundColor:
                                      //     Colors.white, // text color
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            5), // rounded corners
                                        // side: const BorderSide(
                                        //     color: Colors.black,
                                        //     width: 0), // border
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 5),
                                    ),
                                    child: const Text("Donate",
                                        style: TextStyle(
                                            fontFamily: "Inter",
                                            fontSize: 12.3,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.primaryRedColor)),
                                  ),
                                )
                              ]))),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(children: [
                    DonationBadge(
                      title: 'Donate  to RedCross',
                      icon_name: "blood_icon",
                      onPressed: () {},
                    ),
                    DonationBadge(
                      title: 'Donate to a Cause',
                      icon_name: "gala",
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => const DonationCategories()),
                        );
                      },
                    )
                  ]),
                  const SizedBox(height: 15),
                  Container(
                      width: 335,
                      height: 48,
                      decoration: BoxDecoration(
                          color: AppColors.redColorD,
                          borderRadius: BorderRadius.circular(8)),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.medication_sharp,
                              size: 24, color: AppColors.primaryRedColor),
                          Text("Apply for Membership",
                              style: TextStyle(
                                  fontFamily: "Inter",
                                  fontSize: 12,
                                  color: AppColors.primaryRedColor,
                                  fontWeight: FontWeight.w700))
                        ],
                      )),
                  const SizedBox(height: 25),
                  NavListItems(
                      label: 'Donations',
                      subtitle: "See All",
                      onPressed: () {
                        Get.toNamed("/donation-history-list");
                      }),
                  const SizedBox(height: 5),
                  DonationHistoryItem(onPressed: () {}),
                  const SizedBox(height: 10),
                  DonationHistoryItem(onPressed: () {}),
                  const SizedBox(height: 10),
                  DonationHistoryItem(onPressed: () {}),
                  const SizedBox(height: 10),
                  DonationHistoryItem(onPressed: () {})
                ],
              )),
        ));
  }
}

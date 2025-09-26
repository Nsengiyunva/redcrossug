import 'package:flutter/material.dart';
import 'package:redcross/scenes/blood_donations/blood_donation_history_details.dart';
import 'package:redcross/scenes/widgets/blood_donation_history_item.dart';
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
        body: SingleChildScrollView(
            child: Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(vertical: 20.0),
                padding:
                    const EdgeInsets.symmetric(vertical: 30.0, horizontal: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Donation  History"),
                    const SizedBox(height: 25),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("All Donations"),
                        Text("Filter"),
                        Text("")
                      ],
                    ),
                    const SizedBox(height: 15),
                    BloodDonationHistoryItem(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) =>
                                  BloodDonationHistoryDetails()),
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    BloodDonationHistoryItem(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) =>
                                  BloodDonationHistoryDetails()),
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    BloodDonationHistoryItem(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) =>
                                  BloodDonationHistoryDetails()),
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                  ],
                ))));
  }
}

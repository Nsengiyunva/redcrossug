import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redcross/scenes/widgets/red_btn.dart';
import 'package:redcross/utils/colors.dart';

class BloodDonationHistoryDetails extends StatelessWidget {
  const BloodDonationHistoryDetails({super.key});

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
          child: Container(
              width: 345,
              height: 392,
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              decoration: BoxDecoration(color: AppColors.redColorD),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                            children: [Text("Donation"), Text("Highlights")]),
                        Icon(Icons.water_drop_rounded,
                            color: AppColors.primaryRedColor)
                      ]),
                  SizedBox(height: 20),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Next Camp"),
                      Text("Arua Regional Drive - Aug 7, 2025")
                    ],
                  ),
                  SizedBox(height: 15),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [Text("You Last Donated"), Text("June 14, 2025")],
                  ),
                  SizedBox(height: 15),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Your Status"),
                      Text("Not Eligible(wait till Sept 2025)")
                    ],
                  ),
                  SizedBox(height: 15),
                  RedBtn(
                    label: 'Close',
                    onPressed: () {
                      Get.toNamed("/blood-donations");
                    },
                  )
                ],
              )),
        )));
  }
}

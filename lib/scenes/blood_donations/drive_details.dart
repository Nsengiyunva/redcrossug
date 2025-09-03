import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redcross/scenes/widgets/donation_progress.dart';
import 'package:redcross/scenes/widgets/red_btn.dart';
import 'package:redcross/scenes/widgets/text_box_area.dart';
import 'package:redcross/utils/colors.dart';
import 'package:redcross/utils/storage_service.dart';

class DriveDetails extends StatelessWidget {
  const DriveDetails({super.key});

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
          padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 230,
                width: 327,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.red, width: 1)),
                child: Image.asset('assets/images/ambulance.png'),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                      width: 200,
                      child: Text(
                        "Help the Kakira  Ward B recover the floods.",
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w600),
                      )),
                  Container(
                      width: 84,
                      height: 24,
                      decoration:
                          const BoxDecoration(color: AppColors.yellowColorA),
                      child: const Center(child: Text("10:30:05"))),
                  DonationProgress(
                      amount:
                          StorageService.formatCurrency(500000) ?? "500,000",
                      target:
                          StorageService.formatCurrency(650000) ?? "2,000,000",
                      currency: "UGX"),
                  SizedBox(height: 10),
                  RedBtn(label: 'Donate Now', onPressed: () {})
                ],
              ),
              SizedBox(height: 10),
              const Text(
                  "Refuuge children and their families in Kakira Ward B, have been hit hard by impact of Floods.")
            ],
          ),
        )));
  }
}

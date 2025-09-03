import 'package:flutter/material.dart';
import 'package:redcross/scenes/widgets/donation_progress.dart';
import 'package:redcross/scenes/widgets/red_btn.dart';
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
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Image.asset('assets/images/donations_1.png'),
              ),
              SizedBox(height: 15),
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
                      margin: EdgeInsets.only(right: 25),
                      decoration:
                          const BoxDecoration(color: AppColors.yellowColorA),
                      child: const Center(child: Text("10:30:05")))
                ],
              ),
              const SizedBox(height: 15),
              const Text(
                  "Refugee children and their families in Kakira Ward B, have been hit hard by impact of Floods."),
              const SizedBox(height: 15),
              DonationProgress(
                  amount: StorageService.formatCurrency(500000) ?? "500,000",
                  target: StorageService.formatCurrency(650000) ?? "2,000,000",
                  currency: "UGX"),
              SizedBox(height: 15),
              RedBtn(label: 'Donate', onPressed: () {})
            ],
          ),
        )));
  }
}

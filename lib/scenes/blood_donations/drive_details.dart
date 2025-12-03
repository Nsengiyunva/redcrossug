// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redcross/controllers/disasters_list_controller.dart';
import 'package:redcross/scenes/widgets/donation_progress.dart';
import 'package:redcross/scenes/widgets/form_textfield.dart';
import 'package:redcross/scenes/widgets/price_tag.dart';
import 'package:redcross/scenes/widgets/red_btn.dart';
import 'package:redcross/utils/colors.dart';
import 'package:redcross/utils/storage_service.dart';

class DriveDetails extends StatefulWidget {
  DriveDetails({super.key});

  final DisastersListController disasterController =
      Get.put(DisastersListController());

  @override
  State<DriveDetails> createState() => _DriveDetailsState();
}

class _DriveDetailsState extends State<DriveDetails> {
  Map<String, dynamic>? disaster_details;
  bool isLoading = true;
  String amount_tab = "250K";
  int flagId = 2;

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
              const SizedBox(height: 15),
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
                      margin: const EdgeInsets.only(right: 25),
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
              const SizedBox(height: 15),
              RedBtn(
                  label: 'Donate',
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(0)),
                      ),
                      builder: (BuildContext context) {
                        return Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          height: 500,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Center(
                                child: Text(
                                  "Donation Amount",
                                  style: TextStyle(
                                      fontSize: 16.85,
                                      fontFamily: "Inter",
                                      color: AppColors.blackColorG,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              const SizedBox(height: 25),
                              Center(
                                child: FormTextfield(
                                  isNumberField: false,
                                  no_question: false,
                                  question: "Enter Price Manually",
                                  textEditingController:
                                      widget.disasterController.donationAmount,
                                  validator: (String? value) {
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(height: 25),
                              Row(
                                children: [
                                  PriceTag(
                                      label: '100K',
                                      active:
                                          widget.disasterController.flagId == 1
                                              ? true
                                              : false,
                                      onPressed: () {
                                        widget.disasterController
                                            .setAmountActive(1, "100K");
                                      }),
                                  PriceTag(
                                      label: '250K',
                                      active:
                                          widget.disasterController.flagId == 2
                                              ? true
                                              : false,
                                      onPressed: () {
                                        widget.disasterController
                                            .setAmountActive(2, "250K");
                                      }),
                                  PriceTag(
                                      label: '350K',
                                      active:
                                          widget.disasterController.flagId == 3
                                              ? true
                                              : false,
                                      onPressed: () {
                                        widget.disasterController
                                            .setAmountActive(3, "350K");
                                        // updateAmount(3, "350K");
                                      }),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  PriceTag(
                                      label: '500K',
                                      active:
                                          widget.disasterController.flagId == 4
                                              ? true
                                              : false,
                                      onPressed: () {
                                        // updateAmount(4, "500K");
                                        widget.disasterController
                                            .setAmountActive(4, "500K");
                                      }),
                                  PriceTag(
                                      label: '750K',
                                      active:
                                          widget.disasterController.flagId == 5
                                              ? true
                                              : false,
                                      onPressed: () {
                                        // updateAmount(5, "750K");
                                        widget.disasterController
                                            .setAmountActive(5, "750K");
                                      }),
                                  PriceTag(
                                      label: '1 million',
                                      active:
                                          widget.disasterController.flagId == 6
                                              ? true
                                              : false,
                                      onPressed: () {
                                        // updateAmount(6, "1M");
                                        widget.disasterController
                                            .setAmountActive(6, "1M");
                                      }),
                                ],
                              ),
                              const Spacer(),
                              RedBtn(
                                  squared: true,
                                  label: 'Continue to Payment',
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    Get.toNamed("/initiate-payment",
                                        arguments: {
                                          "disasterId": disaster_details!['id']
                                        });
                                  })
                            ],
                          ),
                        );
                      },
                    );
                  })
            ],
          ),
        )));
  }
}

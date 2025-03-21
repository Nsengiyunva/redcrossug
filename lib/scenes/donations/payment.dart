import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redcross/controllers/disasters_list_controller.dart';
import 'package:redcross/scenes/widgets/payment_list_item.dart';
import 'package:redcross/scenes/widgets/payment_summary_item.dart';
import 'package:redcross/scenes/widgets/red_btn.dart';
import 'package:redcross/scenes/widgets/text_box_area.dart';
import 'package:redcross/utils/colors.dart';

class Payment extends StatelessWidget {
  Payment({super.key});

  final DisastersListController disasterController =
      Get.put(DisastersListController());

  @override
  Widget build(BuildContext context) {
    final String data = Get.arguments;
    print("data ${data}");
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
          title: const Text(""),
          leading: const BackButton() // Back button added here
          ),
      body: SingleChildScrollView(
        child: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    "Payment",
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w500,
                        color: AppColors.blackColorG),
                  ),
                ),
                const SizedBox(height: 10),
                const Text("Select Payment Method",
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w500,
                        color: AppColors.blackColorG)),
                const SizedBox(height: 10),
                // PaymentListItem(
                //   outline: true,
                //   text_label: 'Credit Card',
                //   icon_name: 'credit_card_rounded',
                // ),
                PaymentListItem(
                  outline: true,
                  text_label: 'Mobile Money',
                  icon_name: 'phone_iphone_rounded',
                ),
                const SizedBox(height: 15),
                const PaymentSummaryItem(
                    text_label: "Service Fee", price_label: "UGX 0"),
                const SizedBox(height: 10),
                const PaymentSummaryItem(
                    text_label: "Donation Amount", price_label: "UGX 250,000"),
                const SizedBox(height: 25),
                const PaymentSummaryItem(
                    text_label: "Total", price_label: "UGX 250,000"),
                const SizedBox(height: 30),
                const Text("Messages and Support",
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w500,
                        color: AppColors.blackColorG)),
                const SizedBox(height: 5),
                const TextBoxArea(),
                const SizedBox(height: 5),
                const Row(
                  children: [
                    Icon(Icons.check_box_outline_blank,
                        color: AppColors.greyColorG, size: 20.0),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Text("Hide your name",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontFamily: "Inter",
                              fontSize: 12,
                              color: AppColors.greyColorG)),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                RedBtn(
                  squared: true,
                  label: "Confirm Donation",
                  onPressed: () {
                    // Get.toNamed("/payment-successful");
                    disasterController.makePayment(1);
                  },
                )
              ],
            )),
      ),
    );
  }
}

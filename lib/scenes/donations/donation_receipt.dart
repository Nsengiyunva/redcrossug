import 'package:flutter/material.dart';
import 'package:redcross/scenes/widgets/dashed_line.dart';
import 'package:redcross/scenes/widgets/receipt_button.dart';
import 'package:redcross/scenes/widgets/receipt_item.dart';
import 'package:redcross/utils/colors.dart';

class DonationReceipt extends StatelessWidget {
  const DonationReceipt({super.key});

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
                    Center(
                        child: Container(
                      width: 91,
                      height: 91,
                      child: Image.asset(
                        'assets/images/redcross_main.png',
                        fit: BoxFit.cover, // fill the container
                      ),
                    )),
                    SizedBox(height: 15),
                    const ReceiptItem(
                        label: 'Donor Name', value: 'Mukisa Geofrey'),
                    SizedBox(height: 15),
                    const ReceiptItem(
                        label: 'Date & Time', value: 'May 10, 2024'),
                    const SizedBox(height: 15),
                    const ReceiptItem(
                        label: 'Donation Type', value: 'Cause Donation'),
                    SizedBox(height: 15),
                    const ReceiptItem(label: 'Amount', value: 'UGX 50,000'),
                    SizedBox(height: 15),
                    const ReceiptItem(label: 'Cause', value: 'Kasese Floods'),
                    const SizedBox(height: 15),
                    const ReceiptItem(
                        label: 'Payment Mode', value: 'Mobile Money'),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ReceiptButton(
                          active: false,
                          label: "Print",
                          onPressed: () {},
                        ),
                        ReceiptButton(
                            active: true, label: "Download", onPressed: () {})
                      ],
                    )
                  ],
                ))));
  }
}

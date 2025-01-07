import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redcross/scenes/payment_list_item.dart';
import 'package:redcross/scenes/payment_summary_item.dart';
import 'package:redcross/scenes/red_btn.dart';
import 'package:redcross/scenes/text_box_area.dart';

class Payment extends StatelessWidget {
  const Payment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: const Text(""),
        leading: const BackButton() // Back button added here
      ),
      body: SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 30.0),
        padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center( 
              child: Text( "Payment", style: TextStyle( fontSize: 18 ), ),
            ),
            const SizedBox( height: 25 ),
            const Text( "Select Payment Method", style: TextStyle( fontSize: 16 ) ),
            const PaymentListItem(),
            const SizedBox( height: 25 ),
            const Text( "Select Payment Method", style: TextStyle( fontSize: 16 ) ),
            const SizedBox( height: 10 ),
            const PaymentSummaryItem(text_label: "Service Fee", price_label: "UGX 300"),
            const SizedBox( height: 10 ),
            const PaymentSummaryItem(text_label: "Donation Amount", price_label: "UGX 450,000"),
             const SizedBox( height: 25 ),
            const PaymentSummaryItem(text_label: "Total", price_label: "UGX 500,000"),
            const SizedBox( height: 30 ),
            const Text( "Messages and Support", style: TextStyle( fontSize: 16 ) ),
            const TextBoxArea(),
            const SizedBox( height: 25 ),
            RedBtn(label: "Confirm Donation", onPressed: () {  
              Get.toNamed( "/payment-successful" );
            },)
          ],
        )
        ),
      ),
    );
  }
}
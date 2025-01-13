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
      backgroundColor: const Color(0xFFFFFFFF),
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
              child: Text( "Payment", style: TextStyle( 
                fontSize: 16, 
                fontFamily: "Inter", 
                fontWeight: FontWeight.w500, 
                color: Color(0xFF221105) 
              ), ),
            ),
            const SizedBox( height: 25 ),
            const Text( "Select Payment Method", 
              style: TextStyle( 
                fontSize: 12,
                fontFamily: "Inter",
                fontWeight: FontWeight.w500,
                color: Color(0xFF221105)
              ) ),
            const SizedBox( height: 10 ),
            PaymentListItem(outline: true, text_label: 'Credit Card', icon_name: 'credit_card_rounded',),
            PaymentListItem(outline: false, text_label: 'Mobile Money', icon_name: 'phone_iphone_rounded',),
            const SizedBox( height: 25 ),
            const Text( "Payment summary", 
              style: TextStyle( 
                fontSize: 12,
                fontFamily: "Inter",
                fontWeight: FontWeight.w500,
                color: Color(0xFF221105)
              )  ),
            const SizedBox( height: 10 ),
            const PaymentSummaryItem(text_label: "Service Fee", price_label: "UGX 300"),
            const SizedBox( height: 10 ),
            const PaymentSummaryItem(text_label: "Donation Amount", price_label: "UGX 450,000"),
            const SizedBox( height: 25 ),
            const PaymentSummaryItem(text_label: "Total", price_label: "UGX 500,000"),
            const SizedBox( height: 30 ),
            const Text( "Messages and Support", 
              style: TextStyle( 
                fontSize: 12,
                fontFamily: "Inter",
                fontWeight: FontWeight.w500,
                color: Color(0xFF221105)
              )  ),
            const SizedBox( height: 10 ),
            const TextBoxArea(),
            const SizedBox( height: 25 ),
            const Row(
              children: [
                Icon(
                  Icons.check_box_outline_blank,
                  color: Color(0xFF969492),
                  size: 20.0
                ),
                Padding(
                  padding: EdgeInsets.symmetric( horizontal: 5 ),
                  child: Text( "Hide your name", style: TextStyle( fontWeight: FontWeight.w400, fontFamily: "Inter", fontSize: 12, color: Color(0xFF969492) ) ),
                ),
              ],
            ),
            const SizedBox( height: 25 ),
            RedBtn(squared: true, label: "Confirm Donation", onPressed: () {  
              Get.toNamed( "/payment-successful" );
            },)
          ],
        )
        ),
      ),
    );
  }
}
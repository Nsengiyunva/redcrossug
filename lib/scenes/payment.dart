import 'package:flutter/material.dart';
import 'package:redcross/scenes/payment_list_item.dart';
import 'package:redcross/scenes/payment_summary_item.dart';
import 'package:redcross/scenes/red_btn.dart';
import 'package:redcross/scenes/text_box_area.dart';

class Payment extends StatelessWidget {
  const Payment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 30.0),
        padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center( 
              child: Text( "Payment", style: TextStyle( fontSize: 18 ), ),
            ),
            SizedBox( height: 25 ),
            Text( "Select Payment Method", style: TextStyle( fontSize: 16 ) ),
            PaymentListItem(),
            SizedBox( height: 25 ),
            Text( "Select Payment Method", style: TextStyle( fontSize: 16 ) ),
            SizedBox( height: 10 ),
            PaymentSummaryItem(text_label: "Service Fee", price_label: "UGX 300"),
            SizedBox( height: 10 ),
            PaymentSummaryItem(text_label: "Donation Amount", price_label: "UGX 450,000"),
             SizedBox( height: 25 ),
            PaymentSummaryItem(text_label: "Total", price_label: "UGX 500,000"),
            SizedBox( height: 30 ),
            Text( "Messages and Support", style: TextStyle( fontSize: 16 ) ),
            TextBoxArea(),
            SizedBox( height: 25 ),
            RedBtn(label: "Confirm Donation")
          ],
        )
        ),
      ),
    );
  }
}
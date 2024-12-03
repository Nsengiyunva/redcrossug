import 'package:flutter/material.dart';

class PaymentSummaryItem extends StatelessWidget {
  final String text_label;
  final String price_label;
  
  const PaymentSummaryItem({super.key, required this.text_label, required this.price_label });

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.symmetric( vertical: 10 ),
      child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Padding(
              padding: EdgeInsets.symmetric( horizontal: 10 ),
              child: Text( text_label, style: TextStyle( fontSize: 16 ),),
            ), 
            Padding(
              padding: EdgeInsets.symmetric( horizontal: 10 ),
              child: Text( price_label, style: TextStyle( fontSize: 18, fontWeight: FontWeight.bold ),),
            ) 
          ],
          ),
    );
  }
}
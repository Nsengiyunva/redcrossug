import 'package:flutter/material.dart';

class PaymentSummaryItem extends StatelessWidget {
  final String text_label;
  final String price_label;
  
  const PaymentSummaryItem({
    super.key, 
    required this.text_label, 
    required this.price_label 
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.symmetric( vertical: 10 ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Padding(
          padding: EdgeInsets.symmetric( horizontal: 10 ),
          child: Text( text_label, 
          style: TextStyle( 
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Color(0xFF969492),
            fontFamily: "Inter"
          ) ),
        ), 
        Padding(
          padding: EdgeInsets.symmetric( horizontal: 10 ),
          child: Text( price_label, 
          style: TextStyle( 
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF000000),
            fontFamily: "Inter"
          )),
        ) ]
      ),
    );
  }
}
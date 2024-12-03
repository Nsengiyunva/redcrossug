import 'package:flutter/material.dart';
import 'package:redcross/scenes/payment_method_item.dart';

class PaymentListItem extends StatelessWidget {
  const PaymentListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric( vertical: 25 ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: const Color.fromARGB(153, 227, 226, 226), // Border color
            width: 2.0,         // Border width
          ),
           top: BorderSide(
            color: const Color.fromARGB(153, 227, 226, 226), // Border color
            width: 2.0,         // Border width
          ),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PaymentMethodItem(text_label: 'Credit Card', icon_name: 'credit_card',),
              Text( "" )
            ],
          ),          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PaymentMethodItem(text_label: 'Mobile Money', icon_name: 'phone_android',),
              Text( "" )
            ],
          ),
        ],
      ),
    );
  }
}
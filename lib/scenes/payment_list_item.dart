import 'package:flutter/material.dart';
import 'package:redcross/scenes/payment_method_item.dart';

class PaymentListItem extends StatelessWidget {

  final String text_label;
  final String icon_name;
  bool? outline;
  
  PaymentListItem({super.key, required this.text_label, required this.icon_name, this.outline });

  String selectedOption = 'Option 1';

  @override
  Widget build(BuildContext context) {

     final iconMap = <String, IconData>{
      'credit_card_rounded': Icons.credit_card_rounded,
      'phone_iphone_rounded': Icons.phone_iphone_rounded
    };

    final iconData = iconMap[icon_name] ?? Icons.error;

    return Container(
      height: 72,
      padding: EdgeInsets.symmetric( vertical: 5 ),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            width: outline! ? 2.0 : 0,
            color: Color(0xFFEAEAEA)
          ),
          bottom: BorderSide(
            width: outline! ? 2.0 : 0,
            color: Color(0xFFEAEAEA)
          )
        )
      ),
      child: Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular( 20 ),
                  color: Color(0xFFFFE3E1)
                ),
                child: Center(
                  child: Icon(
                  iconData,
                  color: Color(0xFFED1C24),
                  size: 20.0,
                )
              )
            ),
            Padding(
              padding: EdgeInsets.symmetric( horizontal: 10 ),
              child: Text( "$text_label", style: 
              TextStyle( 
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Color(0xFF969492),
                fontFamily: "Inter"
              ),)
             )
            ],
            ),
            Radio(
              value: 'Option 1',
              groupValue: "",
              activeColor: Colors.red,  // Custom color when selected
              onChanged: (value) {
                // setState(() {
                //   selectedOption = value.toString();
                // });
              },
            )
          ],
        ) ),
    );
  }
}
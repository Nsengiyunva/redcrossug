import 'package:flutter/material.dart';

class PaymentMethodItem extends StatelessWidget {
  final String text_label;
   final String icon_name;
  
  const PaymentMethodItem({super.key, required this.text_label, required this.icon_name });

  @override
  Widget build(BuildContext context) {

    final iconMap = <String, IconData>{
      'credit_card': Icons.credit_card,
      'phone_android': Icons.phone_android
    };

    final iconData = iconMap[icon_name] ?? Icons.error;

    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF),
        border: Border(
          top: BorderSide(
            color: Color(0xFFEAEAEA), 
            width: 1
          ),
          bottom: BorderSide(
            color: Color(0xFFEAEAEA), 
            width: 1
          ),
        ),
      ),
      margin: EdgeInsets.symmetric( vertical: 10 ),
      child: Row(
            children: [
            Container(
              // width: 35,
              height: 72,
              decoration: BoxDecoration(
                color: Color(0xFFFFE3E1),
                borderRadius: BorderRadius.circular(30)
              ),
              child: Icon(
                iconData,
                color: Color(0xFFED1C24),
                size: 20.0,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric( horizontal: 10 ),
              child: Text( text_label, style: 
              TextStyle( 
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Color(0xFF969492),
                fontFamily: "Inter"
              ),),
            ) 
          ],
          ),
    );
  }
}
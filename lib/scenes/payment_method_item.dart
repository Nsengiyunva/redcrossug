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
      margin: const EdgeInsets.symmetric( vertical: 10 ),
      child: Row(
            children: [
            Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 209, 180, 189),
                borderRadius: BorderRadius.circular(30)
              ),
              child: Icon(
                iconData,
                color: Colors.red,
                size: 20.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric( horizontal: 10 ),
              child: Text( text_label, style: const TextStyle( fontSize: 16 ),),
            ) 
          ],
          ),
    );
  }
}
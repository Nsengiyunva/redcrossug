import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LinkField extends StatelessWidget {
  final String label;

  const LinkField({super.key, required this.label });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric( horizontal: 10 ),
      padding: EdgeInsets.symmetric( horizontal: 5 ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text( "$label", style: TextStyle(  
            decoration: TextDecoration.underline, 
            decorationColor: Color(0xFF0080FF),
            color: Color(0xFF0080FF), 
            fontFamily: "Inter", 
            fontSize: 11.37, 
            fontWeight: FontWeight.w400 
            )
          ),
          // Icon(
          //   Icons, 
          //   size: 12, 
          //   color: Color(0xFF0080FF)
          // )
          Icon(
            Icons.abc_sharp,
            size: 12,
            color: Colors.red
          )
        ],
      ),
    );
  }
}
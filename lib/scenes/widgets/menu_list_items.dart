// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class MenuListItems extends StatelessWidget {
  final String first_title;
  final String second_title;

  const MenuListItems({super.key, required this.first_title, required this.second_title });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric( horizontal: 15.0, vertical: 5.0 ),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFED1C24),
            width: 2.0
          )
        )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 150,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFFED1C24,),
                  width: 2.0
                )
              )
            ),
            child: Text( first_title, style: const TextStyle( fontSize: 13.27, color: Color(0xFFE30000), fontFamily: "Inter", fontWeight: FontWeight.w600 ) ),
          ),
          Text( second_title, style: const TextStyle( fontSize: 13.27, color: Color(0xFF7E848A), fontFamily: "Inter", fontWeight: FontWeight.w600 ))
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';

class MenuListItems extends StatelessWidget {
  final String first_title;
  final String second_title;

  const MenuListItems({super.key, required this.first_title, required this.second_title });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric( horizontal: 10.0, vertical: 5.0 ),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.red,
            width: 2.0
          )
        )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text( first_title, style: const TextStyle( fontSize: 16, color: Colors.red, ) ),
           Text( second_title, style: const TextStyle( fontSize: 16, color: Colors.grey, ) )
        ],
      ),
    );
  }
}
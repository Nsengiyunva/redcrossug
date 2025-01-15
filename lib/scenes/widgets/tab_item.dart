import 'package:flutter/material.dart';

class TabItem extends StatelessWidget {
  final String title;

  const TabItem({super.key, required this.title });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: Colors.red, // Border color
          width: 2.0,         // Border thickness
        ),
      ),
        ),
      child:  Padding(
        padding: const EdgeInsets.symmetric( horizontal: 2 ),
        child: Text( title, 
        textAlign: TextAlign.start, 
        style: const TextStyle( fontSize: 20, color: Colors.red 
        ) 
        ),
    )
    );
   
  }
}
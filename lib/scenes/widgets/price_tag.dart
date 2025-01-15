import 'package:flutter/material.dart';

class PriceTag extends StatelessWidget {
  final String label;
  final bool active; 

  const PriceTag({super.key, required this.label, required this.active });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 60,
      margin: const EdgeInsets.symmetric( vertical: 15, horizontal: 10 ),
      padding: const EdgeInsets.all( 10 ),
      decoration: BoxDecoration(
        color: active ? const Color(0xFFFFE9D9) : const Color(0xFFFFFFFF),
        border: Border.all(  
          color: const Color(0xFFEAEAEA),
          width: 2
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text( label, 
        style: TextStyle( 
          fontFamily: "Inter",
          fontSize: 16.85, 
          fontWeight: FontWeight.w600, 
          color: active ? const Color(0xFFED1C24) : const Color(0xFF807B77) 
          ) ),
      ),
    );
  }
}
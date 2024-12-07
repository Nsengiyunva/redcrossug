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
        color: active ? const Color.fromARGB(255, 238, 222, 199) : Colors.white70,
        border: Border.all(   
          color: Colors.black12,
          width: 2
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text( label, style: TextStyle( fontSize: 18, fontWeight: FontWeight.w500, color: active ? Colors.red : Colors.black ) ),
      ),
    );
  }
}
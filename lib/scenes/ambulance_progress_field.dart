import 'package:flutter/material.dart';

class AmbulanceProgressField extends StatelessWidget {
  const AmbulanceProgressField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      margin: const EdgeInsets.symmetric( vertical: 5 ),
      padding: const EdgeInsets.symmetric( horizontal: 5, vertical: 2 ),
      decoration: BoxDecoration(
        color: Colors.green.shade200,
         borderRadius: BorderRadius.circular(10)
      ),
      child: Row(
        children: [
          Icon(
            Icons.circle_rounded,
            color: Colors.green.shade600,
            size: 15.0,
          ),
          Padding(padding: const EdgeInsets.symmetric( horizontal: 5 ),
            child: Text( "Confirmed", style: TextStyle( fontSize: 20, color: Colors.green.shade700 )
           ),
          )
        ],
      ),
    );
  }
}
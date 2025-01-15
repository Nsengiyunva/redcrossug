import 'package:flutter/material.dart';
import 'package:redcross/scenes/ambulances/ambulance_progress_field.dart';

class AmbulanceStatusItem extends StatelessWidget {
  String label;
  bool noComponent;
  String value;

  AmbulanceStatusItem( {super.key, required this.label, required this.noComponent, required this.value });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text( label.toUpperCase(), style: const TextStyle( 
            fontSize: 11.11,
            fontFamily: "Inter",
            color: Color(0x00ff1a3c),
            fontWeight: FontWeight.w400
          ) ),
          Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFFD9D9D9),
                  width: 2.0
                )
              )
            ),
          ),
          noComponent ? const AmbulanceProgressField() : 
          Text( value, style: const TextStyle( 
            fontSize: 16.89,
            fontFamily: "Inter",
            fontWeight: FontWeight.w500,
            color: Color(0xFF1A3C40)
          ) ),
        ],
      ),
    );
  }
}
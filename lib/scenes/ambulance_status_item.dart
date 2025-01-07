import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:redcross/scenes/ambulance_progress_field.dart';

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
          Text( label.toUpperCase(), style: const TextStyle( fontSize: 20 ) ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey.shade500,
                  width: 2.0
                )
              )
            ),
          ),
          noComponent ? AmbulanceProgressField() : Text( value, style: const TextStyle( fontSize: 24 ) ),
        ],
      ),
    );
  }
}
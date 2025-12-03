// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class GreenBadge extends StatelessWidget {
  bool changeColor;

  GreenBadge({super.key, required this.changeColor });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: changeColor ? Colors.red : Colors.green,
        borderRadius: BorderRadius.circular( 80 )
      ),
      child: Center(
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular( 30 )
          ),
          child: Icon(
                Icons.check,
                color: changeColor ? Colors.red : Colors.green.shade800,
                size: 30.0,
              ),
        )
      ),
    );
  }
}
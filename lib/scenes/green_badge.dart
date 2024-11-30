import 'package:flutter/material.dart';

class GreenBadge extends StatelessWidget {
  const GreenBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.0,
      height: 80.0,
      decoration: BoxDecoration(
        color: Colors.green,
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.green,
          width: 2.0 
        )
      ),
    );
  }
}
import 'package:flutter/material.dart';

class RedBadge extends StatelessWidget {
  const RedBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular( 80 )
      ),
      child: const Center(
        child: Icon(
          Icons.fire_truck_outlined,
          color: Colors.white,
          size: 40.0,
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';

class MenuListItems extends StatelessWidget {
  const MenuListItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.red,
          width: 2.0
        )
      ),
      child: const Row(
        children: [
          Text('Active Disasters')
        ],
      ),
    );
  }
}
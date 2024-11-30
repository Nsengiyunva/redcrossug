import 'package:flutter/material.dart';

class ListTabsContainer extends StatelessWidget {
  const ListTabsContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Container(
            width: 200, // Width of the SizedBox
            height: 100, // Height of the SizedBox
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.blue, // Border color
                width: 2.0, // Border thickness
              ),
              borderRadius: BorderRadius.circular(8), // Optional: Rounded corners
            ),
            child: const SizedBox(
              // The SizedBox content
              child: Center(
                child: Text(
                  'This SizedBox has a border.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
        ),
      );
  }
}
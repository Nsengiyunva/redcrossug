import 'package:flutter/material.dart';

class RedBtn extends StatelessWidget {
  const RedBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
               onPressed: () {},
               style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular( 5 )
              ),
              backgroundColor: Colors.red,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10 ),
            ),
            child: const Text('Continue', style: TextStyle( fontSize: 20, color: Colors.white ) ),
        )
              ]
      );
  }
}
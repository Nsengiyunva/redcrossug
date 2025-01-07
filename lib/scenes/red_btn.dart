import 'package:flutter/material.dart';

class RedBtn extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const RedBtn({super.key, required this.label, required this.onPressed });

  @override
  Widget build(BuildContext context) {
    return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular( 15 )
            ),
            backgroundColor: Color(0xFFED1C24),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15 ),
          ),
            child: Text( label , style: const TextStyle( fontSize: 18, color: Colors.white ) ),
          )
          ]
        );
    }
}
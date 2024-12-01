import 'package:flutter/material.dart';

class RedBtn extends StatelessWidget {
  final String label;

  const RedBtn({super.key, required this.label });

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
            child: Text( '$label' , style: TextStyle( fontSize: 20, color: Colors.white ) ),
          )
          ]
        );
    }
}
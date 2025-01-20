import 'package:flutter/material.dart';

class TrainingBoxImg extends StatelessWidget {
  const TrainingBoxImg({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            width: 154, // Set the container width
            height: 122, // Set the container height
            decoration: BoxDecoration(
              color: Colors.grey[300], // Background color
              borderRadius: BorderRadius.circular(15),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15), // Ensure image follows corners
              child:  Image.asset( 
                'assets/images/training_1.png', 
                width: 154, height: 122 
              ),
            ),
          ),
          Text( "Here we are" )
        ],
      ),
    );
  }
}
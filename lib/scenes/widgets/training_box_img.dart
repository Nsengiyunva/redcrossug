import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redcross/utils/colors.dart';

class TrainingBoxImg extends StatelessWidget {
  final String label;
  final String img;

  const TrainingBoxImg({super.key, required this.label, required this.img });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed( "/training-list-items" );
      },
      child: Container(
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
                img, 
                width: 154, height: 122 
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric( vertical: 5,),
            child: Text( label, style: const TextStyle( 
            fontSize: 11.54,
            fontFamily: "Inter",
            fontWeight: FontWeight.w600,
            color: AppColors.redColorA
          ) ),
          )
        ],
      ),
      ),
    );
  }
}
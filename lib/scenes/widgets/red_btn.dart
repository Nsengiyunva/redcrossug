import 'package:flutter/material.dart';
import 'package:redcross/utils/colors.dart';

class RedBtn extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  bool? squared;

  RedBtn({super.key, required this.label, required this.onPressed, this.squared });

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      height: ( screenWidth * 0.25 ) / 2,
      child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
              borderRadius: squared != null ? BorderRadius.circular( 8 ) :  BorderRadius.circular( 10 )
            ),
            backgroundColor:  AppColors.primaryRedColor,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12 ),
          ),
            child: Text( label, style: const TextStyle( 
              fontWeight: FontWeight.w600, 
              fontFamily: "Inter", 
              fontSize: 14, 
              color: Colors.white 
            ) ),
          )
          ]
        ),
    );
    }
}
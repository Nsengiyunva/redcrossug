import 'package:flutter/material.dart';
import 'package:redcross/utils/colors.dart';

class LinkField extends StatelessWidget {
  final String label;

  const LinkField({super.key, required this.label });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric( horizontal: 5 ),
      padding: const EdgeInsets.symmetric( horizontal: 5 ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text( label, style: const TextStyle(  
            decoration: TextDecoration.underline, 
            decorationColor: AppColors.blueColorA,
            color: AppColors.blueColorA, 
            fontFamily: "Inter", 
            fontSize: 11.37, 
            fontWeight: FontWeight.w400 
            )
          ),
          const Icon(
            Icons.arrow_outward_sharp,
            size: 12,
            color: AppColors.blueColorA
          )
        ],
      ),
    );
  }
}
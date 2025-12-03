// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:redcross/utils/colors.dart';

class PasswordField extends StatelessWidget {
  final String question;
  final TextEditingController textEditingController;

  const PasswordField({ 
    super.key, 
    required this.question, 
    required this.textEditingController
  } );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 49,
            child: TextField(
            obscureText: true,
            controller: textEditingController,
            style: const TextStyle( 
              fontFamily: "Inter", 
              fontSize: 14, 
              color: Color(0xFF293041) 
            ),
            decoration: InputDecoration(
              suffixIcon: const Icon(
                Icons.visibility_off
              ),
              alignLabelWithHint: true,
              fillColor: AppColors.whiteColor,
              labelText: question,
              labelStyle: const TextStyle(color: AppColors.blackColor),
              border: const OutlineInputBorder(),
              contentPadding: const EdgeInsets.symmetric( vertical: 5, horizontal: 10 ),

              enabledBorder: OutlineInputBorder(  // Border when not focused
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColors.borderColorGrey, width: 2),
              ),
              focusedBorder: OutlineInputBorder(  // Border when focused
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColors.primaryRedColor, width: 2),
              ),
              errorBorder: OutlineInputBorder(   // Border when error occurs
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColors.primaryRedColor, width: 2),
              ),
            )
           )
          )
          ],
          ),
        );
      }
}
import 'package:flutter/material.dart';
import 'package:redcross/utils/colors.dart';

class FormPassword extends StatelessWidget {
  final String question;
  final TextEditingController textEditingController;

  const FormPassword({ 
    super.key, 
    required this.question, 
    required this.textEditingController
  } );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(question, style: const TextStyle( fontSize: 12.74, fontFamily: "Inter", fontWeight: FontWeight.w500, color: Color(0xFF000000) )),
              const SizedBox( height: 2 ),
              TextField(
                controller: textEditingController,
                obscureText: true, 
                style: const TextStyle( 
                  fontFamily: "Inter", 
                  fontSize: 12.74, 
                  color: AppColors.greyColorC,
                  fontWeight: FontWeight.w500
                ),
                decoration: InputDecoration(
                  suffixIcon: Icon(
                    Icons.remove_red_eye,
                    color: AppColors.greyColorC
                  ),

                  border: const OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(  // Border when not focused
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFFD2D9DE), width: 1 ),
                  ),
                  focusedBorder: OutlineInputBorder(  // Border when focused
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFFED1C24), width: 1 ),
                  ),
                  errorBorder: OutlineInputBorder(   // Border when error occurs
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFFED1C24), width:  1),
                  )
                ),
              ),
            ],
          ),
        ),
        );
      }
}
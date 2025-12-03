// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  final String question;
  final TextEditingController textEditingController;

  const TextFieldInput({ 
    super.key, 
    required this.question, 
    required this.textEditingController
  } );

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: ( screenWidth * 0.25 ) / 2,
            child: TextField(
            controller: textEditingController,
            style: const TextStyle( fontFamily: "Inter", fontSize: 14, color: Color(0xFF293041) ),
            decoration: InputDecoration(
              alignLabelWithHint: true,
              fillColor: Colors.white,
              labelText: question,
              labelStyle: const TextStyle(color: Colors.black),
              border: const OutlineInputBorder(),
              contentPadding: const EdgeInsets.symmetric( vertical: 5, horizontal: 10 ),

              enabledBorder: OutlineInputBorder(  // Border when not focused
                borderRadius: BorderRadius.circular(18),
                borderSide: const BorderSide(color: Color(0xFFD2D9DE), width: 2),
              ),
              focusedBorder: OutlineInputBorder(  // Border when focused
                borderRadius: BorderRadius.circular(18),
                borderSide: const BorderSide(color: Color(0xFFED1C24), width: 2),
              ),
              errorBorder: OutlineInputBorder(   // Border when error occurs
                borderRadius: BorderRadius.circular(18),
                borderSide: const BorderSide(color: Color(0xFFED1C24), width: 2),
              ),
            )
           )
          )
          ],
          ),
        );
      }
}
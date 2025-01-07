import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  final String question;
  final TextEditingController textEditingController;

 const TextFieldInput({super.key,  required this.question, required this.textEditingController } );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TextField(
            controller: textEditingController,
            style: const TextStyle(color: Colors.black, fontSize: 24 ),
            decoration: InputDecoration(
              alignLabelWithHint: true,
              fillColor: Colors.white54,
              labelText: question,
              labelStyle: const TextStyle(color: Colors.black),
              border: const OutlineInputBorder(),
              contentPadding: const EdgeInsets.symmetric( vertical: 15, horizontal: 10 ),
              // focusColor: Colors.white60
              enabledBorder: OutlineInputBorder(  // Border when not focused
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Color(0xFFD2D9DE), width: 2),
              ),
              focusedBorder: OutlineInputBorder(  // Border when focused
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Color(0xFFED1C24), width: 2),
              ),
              errorBorder: OutlineInputBorder(   // Border when error occurs
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Color(0xFFED1C24), width: 2),
              ),
            )
          )
          ],
          ),
        );
      }
}
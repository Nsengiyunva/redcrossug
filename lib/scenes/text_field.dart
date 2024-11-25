import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  final String question;
  // final String placeholder;

 TextFieldInput({ required this.question } );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          // Text( question, style: TextStyle( fontSize: 24 ), ),
          TextField(
            style: TextStyle(color: Colors.black, fontSize: 24 ),
            decoration: InputDecoration(
            labelText: question,
            labelStyle: TextStyle(color: Colors.black),
            border: OutlineInputBorder(),
            )
          )
          ],
          ),
        );
      }
}
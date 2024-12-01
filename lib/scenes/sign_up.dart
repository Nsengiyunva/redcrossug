import 'package:flutter/material.dart';
import 'package:redcross/scenes/red_btn.dart';
import 'package:redcross/scenes/text_field.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.maxFinite,
          margin: const EdgeInsets.symmetric(vertical: 30.0),
          padding: const EdgeInsets.symmetric(vertical: 80.0, horizontal: 25.0),
          child: const Column(
          children: [
            Text( "Lets get to know you", style: TextStyle( fontSize: 24, color: Colors.black ) ),
            SizedBox( height: 10 ),
            TextFieldInput( question: 'Name'),
            SizedBox( height: 10 ),
            TextFieldInput( question: 'Email Address'),
            SizedBox( height: 10 ),
            TextFieldInput( question: 'Date of Birth'),
            SizedBox( height: 10 ),
             TextFieldInput( question: 'Country'),
            SizedBox( height: 10 ),
            TextFieldInput( question: 'NIN/Passport Number'),
            SizedBox( height: 10 ),
            TextFieldInput( question: 'Password'),
            SizedBox( height: 10 ),
            TextFieldInput( question: 'Confirm Password'),
            SizedBox( height: 10 ),
            RedBtn( label: 'Continue' )
          ],
        ),
        )
      )
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
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
          child: Column(
          children: [
            const Text( "Lets get to know you", style: TextStyle( fontSize: 24, color: Colors.black ) ),
             const SizedBox( height: 10 ),
            TextFieldInput( question: 'Name'),
            const SizedBox( height: 10 ),
            TextFieldInput( question: 'Email Address'),
            const SizedBox( height: 10 ),
            TextFieldInput( question: 'Date of Birth'),
            const SizedBox( height: 10 ),
             TextFieldInput( question: 'Country'),
            const SizedBox( height: 10 ),
            TextFieldInput( question: 'NIN/Passport Number'),
            const SizedBox( height: 10 ),
            TextFieldInput( question: 'Password'),
            const SizedBox( height: 10 ),
            TextFieldInput( question: 'Confirm Password'),
            const SizedBox( height: 10 ),
            const RedBtn()
          ],
        ),
        )
      )
    );
  }
}
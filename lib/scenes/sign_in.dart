import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:redcross/scenes/red_btn.dart';
import 'package:redcross/scenes/text_field.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

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
            const Text( "Welcome Back", style: TextStyle( fontSize: 30, color: Colors.black ) ),
            const Center(
              child: Text( "Good to see you again! Ready to make an impact? Let’s get started.",
                style: TextStyle( fontSize: 18, color: Colors.black ) )  ,
            ),
            const SizedBox( height: 25 ),
            TextFieldInput(question: 'Phone Number'),
            const SizedBox( height: 25 ),
            TextFieldInput(question: 'Password'),
            const SizedBox( height: 10 ),
            const RedBtn(),
            const SizedBox( height: 50 ),
            const Row( 
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text( "Keep me Signed In", style: TextStyle( fontSize: 20 ) ),
                Text( "Forgot Password", style: TextStyle( fontSize: 20, color: Colors.red ) )
              ],
            ),
            const SizedBox( height: 25 ),
            const Center(
              child: Column(
                children: [
                  Text( "Don't have an account?", style: TextStyle( fontSize:20 ), ),
                  Text( "Register", style: TextStyle( fontSize:20 ) )
                ],
              )
            )
          ],
         ),
        )
      )
    );
  }
}
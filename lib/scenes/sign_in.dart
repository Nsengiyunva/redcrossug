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
          margin: EdgeInsets.symmetric(vertical: 30.0),
          padding: EdgeInsets.symmetric(vertical: 80.0, horizontal: 25.0),
          child: Column(
          children: [
            Text( "Welcome Back", style: TextStyle( fontSize: 30, color: Colors.black ) ),
            Center(
              child: Text( "Good to see you again! Ready to make an impact? Let’s get started.", 
                // TextAlign.center, 
                style: TextStyle( fontSize: 18, color: Colors.black ) ),
            ),
            SizedBox( height: 25 ),
            TextFieldInput(question: 'Phone Number'),
            SizedBox( height: 25 ),
            TextFieldInput(question: 'Password'),
            SizedBox( height: 10 ),
            RedBtn(),
            SizedBox( height: 50 ),
            Row( 
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text( "Keep me Signed in", style: TextStyle( fontSize: 16 ) ),
                Text( "Forgot Password", style: TextStyle( fontSize: 18, color: Colors.red ) )
              ],
            )
          ],
        ),
        )
      )
    );
  }
}
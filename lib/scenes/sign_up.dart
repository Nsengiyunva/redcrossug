import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:redcross/scenes/red_btn.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

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
            Text( "Lets get to know you", style: TextStyle( fontSize: 24, color: Colors.black ) ),
            // RedBtn()
          ],
        ),
        )
      )
    );
  }
}
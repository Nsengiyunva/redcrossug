import 'package:flutter/material.dart';
import 'package:redcross/scenes/country_picker.dart';
import 'package:redcross/scenes/red_btn.dart';


class SignPhoneIn extends StatelessWidget {
  const SignPhoneIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.maxFinite,
          margin: const EdgeInsets.symmetric(vertical: 30.0),
          padding: const EdgeInsets.symmetric(vertical: 80.0, horizontal: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text( "Enter your Number", style: TextStyle( fontSize: 24, color: Colors.black ) ),
              const SizedBox( height: 15 ),
              const CountryPicker(title: 'Test',),
              const SizedBox( height: 15 ),
              RedBtn(label: "Continue", onPressed: () {  },)
            ],
         ),
        )
      )
    );
  }
}
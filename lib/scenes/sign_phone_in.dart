import 'package:flutter/material.dart';
import 'package:redcross/scenes/widgets/flag_code.dart';
import 'package:get/get.dart';
import 'package:redcross/scenes/country_picker.dart';
import 'package:redcross/scenes/picker_country.dart';
import 'package:redcross/scenes/red_btn.dart';
import 'package:redcross/scenes/widgets/phone_number_field.dart';


class SignPhoneIn extends StatefulWidget {
  const SignPhoneIn({super.key});

  @override
  _SignInPhoneState createState() => _SignInPhoneState();
}

class _SignInPhoneState extends State<SignPhoneIn> {

  void _handleTelephoneChange(String val) {
    print( "Telephone is: $val" );
  }

  @override
  Widget build( BuildContext context ) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric( vertical: 20.0),
          padding: EdgeInsets.symmetric( vertical: 25.0, horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox( height: 50 ),
              const Padding(
                padding: EdgeInsets.symmetric( horizontal: 15 ),
                child: Text( "Enter your Number", 
                style: TextStyle( 
                  fontSize: 20.14, 
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF545454),
                  fontFamily: "Manrope"
                ) ),
              ),
              SizedBox( height: 10 ),
              PhoneNumberField(handleTelephoneChange: ( String telephone ) { 
                _handleTelephoneChange( telephone!  );
              },),
              SizedBox( height: 15 ),
              Padding(
                padding: EdgeInsets.symmetric( horizontal: 10 ),
                child: RedBtn(label: "Continue", onPressed: () {  
                  Get.toNamed( "/enter-otp" );
                },),
              )
            ],
         ),
        )
      )
    );
  }
}



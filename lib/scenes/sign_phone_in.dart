import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redcross/controllers/login_controller.dart';
import 'package:redcross/scenes/red_btn.dart';
import 'package:redcross/scenes/widgets/phone_number_field.dart';


class SignPhoneIn extends StatefulWidget {
  SignPhoneIn({super.key});

  final LoginController _phoneController = Get.put( LoginController());

  @override
  _SignInPhoneState createState() => _SignInPhoneState();
}

class _SignInPhoneState extends State<SignPhoneIn> {

  @override
  Widget build( BuildContext context ) {

    print( widget._phoneController.newPhoneNumber.value );
    
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric( vertical: 20.0),
          padding: const EdgeInsets.symmetric( vertical: 25.0, horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox( height: 50 ),
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
              const SizedBox( height: 10 ),
              PhoneNumberField(textEditingController: widget._phoneController.newPhoneNumber,),
              const SizedBox( height: 15 ),
              Padding(
                padding: const EdgeInsets.symmetric( horizontal: 10 ),
                child: RedBtn(label: "Continue", onPressed: () {  
                  widget._phoneController.submitForm();
                  // Get.toNamed( "/enter-otp", arguments: { 
                  //   "phone_number":  widget._phoneController.newPhoneNumber.text 
                  // } );
                },),
              )
            ],
         ),
        )
      )
    );
  }
}



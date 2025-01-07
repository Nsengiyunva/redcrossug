import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redcross/controllers/login_controller.dart';
import 'package:redcross/scenes/red_btn.dart';
import 'package:redcross/scenes/text_field.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});

  final LoginController _loginController = Get.put( LoginController());

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
            TextFieldInput( question: 'Name', textEditingController: _loginController.registerName,),
            const SizedBox( height: 10 ),
            TextFieldInput( question: 'Email Address', textEditingController: _loginController.registerEmail),
            const SizedBox( height: 10 ),
            TextFieldInput( question: 'Date of Birth', textEditingController: _loginController.registerDOB),
            const SizedBox( height: 10 ),
             TextFieldInput( question: 'Country', textEditingController: _loginController.registerCountry),
            const SizedBox( height: 10 ),
            TextFieldInput( question: 'NIN/Passport Number', textEditingController: _loginController.registerNIN ),
            const SizedBox( height: 10 ),
            TextFieldInput( question: 'Password', textEditingController: _loginController.registerPassword ),
            const SizedBox( height: 10 ),
            TextFieldInput( question: 'Confirm Password', textEditingController: _loginController.registerConfirmPassword ),
            const SizedBox( height: 10 ),
            RedBtn( label: 'Continue', onPressed: () { 
              Get.toNamed( "/account-creation-success" );
            }, )
          ],
        ),
        )
      )
    );
  }
}
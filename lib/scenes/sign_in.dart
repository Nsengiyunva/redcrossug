import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redcross/controllers/login_controller.dart';
import 'package:redcross/scenes/red_btn.dart';
import 'package:redcross/scenes/text_field.dart';

class SignIn extends StatelessWidget {
  SignIn({super.key});

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
            const Text( "Welcome Back", style: TextStyle( fontSize: 30, color: Colors.black ) ),
            const Center(
              child: Text( "Good to see you again! Ready to make an impact? Let’s get started.",
                style: TextStyle( fontSize: 18, color: Colors.black ) )  ,
            ),
            const SizedBox( height: 25 ),
            TextFieldInput(question: 'Phone Number', textEditingController: _loginController.telephoneController,),
            const SizedBox( height: 25 ),
            TextFieldInput(question: 'Password', textEditingController: _loginController.passwordController ),
            const SizedBox( height: 10 ),
            RedBtn( label: 'Continue', onPressed: () => {
              _loginController.loginPhoneNumber()
            } ),
            const SizedBox( height: 50 ),
            const Row( 
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text( "Keep me Signed In", style: TextStyle( fontSize: 20 ) ),
                Text( "Forgot Password", style: TextStyle( fontSize: 20, color: Colors.red ) )
              ],
            ),
            const SizedBox( height: 25 ),
            Center(
              child: Column(
                children: [
                  const Text( "Don't have an account?", style: TextStyle( fontSize:20 ), ),
                  // Text( "Register", style: TextStyle( fontSize:20 ) )
                  TextButton(
                    onPressed: () {
                     Get.toNamed( "/register-account" );
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.black,         // Text color
                      backgroundColor: Colors.white,          // Button background color
                      padding: const EdgeInsets.all(15),           // Padding inside the button
                      textStyle: const TextStyle( fontSize: 20 ),    // Text style
                    ),
                    child: const Text( "Register here" ),
                  )
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
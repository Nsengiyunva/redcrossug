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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text( "Welcome Back", style: TextStyle( fontSize: 23.12, fontFamily: "Manrope", fontWeight: FontWeight.w700, color: Color(0xFF545454) ) ),
            const Center(
              child: Text( "Good to see you again! Ready to make an impact? Let’s get started.",
                style: TextStyle( fontFamily: "Inter", fontSize: 16.99, color: Color(0xFF7D8FAB) ) )  ,
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
            Row( 
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Icon(
                      Icons.check_box_rounded,
                      color: Color(0xFFED1C24),
                      size: 24.0,
                    ),
                    Text( "Keep me Signed In", style: TextStyle( fontWeight: FontWeight.w400, fontFamily: "Inter", fontSize: 13.04, color: Color(0xFF293041) ) ),
                  ],
                ),
                TextButton(
                  onPressed: () {
                  //  Get.toNamed( "/register-account" );
                  },
                  style: TextButton.styleFrom(
                    // foregroundColor: Color(0xFFED1C24),    
                    backgroundColor: Colors.white,
                    // padding: const EdgeInsets.all(15),
                    // textStyle: const TextStyle( fontSize: 20 ),
                  ),
                  child: Text( "Forgot Password", style: TextStyle( fontWeight: FontWeight.w400, fontFamily: "Inter", fontSize: 12.8, color: Color(0xFFED1C24), decoration: TextDecoration.underline, decorationColor: Color(0xFFED1C24) ) ),
                )
              ],
            ),
            const SizedBox( height: 25 ),
            Center(
              child: Column(
                children: [
                  const Text( "Don't have an account?", style: TextStyle( fontSize: 15.98, fontFamily: "Inter", fontWeight: FontWeight.w400, color: Color(0xFF7D8FAB) ), ),
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
                    child: Text( "Register", style: TextStyle( decoration: TextDecoration.underline, decorationColor: Color(0xFF545454), fontFamily: "Inter", fontSize: 17, color: Color(0xFF7D8FAB) ) ),
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
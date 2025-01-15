import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redcross/controllers/login_controller.dart';
import 'package:redcross/scenes/red_btn.dart';


class OtpVerify extends StatelessWidget {
  final LoginController _loginController = Get.put( LoginController());

  OtpVerify({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.maxFinite,
          margin: const EdgeInsets.symmetric(vertical: 30.0),
          padding:   const EdgeInsets.symmetric(vertical: 50.0, horizontal: 50.0),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox( height: 50 ),
              const Text( "Confirm Your Number", 
              style: TextStyle( 
                fontSize: 20.14, 
                fontWeight: FontWeight.w600,
                color: Color(0xFF545454),
                fontFamily: "Manrope"
              ) ),
              const Text( "A verification code consisting of six digits has been dispatched. Please input this code to confirm your phone number.", 
                style: TextStyle( 
                  fontSize: 13.18, 
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF393939),
                  fontFamily: "Inter"
                ) ),
                const SizedBox( height: 10 ),
                const Text( "The code has been sent to", 
                  style: TextStyle( 
                    fontSize: 13.18, 
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF545454),
                    fontFamily: "Inter"
                  ) 
              ),
              const SizedBox( height: 25 ),
              Center(
                child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(5, (index) {
                  return SizedBox(
                    width: 54,
                    height: 50,
                    child: TextField(
                      controller: _loginController.fieldControllers[index],
                      focusNode: _loginController.fieldFocusNode[index],
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      maxLength: 1,
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        counterText: '',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0), // Border radius here
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0), // Border radius for the default state
                          borderSide: const BorderSide(color: Color(0xFFED1C24), width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0), // Border radius for the focused state
                          borderSide: const BorderSide(color: Color(0xFFED1C24), width: 1.0),
                        ),
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty && index < 4) {
                          _loginController.fieldFocusNode[index + 1].requestFocus();
                        } else if (value.isEmpty && index > 0) {
                          _loginController.fieldFocusNode[index - 1].requestFocus();
                        }
                      },
                    ),
                  );
                }),
              ),
              ),
              const SizedBox( height: 25 ),
              RedBtn( label: 'Continue', onPressed: () {  
                Get.toNamed( "/register-account" );
              }, ),
              const SizedBox( height: 5 ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text( "Didn't receive your code ?", style: TextStyle( fontFamily: "Inter", fontWeight: FontWeight.w500, fontSize: 10.88, color: Color(0xFF848484) ) ),
                    TextButton(
                    onPressed: () {
                      // print('Transparent Button Pressed');
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.blue, // Text color
                      backgroundColor: Colors.white, // Transparent background
                      padding: const EdgeInsets.only( left: 1 ),
                    ),
                    child: const Text('Resend', style: TextStyle( fontFamily: "Inter", fontWeight: FontWeight.w600, fontSize: 10.88, color: Color(0xFF171717) ) ),
                  )
                ],
                ),
                ],
              )
            ],
          )
          ),
        ),
    );
  }
}


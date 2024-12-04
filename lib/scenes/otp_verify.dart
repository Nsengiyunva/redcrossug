import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:redcross/scenes/red_btn.dart';

class VerifyOtp extends StatelessWidget {
  const VerifyOtp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.maxFinite,
          margin: const EdgeInsets.symmetric(vertical: 30.0),
          padding: const EdgeInsets.symmetric(vertical: 100.0, horizontal: 25.0),
          child: Column(
          children: [
            const Text( "Confirm Your Number", style: TextStyle( fontSize: 32, color: Colors.black ) ),
            const Text( "A verification code consisting of six digits has been dispatched. Please input this code to confirm your phone number." ),
             const SizedBox( height: 25 ),
            OtpTextField(
                numberOfFields: 5,
                borderColor: const Color(0xFF512DA8),
                //set to true to show as box or false to show as dash
                showFieldAsBox: true, 
                //runs when a code is typed in
                onCodeChanged: (String code) {
                    //handle validation or checks here           
                },
                //runs when every textfield is filled
                onSubmit: (String verificationCode){
                    showDialog(
                        context: context,
                        builder: (context){
                        return AlertDialog(
                            title: const Text("Verification Code"),
                            content: Text('Code entered is $verificationCode'),
                        );
                        }
                    );
                }, // end onSubmit
            ),
            const SizedBox( height: 25 ),
            RedBtn( label: 'Continue', onPressed: () {  }, )
          ],
        ),
        )
      )
    );
  }
}
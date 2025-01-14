import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redcross/controllers/login_controller.dart';
import 'package:redcross/controllers/otp_controller.dart';
import 'package:redcross/scenes/red_btn.dart';


class OtpVerify extends StatelessWidget {
  // final OtpController _otpFieldController = Get.put( OtpController());
  final LoginController _loginController = Get.put( LoginController());

  OtpVerify({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.maxFinite,
          margin: const EdgeInsets.symmetric(vertical: 30.0),
          padding:   const EdgeInsets.symmetric(vertical: 50.0, horizontal: 25.0),
          child: Column(
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
              SizedBox( height: 25 ),
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
              const SizedBox( height: 25 ),
              TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text('Submit'),
            ),
          ],
        ),
        )
      ),
    );
  }
}


// import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
// import 'package:get/get.dart';
// import 'package:redcross/scenes/red_btn.dart';
// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';

// class OtpVerify extends StatelessWidget {
//   OtpVerify({super.key});

//   TextEditingController textEditingController = TextEditingController();
//   // ..text = "123456";

//   // ignore: close_sinks
//   StreamController<ErrorAnimationType>? errorController;

//   @override
//   Widget build(BuildContext context) {

//     // final arguments = Get.arguments;
//     // final String phone_number = arguments['phone_number']! ?? "+256772123123";

//     // print( "telephone $arguments" );

//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Container(
//           width: double.maxFinite,
//           margin: EdgeInsets.symmetric(vertical: 30.0),
//           padding:   EdgeInsets.symmetric(vertical: 100.0, horizontal: 25.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text( "Confirm Your Number", 
//               style: TextStyle( 
//                 fontSize: 20.14, 
//                 fontWeight: FontWeight.w600,
//                 color: Color(0xFF545454),
//                 fontFamily: "Manrope"
//               ) ),
//               const Text( "A verification code consisting of six digits has been dispatched. Please input this code to confirm your phone number.", 
//                 style: TextStyle( 
//                   fontSize: 13.18, 
//                   fontWeight: FontWeight.w600,
//                   color: Color(0xFF393939),
//                   fontFamily: "Inter"
//                 ) ),
//                 SizedBox( height: 10 ),
//                 const Text( "The code has been sent to", 
//                   style: TextStyle( 
//                     fontSize: 13.18, 
//                     fontWeight: FontWeight.w600,
//                     color: Color(0xFF545454),
//                     fontFamily: "Inter"
//                   ) 
//               ),
//               SizedBox( height: 25 ),
//               PinCodeTextField(
//                     appContext: context,
//                     pastedTextStyle: TextStyle(
//                       color: Colors.green.shade600,
//                       fontWeight: FontWeight.bold,
//                     ),
//                     length: 5,
//                     obscureText: false,
//                     obscuringCharacter: '*',
//                     obscuringWidget: const FlutterLogo(
//                       size: 24,
//                     ),
//                     blinkWhenObscuring: true,
//                     animationType: AnimationType.fade,
//                     validator: (v) {
//                       if (v!.length < 3) {
//                         return "I'm from validator";
//                       } else {
//                         return null;
//                       }
//                     },
//                     pinTheme: PinTheme(
//                       shape: PinCodeFieldShape.box,
//                       borderRadius: BorderRadius.circular(5),
//                       fieldHeight: 50,
//                       fieldWidth: 40,
//                       activeFillColor: Colors.white,
//                     ),
//                     cursorColor: Colors.black,
//                     animationDuration: const Duration(milliseconds: 300),
//                     enableActiveFill: true,
//                     errorAnimationController: errorController,
//                     controller: textEditingController,
//                     keyboardType: TextInputType.number,
//                     boxShadows: const [
//                       BoxShadow(
//                         offset: Offset(0, 1),
//                         color: Colors.black12,
//                         blurRadius: 10,
//                       )
//                     ],
//                     onCompleted: (v) {
//                       debugPrint("Completed");
//                     },
//                     // onTap: () {
//                     //   print("Pressed");
//                     // },
//                     onChanged: (value) {
//                       debugPrint(value);
//                       // setState(() {
//                       //   currentText = value;
//                       // });
//                     },
//                     beforeTextPaste: (text) {
//                       debugPrint("Allowing to paste $text");
//                       //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
//                       //but you can show anything you want here, like your pop up saying wrong paste format or etc
//                       return true;
//                     },
//                   ),
//             const SizedBox( height: 25 ),
//             RedBtn( label: 'Continue', onPressed: () {  
//               Get.toNamed( "/register-account" );
//             }, )
//           ],
//         ),
//         )
//       )
//     );
//   }
// }



// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';

// import './constants/constants.dart';


// class OtpVerify extends StatefulWidget {
//   const OtpVerify({
//     super.key,
//     this.phoneNumber,
//   });

//   final String? phoneNumber;

//   @override
//   State<OtpVerify> createState() =>
//       _PinCodeVerificationScreenState();
// }

// class _PinCodeVerificationScreenState extends State<OtpVerify> {
//   TextEditingController textEditingController = TextEditingController();
//   // ..text = "123456";

//   // ignore: close_sinks
//   StreamController<ErrorAnimationType>? errorController;

//   bool hasError = false;
//   String currentText = "";
//   final formKey = GlobalKey<FormState>();

//   @override
//   void initState() {
//     errorController = StreamController<ErrorAnimationType>();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     errorController!.close();

//     super.dispose();
//   }

//   // snackBar Widget
//   snackBar(String? message) {
//     return ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message!),
//         duration: const Duration(seconds: 2),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: GestureDetector(
//         onTap: () {},
//         child: SizedBox(
//           height: MediaQuery.of(context).size.height,
//           width: MediaQuery.of(context).size.width,
//           child: ListView(
//             children: <Widget>[
//               const SizedBox(height: 30),
//               SizedBox(
//                 height: MediaQuery.of(context).size.height / 3,
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(30),
//                   child:  Image.asset( 'assets/images/redcross_main.png', width: 50, height: 50 ),
//                 ),
//               ),
//               const SizedBox(height: 8),
//               const Padding(
//                 padding: EdgeInsets.symmetric(vertical: 8.0),
//                 child: Text(
//                   'Phone Number Verification',
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//               Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
//                 child: RichText(
//                   text: TextSpan(
//                     text: "Enter the code sent to ",
//                     children: [
//                       TextSpan(
//                         text: "${widget.phoneNumber}",
//                         style: const TextStyle(
//                           color: Colors.black,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 15,
//                         ),
//                       ),
//                     ],
//                     style: const TextStyle(
//                       color: Colors.black54,
//                       fontSize: 15,
//                     ),
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               Form(
//                 key: formKey,
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(
//                     vertical: 8.0,
//                     horizontal: 30,
//                   ),
//                   child: 
//                   ,
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 30.0),
//                 child: Text(
//                   hasError ? "*Please fill up all the cells properly" : "",
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 12,
//                     fontWeight: FontWeight.w400,
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text(
//                     "Didn't receive the code? ",
//                     style: TextStyle(color: Colors.black54, fontSize: 15),
//                   ),
//                   TextButton(
//                     onPressed: () => snackBar("OTP resend!!"),
//                     child: const Text(
//                       "RESEND",
//                       style: TextStyle(
//                         color: Color(0xFF91D3B3),
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16,
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//               const SizedBox(
//                 height: 14,
//               ),
//               Container(
//                 margin:
//                     const EdgeInsets.symmetric(vertical: 16.0, horizontal: 30),
//                 decoration: BoxDecoration(
//                     color: Colors.green.shade300,
//                     borderRadius: BorderRadius.circular(5),
//                     boxShadow: [
//                       BoxShadow(
//                           color: Colors.green.shade200,
//                           offset: const Offset(1, -2),
//                           blurRadius: 5),
//                       BoxShadow(
//                           color: Colors.green.shade200,
//                           offset: const Offset(-1, 2),
//                           blurRadius: 5)
//                     ]),
//                 child: ButtonTheme(
//                   height: 50,
//                   child: TextButton(
//                     onPressed: () {
//                       formKey.currentState!.validate();
//                       // conditions for validating
//                       if (currentText.length != 6 || currentText != "123456") {
//                         errorController!.add(ErrorAnimationType
//                             .shake); // Triggering error shake animation
//                         setState(() => hasError = true);
//                       } else {
//                         setState(
//                           () {
//                             hasError = false;
//                             snackBar("OTP Verified!!");
//                           },
//                         );
//                       }
//                     },
//                     child: Center(
//                       child: Text(
//                         "VERIFY".toUpperCase(),
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 16,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Flexible(
//                     child: TextButton(
//                       child: const Text("Clear"),
//                       onPressed: () {
//                         textEditingController.clear();
//                       },
//                     ),
//                   ),
//                   Flexible(
//                     child: TextButton(
//                       child: const Text("Set Text"),
//                       onPressed: () {
//                         setState(() {
//                           textEditingController.text = "123456";
//                         });
//                       },
//                     ),
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
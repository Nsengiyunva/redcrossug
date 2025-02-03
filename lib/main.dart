import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:redcross/models/disaster_list.dart';
import 'package:redcross/scenes/ambulances/ambulance_form.dart';
import 'package:redcross/scenes/ambulances/ambulance_home.dart';
import 'package:redcross/scenes/ambulances/ambulance_map.dart';
import 'package:redcross/scenes/ambulances/ambulance_status.dart';
import 'package:redcross/scenes/ambulances/ambulance_success.dart';

import 'package:redcross/scenes/auth/account_success.dart';
import 'package:redcross/scenes/auth/otp_verify.dart';
import 'package:redcross/scenes/auth/profile.dart';
import 'package:redcross/scenes/auth/sign_in.dart';
import 'package:redcross/scenes/auth/sign_up.dart';

import 'package:redcross/scenes/disasters/disaster_list.dart';
import 'package:redcross/scenes/disasters/disaster_details.dart';
import 'package:redcross/scenes/donations/payment.dart';

import 'package:redcross/scenes/first_aid/first_aid_details.dart';
import 'package:redcross/scenes/first_aid/first_aid_emergencies.dart';
import 'package:redcross/scenes/first_aid/first_aid_home.dart';
import 'package:redcross/scenes/first_aid/screens/fa_details_home.dart';
import 'package:redcross/scenes/first_aid/training/basic_training_details.dart';
import 'package:redcross/scenes/first_aid/training/training_home.dart';
import 'package:redcross/scenes/first_aid/training/training_list.dart';

import 'package:redcross/scenes/home.dart';
import 'package:redcross/scenes/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      routes: {
        "/home": (context) => const Home(),
        "/login": (context) => SignIn(),
        "/disasters": (context) => DisasterList(),
        "/ambulance-request-form": (context) => AmbulanceForm(),
        "/ambulance-success-request": (context) => const AmbulanceSuccess(),
        "/account-creation-success": (context) => const AccountSuccess(
            button_label: 'Continue',
            title: 'Welcome aboard',
            success_message: 'Your Account has been created successfully.',
            changeColor: false),
        "/check-ambulance_status": (context) => AmbulanceStatus(),
        "/ambulance-home": (context) => AmbulanceHome(),
        "/disaster-details": (context) => const DisasterDetails(),
        "/initiate-payment": (context) => const Payment(),
        "/payment-successful": (context) => const AccountSuccess(
            button_label: 'Close',
            title: 'Thank you',
            success_message: 'Your Donation Payment was Successful',
            changeColor: true),
        "/register-account": (context) => SignUp(),
        "/splash-screen": (context) => const SplashScreen(),
        "/enter-otp": (context) => OtpVerify(),
        "/first-aid-home": (context) => const FirstAidHome(),
        "/first-aid-emergency-services": (context) =>
            const FirstAidEmergencies(),
        "/first-aid-emergency-details": (context) => const FirstAidDetails(),
        "/ambulance-map-locations": (context) => const AmbulanceMap(),
        "/first-aid-item-details": (context) => const FaDetailsHome(),
        "/training-home": (context) => const TrainingHome(),
        "/training-list-items": (context) => const TrainingList(),
        "/basic-training": (context) => const BasicTrainingDetails(),
        "/ambulance-map": (context) => const AmbulanceMap(),
        "/account-profile": (context) => const Profile()
      },
      initialRoute: "/login",
    );
  }
}

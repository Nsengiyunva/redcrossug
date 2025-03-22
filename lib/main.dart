import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';
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
import 'package:redcross/scenes/top_subscription.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  MyApp({super.key, required this.isLoggedIn});

  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // title: 'Red Cross Uganda',
      navigatorObservers: [FirebaseAnalyticsObserver(analytics: analytics)],
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
        "/disaster-details": (context) => DisasterDetails(),
        "/initiate-payment": (context) => Payment(),
        "/payment-successful": (context) => const AccountSuccess(
            button_label: 'Close',
            title: 'Thank you',
            success_message: 'Your Donation Payment was Successful',
            changeColor: true,
            payment: true),
        "/register-account": (context) => const SignUp(),
        "/splash-screen": (context) => const SplashScreen(),
        "/enter-otp": (context) => OtpVerify(),
        "/first-aid-home": (context) => const FirstAidHome(),
        "/first-aid-emergency-services": (context) =>
            const FirstAidEmergencies(),
        "/first-aid-emergency-details": (context) => const FirstAidDetails(),
        "/ambulance-map-locations": (context) => const AmbulanceMap(),
        "/first-aid-item-details": (context) => const FaDetailsHome(),
        "/training-home": (context) => const TrainingHome(),
        "/training-list-items": (context) => TrainingList(),
        "/basic-training": (context) => BasicTrainingDetails(),
        "/ambulance-map": (context) => const AmbulanceMap(),
        "/account-profile": (context) => const Profile(),
        "/top-subscribe": (context) => const TopSubscription()
      },
      initialRoute: isLoggedIn ? '/top-subscribe' : '/login',
    );
  }
}

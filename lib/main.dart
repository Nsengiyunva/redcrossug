// ignore_for_file: unused_import

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redcross/scenes/ambulances/ambulance_emergency.dart';
import 'package:redcross/scenes/ambulances/ambulance_form.dart';
import 'package:redcross/scenes/ambulances/ambulance_map.dart';
import 'package:redcross/scenes/ambulances/ambulance_services_home.dart';
import 'package:redcross/scenes/ambulances/ambulance_status.dart';
import 'package:redcross/scenes/ambulances/ambulance_success.dart';

import 'package:redcross/scenes/auth/account_success.dart';
import 'package:redcross/scenes/auth/otp_verify.dart';
import 'package:redcross/scenes/auth/profile.dart';
import 'package:redcross/scenes/auth/sign_in.dart';
import 'package:redcross/scenes/auth/sign_up.dart';
import 'package:redcross/scenes/blood_donations/blood_donation_faq_screen.dart';
import 'package:redcross/scenes/blood_donations/blood_donation_history.dart';
import 'package:redcross/scenes/blood_donations/blood_donation_history_details.dart';
import 'package:redcross/scenes/blood_donations/blood_eligibility.dart';
import 'package:redcross/scenes/blood_donations/donation_campaign_details.dart';
import 'package:redcross/scenes/blood_donations/donation_campaign_list.dart';
import 'package:redcross/scenes/blood_donations/donation_register.dart';
import 'package:redcross/scenes/blood_donations/drive_details.dart';
import 'package:redcross/scenes/default_home.dart';

import 'package:redcross/scenes/disasters/disaster_list.dart';
import 'package:redcross/scenes/disasters/disaster_details.dart';
import 'package:redcross/scenes/donations/donation_categories.dart';
import 'package:redcross/scenes/donations/donation_history.dart';
import 'package:redcross/scenes/donations/donation_receipt.dart';
import 'package:redcross/scenes/donations/home_donations.dart';
import 'package:redcross/scenes/donations/payment.dart';
import 'package:redcross/scenes/firebase_api.dart';

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

import 'package:redcross/scenes/blood_donations/blood_donations_home.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:redcross/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Firebase.initializeApp();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  FirebaseApi().initNotifications();
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
      // navigatorObservers: [FirebaseAnalyticsObserver(analytics: analytics)],
      debugShowCheckedModeBanner: false,
      // Global theme: every Text widget that doesn't explicitly set its
      // own fontFamily now falls back to "Inter" instead of the platform
      // default (Roboto/San Francisco), which was the main source of
      // mismatched fonts between screens. Explicit `fontFamily: "..."`
      // overrides in individual widgets still win, so nothing else
      // changes unless a screen was relying on the (unset) default.
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: "Inter",
        scaffoldBackgroundColor: AppColors.bgColor,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryRedColor,
          primary: AppColors.primaryRedColor,
        ),
        textTheme: ThemeData.light().textTheme.apply(fontFamily: "Inter"),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.bgColor,
          elevation: 0,
          surfaceTintColor: Colors.transparent,
          titleTextStyle: TextStyle(
            fontFamily: "Inter",
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: AppColors.blackColor,
          ),
          iconTheme: IconThemeData(color: AppColors.blackColor),
        ),
      ),
      // Clamps the device's OS-level accessibility text scaling so a
      // phone set to a very large system font size can't blow up card
      // layouts across the app — one change instead of guarding every
      // screen individually. Screens are still free to respect normal
      // (unclamped) scaling for body copy if they choose to opt out.
      builder: (context, child) {
        final mediaQuery = MediaQuery.of(context);
        return MediaQuery(
          data: mediaQuery.copyWith(
            textScaler: mediaQuery.textScaler.clamp(
              minScaleFactor: 0.9,
              maxScaleFactor: 1.2,
            ),
          ),
          child: child!,
        );
      },
      routes: {
        "/home": (context) => const Home(),
        "/main-home": (context) => const DefaultHome(),
        "/login": (context) => SignIn(),
        "/disasters": (context) => DisasterList(),
        "/blood-donations": (context) => const BloodDonationsHome(),
        "/blood-donation-history": (context) => const BloodDonationHistory(),
        "/donation-campaign-details": (context) =>
            const DonationCampaignDetails(
              campaign: {},
            ),
        "/blood-history-details": (context) =>
            const BloodDonationHistoryDetails(),
        "/blood-donations-campaigns-list": (context) => DonationCampaignList(),
        "/blood-donation-register": (context) => const DonationRegister(
            // payload: {},
            ),
        "/blood-donation-eligibility": (context) => const BloodEligibility(),
        "/blood-donation-faqs": (context) => const BloodDonationFaqScreen(),
        "/ambulance-request-form": (context) => AmbulanceForm(),
        "/ambulance-success-request": (context) => const AmbulanceSuccess(),
        "/account-creation-success": (context) => const AccountSuccess(
            button_label: 'Continue',
            title: 'Welcome aboard',
            success_message: 'Your Account has been created successfully.',
            changeColor: false),
        "/check-ambulance_status": (context) => AmbulanceStatus(),
        "/ambulance-home": (context) => AmbulanceServicesHome(),
        "/ambulance-emergency-form": (context) => AmbulanceEmergency(),
        // "/disaster-details": (context) => DisasterDetails(title: "", id: 0),
        // "/initiate-payment": (context) => Payment(),
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
        "/top-subscribe": (context) => const TopSubscription(),
        "/home-donations": (context) => const HomeDonations(),
        "/donations-categories": (context) => const DonationCategories(),
        "/donation-category-details": (context) => DriveDetails(),
        "/donation-history-list": (context) => const DonationHistory(),
        "/donation-receipt": (context) => const DonationReceipt(),
      },
      initialRoute: isLoggedIn ? '/home' : '/login',
    );
  }
}

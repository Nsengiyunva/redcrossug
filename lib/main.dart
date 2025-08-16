import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
      navigatorObservers: [FirebaseAnalyticsObserver(analytics: analytics)],
      debugShowCheckedModeBanner: false,
      routes: {
        "/home": (context) => const Home(),
        "/login": (context) => SignIn(),
        "/disasters": (context) => DisasterList(),
        "/blood-donations": (context) => BloodDonationsHome(),
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
      // initialRoute: isLoggedIn ? '/top-subscribe' : '/login',
      initialRoute: '/login',
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: Text('Trigger Firebase Function v2')),
//         body: Center(child: CloudFunctionButton()),
//       ),
//     );
//   }
// }

// class CloudFunctionButton extends StatefulWidget {
//   @override
//   _CloudFunctionButtonState createState() => _CloudFunctionButtonState();
// }

// class _CloudFunctionButtonState extends State<CloudFunctionButton> {
//   String responseMessage = "Press the button to trigger function";

//   Future<void> triggerCloudFunction() async {
//     final url = Uri.parse(
//         "https://us-central1-redcrossug-f3737.cloudfunctions.net/helloWorld");

//     try {
//       final response = await http.get(url);

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         print("response ${data}");
//         setState(() {
//           responseMessage = data["message"];
//         });
//       } else {
//         setState(() {
//           responseMessage = "Error: ${response.statusCode}";
//         });
//       }
//     } catch (e) {
//       setState(() {
//         responseMessage = "Request failed: $e";
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         ElevatedButton(
//           onPressed: triggerCloudFunction,
//           child: Text("Trigger Cloud Function"),
//         ),
//         SizedBox(height: 20),
//         Text(responseMessage, textAlign: TextAlign.center),
//       ],
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:google_api_availability/google_api_availability.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();

//   FirebaseMessaging messaging = FirebaseMessaging.instance;

//   // Request permission for notifications
//   NotificationSettings settings = await messaging.requestPermission(
//     alert: true,
//     badge: true,
//     sound: true,
//   );

//   print("User granted permission: ${settings.authorizationStatus}");
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: Text('Push Notification Example')),
//         body: Center(child: NotificationButton()),
//       ),
//     );
//   }
// }

// class NotificationButton extends StatefulWidget {
//   @override
//   _NotificationButtonState createState() => _NotificationButtonState();
// }

// class _NotificationButtonState extends State<NotificationButton> {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   String? deviceToken;

//   @override
//   void initState() {
//     super.initState();
//     getDeviceToken();
//   }

//   Future<void> getDeviceToken() async {
//     String? token = await FirebaseMessaging.instance.getToken();
//     setState(() {
//       deviceToken = token;
//     });
//     print("Device Token: $deviceToken");
//   }

//   Future<void> sendNotification() async {
//     if (deviceToken == null) {
//       print("Device token is null!");
//       return;
//     }

//     await _firestore.collection("notifications").add({
//       "title": "Hello!",
//       "body": "You have a new notification!",
//       "token": deviceToken,
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: sendNotification,
//       child: Text("Send Notification"),
//     );
//   }
// }

// import 'package:firebase_messaging/firebase_messaging.dart';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:redcross/firebase_msg.dart';
// import 'package:redcross/models/note.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();

//   await FirebaseMsg().initFCM();

//   runApp(MyApp());
// }

// class MyApp extends StatefulWidget {
//   @override
//   State<MyApp> createState() => MyAppState();
// }

// class MyAppState extends State<MyApp> {
//   List<Note> notes = [];

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: const Text('Push Notification Example')),
//         body: Center(
//             child: Column(
//           children: [
//             const Text('Heleynah'),
//             ElevatedButton(
//                 onPressed: () async {
//                   await addNote(context);
//                   setState(() {});
//                 },
//                 child: const Text("Add An Item"))
//           ],
//         )),
//       ),
//     );
//   }

//   addNote(BuildContext context) async {
//     FirebaseMessaging messaging = FirebaseMessaging.instance;
//     var token = await messaging.getToken();

//     FirebaseFirestore db = FirebaseFirestore.instance;
//     await db.collection("Notes").doc(DateTime.now().toString()).set({
//       'noteId': DateTime.now(),
//       'title': 'Queens 1',
//       'desc': 'Queens 2',
//       'token': token,
//     }).then((value) => {
//           print("we are here ---")
//           // ScaffoldMessenger.of(context)
//           //     .showSnackBar(SnackBar(content: Text("Added successfully.")))
//         });
//   }
// }

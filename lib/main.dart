import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redcross/scenes/account_success.dart';
import 'package:redcross/scenes/ambulance_form.dart';
import 'package:redcross/scenes/ambulance_home.dart';
import 'package:redcross/scenes/ambulance_status.dart';
import 'package:redcross/scenes/ambulance_success.dart';
import 'package:redcross/scenes/disaster_list.dart';
import 'package:redcross/scenes/home.dart';
import 'package:redcross/scenes/sign_in.dart';

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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        "/home": ( context ) => const Home(),
        "/login": ( context ) => SignIn(),
        "/disasters": ( context ) => DisasterList(),
        "/ambulance-request-form": ( context ) => AmbulanceForm(),
        "/ambulance-success-request": ( context ) => const AmbulanceSuccess(),
        "/account-creation-success": ( context ) => const AccountSuccess(button_label: 'Test', title: 'Tester', success_message: 'Testing',),
        "/check-ambulance_status": ( context ) => AmbulanceStatus(),
        "/ambulances-home": ( context ) => AmbulanceHome(),
      },
      initialRoute: "/login",
    );
  }
}


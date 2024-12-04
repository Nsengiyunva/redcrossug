import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redcross/scenes/disaster_list.dart';
import 'package:redcross/scenes/home.dart';
import 'package:redcross/scenes/sign_in.dart';
import 'package:redcross/scenes/sign_phone_in.dart';
// import 'package:get';

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
        "/home": ( context ) => Home(),
        "/login": ( context ) => SignIn(),
        "/disasters": ( context ) => const DisasterList()
      },
      initialRoute: "/login",
    );
  }
}
//home: const SignPhoneIn()


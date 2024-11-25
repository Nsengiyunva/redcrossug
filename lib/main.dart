import 'package:flutter/material.dart';
import 'package:redcross/scenes/account_success.dart';
import 'package:redcross/scenes/home.dart';
import 'package:redcross/scenes/otp_verify.dart';
import 'package:redcross/scenes/sign_in.dart';
import 'package:redcross/scenes/sign_up.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Home()
    );
  }
}


import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:redcross/utils/colors.dart';

class TopSubscription extends StatefulWidget {
  const TopSubscription({super.key});

  @override
  State<TopSubscription> createState() => _TopSubscriptionState();
}

class _TopSubscriptionState extends State<TopSubscription> {
  final FirebaseMessaging _firebase_messaging = FirebaseMessaging.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: AppBar(
            title: const Text(""),
            leading: const BackButton() // Back button added here
            ),
        body: Container(
          child: const Text("Firebase 1"),
        ));
  }
}

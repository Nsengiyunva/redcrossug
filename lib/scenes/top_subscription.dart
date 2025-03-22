import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class TopSubscription extends StatefulWidget {
  const TopSubscription({super.key});

  @override
  State<TopSubscription> createState() => _TopSubscriptionState();
}

class _TopSubscriptionState extends State<TopSubscription> {
  final FirebaseMessaging _firebase_messaging = FirebaseMessaging.instance;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Top Subscription Screen"),
    );
  }
}

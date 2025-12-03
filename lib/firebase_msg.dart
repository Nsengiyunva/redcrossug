// ignore_for_file: avoid_print

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseMsg {
  final msgService = FirebaseMessaging.instance;

  initFCM() async {
    await msgService.requestPermission();

    NotificationSettings settings = await msgService.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    print("User Permission: ${settings.authorizationStatus}");

    const AndroidInitializationSettings initSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initSettings =
        InitializationSettings(android: initSettingsAndroid);

    var token = await msgService.getToken();

    print("token 1 $token");

    final FlutterLocalNotificationsPlugin localNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    await localNotificationsPlugin.initialize(initSettings);

    //background
    FirebaseMessaging.onBackgroundMessage(handleNotification);

    //foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      if (notification != null) {
        // print("we are here: ${notification.title}");

        localNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'default_channel',
              'Default',
              importance: Importance.max,
              priority: Priority.high,
            ),
          ),
        );
      }
    });
  }
}

Future<void> handleNotification(RemoteMessage message) async {
  await Firebase.initializeApp();
  // print("Background message: ${message.messageId}");
}

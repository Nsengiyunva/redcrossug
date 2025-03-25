import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> handleBackground(RemoteMessage msg) async {
  print("Title: ${msg.notification?.title}");
  print("Body: ${msg.notification?.body}");
  print("Payload: ${msg.data}");
}

class FirebaseApi {
  final FirebaseMessaging _firebase_messaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await _firebase_messaging.requestPermission();
    final firebaseMessageToken = await _firebase_messaging.getToken();
    print("token $firebaseMessageToken");
    FirebaseMessaging.onBackgroundMessage(handleBackground);
  }
}

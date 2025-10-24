import 'dart:convert';
import 'package:redcross/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class StorageService {
  static const String _key = "user_details";

  static Future<void> saveToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  static Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  static Future<void> saveUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String userJson = jsonEncode(user.toJson());
    await prefs.setString(_key, userJson);
  }

  static Future<User?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString('user');
    return User.fromJson(jsonDecode(userJson!));
  }

  static Future<void> removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }

  static String truncateString(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return '${text.substring(0, maxLength)}...';
    }
  }

  static String formatCurrency(double amount) {
    if (amount > 0) {
      return NumberFormat.currency(locale: 'en_UG', symbol: 'UGX')
          .format(amount);
    }
    return "UGX 0";
  }

  static String displayWhatTime() {
    int hour = DateTime.now().hour;

    if (hour < 12) {
      return "Good Morning";
    } else if (hour < 18) {
      return "Good Afternoon";
    } else {
      return "Good Evening";
    }
  }

  static double getSpacing(int fontSize) {
    return fontSize * 0.02;
  }

  static double getHeight(int height, int fontSize) {
    return height / fontSize;
  }

  // static String formatCurrency(num amount) {
  //   final formatter = NumberFormat('#,##0', 'en_US');
  //   return formatter.format(amount);
  // }
}

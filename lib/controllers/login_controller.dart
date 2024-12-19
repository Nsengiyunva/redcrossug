import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginController {
  TextEditingController telephoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final Future _prefs = SharedPreferences.getInstance();

  Future<void> loginPhoneNumber() async {
    const String url = 'https://urcs-api.taufeeq.dev/api/auth/login';
    
    final Map<String, dynamic> requestBody = {
      "phone_no": "+256775625741",
      "password": "#Satan2023#"
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      print( "response: $response" );

      // if (response.statusCode == 201) {
        // Success
        // final responseData = jsonDecode(response.body);
        // var responseMessage = 'Success: ${responseData['message']}';
        // // print( responseMessage );
        // final SharedPreferences? prefs = await _prefs;
        // await prefs?.setString('token', responseData['token']);
        // // await prefs?.setString('user', user );
        
        // Get.toNamed('/home', arguments: {'phone_number': "+256775625741" });

        // setState(() {
        //   responseMessage = 'Success: ${responseData['id']}';
        // });
      // } else {
        // Error response
        // setState(() {
        //   responseMessage = 'Error: ${response.statusCode}';
        // });
      // }
    } catch (e) {
      print( "Error: $e" );
      // Handle exceptions like network errors
      // setState(() {
      //   responseMessage = 'Exception: $e';
      // });
    }
  }


  Future loginPhoneNumber2() async {
     final url = Uri.parse("https://urcs-api.taufeeq.dev/api/auth/login");

    Map<String, String> requestBody = {
      "phone_no": "+256775625741",
      "password": "#Satan2023#"
    };

    print( 'logging...' );

    // try {
    //   final response = await http.post(
    //     url,
    //     headers: {
    //       "Content-Type": "application/json", 
    //       "X-Requested-With": "XMLHttpRequest"
    //     },
    //     body: jsonEncode(requestBody), // Encoding the body
    //   );
      
    //   print( response.body );
    //   // Check the response status
    //   if (response.statusCode == 200) {
    //     // print("Success: ${response.body}");
    //     final json = jsonDecode(response.body);
    //     var token = json['token'];

    //     final SharedPreferences? prefs = await _prefs;
    //     await prefs?.setString('token', token);
    //     // await prefs?.setString('user', user );
        
    //     Get.toNamed('/home', arguments: {'phone_number': "+256775625741" });
    //   } else {
    //     print("Failed: ${response.statusCode}");
    //   }
    // } catch (e) {
    //   print("Error message: $e");
    // }
  }
}
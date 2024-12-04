import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redcross/scenes/home.dart';
import 'package:redcross/utils/api_endpoints.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginController {
  TextEditingController telephoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final Future _prefs = SharedPreferences.getInstance();

  Future loginPhoneNumber() async {
    // try {
    //   // var url = Uri.parse( ApiEndpoints.baseUrl + ApiEndpoints.authEndpoints.login );
    //   // var headers = { 'X-Requested-With': 'XMLHttpRequest' };
      
    //   // //telephoneController.text.trim() passwordController.text.trim(
    //   // Map body = {
    //   //   "phone_no": "+256775625741",
    //   //   "password": "#Satan2023# "
    //   // };
    //   var url = Uri.parse("https://jsonplaceholder.typicode.com/posts");

    //   http.Response response = await http.post( 
    //     url, 
    //     headers: headers, 
    //     body: jsonEncode( body ) 
    //   );
    //   // print( response.statusCode );
    //    final json = jsonDecode(response.body);
    //    print( body );
    //    print( json["message"] );

    // } catch( e ) {
    //   print( e );
    // }
     final url = Uri.parse("https://urcs-api.taufeeq.dev/api/auth/login");

    Map<String, String> requestBody = {
      "phone_no": "+256775625741",
      "password": "#Satan2023#"
    };

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json", 
          "X-Requested-With": "XMLHttpRequest"
        },
        body: jsonEncode(requestBody), // Encoding the body
      );

      // Check the response status
      if (response.statusCode == 200) {
        // print("Success: ${response.body}");
        final json = jsonDecode(response.body);
        var token = json['token'];
        var user = json['user'];

        final SharedPreferences? prefs = await _prefs;
        await prefs?.setString('token', token);
        await prefs?.setString('user', user );
        Get.offAll(Home());
      } else {
        // print("Failed: ${response.statusCode}");
      }
    } catch (e) {
      // print("Error: $e");
    }
  }
}
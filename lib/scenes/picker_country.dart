import 'package:flutter/material.dart';

class PickerCountry extends StatefulWidget {
  const PickerCountry({super.key});

  @override
  State<PickerCountry> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<PickerCountry> {

  String _selectedCountry = 'US'; // Default country code
  final Map<String, String> countryFlags = {
    'US': '🇺🇸',
    'FR': '🇫🇷',
    'IN': '🇮🇳',
    'JP': '🇯🇵',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16),
          child: Text( "Testing" ),
      ),
    );
  }
}
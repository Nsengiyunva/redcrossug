import 'package:flutter/material.dart';

class PickerCountry extends StatefulWidget {
  const PickerCountry({super.key});

  @override
  State<PickerCountry> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<PickerCountry> {

  final String _selectedCountry = 'US'; // Default country code
  final Map<String, String> countryFlags = {
    'US': '🇺🇸',
    'FR': '🇫🇷',
    'IN': '🇮🇳',
    'JP': '🇯🇵',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          title: const Text(""),
          leading: const BackButton() // Back button added here
        ),
        body:  const SingleChildScrollView(
          child: Text( "Sira" ),
        ) 
      );
  }
}
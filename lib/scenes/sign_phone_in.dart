import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:redcross/scenes/country_picker.dart';
// import 'package:redcross/scenes/picker_country.dart';
// import 'package:redcross/scenes/red_btn.dart';


// class SignPhoneIn extends StatelessWidget {
//   const SignPhoneIn({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Container(
//           margin: const EdgeInsets.symmetric(vertical: 15.0),
//           padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               const Text( "Enter your Number", style: TextStyle( fontSize: 24, color: Colors.black ) ),
//               const SizedBox( height: 15 ),
//               const PickerCountry(),
//               const SizedBox( height: 15 ),
//               RedBtn(label: "Continue", onPressed: () {  
//                 Get.toNamed( "/enter-otp" );
//               },)
//             ],
//          ),
//         )
//       )
//     );
//   }
// }

class SignPhoneIn extends StatefulWidget {
  const SignPhoneIn({super.key});

  @override
  _CustomFlagTextFieldState createState() => _CustomFlagTextFieldState();
}

class _CustomFlagTextFieldState extends State<SignPhoneIn> {
  String _selectedCountry = 'UG'; // Default country code
  final Map<String, String> countryFlags = {
    'UG': '256',
    'FR': '🇫🇷',
    'IN': '🇮🇳',
    'JP': '🇯🇵',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Custom TextField with Flags')),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Enter phone number',
              prefixIcon: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedCountry,
                  icon: const Icon(Icons.arrow_drop_down),
                  items: countryFlags.entries.map((entry) {
                    return DropdownMenuItem<String>(
                      value: entry.key,
                      child: Text('${entry.value}  +${entry.key}'),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCountry = value!;
                    });
                  },
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            keyboardType: TextInputType.phone,
          ),
        ),
      ),
    );
  }
}
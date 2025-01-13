import 'package:flutter/material.dart';
import 'package:redcross/scenes/widgets/flag_code.dart';
// // import 'package:get/get.dart';
// // import 'package:redcross/scenes/country_picker.dart';
// // import 'package:redcross/scenes/picker_country.dart';
// // import 'package:redcross/scenes/red_btn.dart';


// // class SignPhoneIn extends StatelessWidget {
// //   const SignPhoneIn({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: SingleChildScrollView(
// //         child: Container(
// //           margin: const EdgeInsets.symmetric(vertical: 15.0),
// //           padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.center,
// //             children: [
// //               const Text( "Enter your Number", style: TextStyle( fontSize: 24, color: Colors.black ) ),
// //               const SizedBox( height: 15 ),
// //               const PickerCountry(),
// //               const SizedBox( height: 15 ),
// //               RedBtn(label: "Continue", onPressed: () {  
// //                 Get.toNamed( "/enter-otp" );
// //               },)
// //             ],
// //          ),
// //         )
// //       )
// //     );
// //   }
// // }

class SignPhoneIn extends StatefulWidget {
  const SignPhoneIn({super.key});

  @override
  _CustomFlagTextFieldState createState() => _CustomFlagTextFieldState();
}

class _CustomFlagTextFieldState extends State<SignPhoneIn> {
  String _selectedCountry = '256'; 

  final List<Map<String, dynamic>> nations = [
     {
      "country_code": 256,
      "name": "Uganda",
      "code": "UG",
      "emoji": "🇦🇨",
      "unicode": "U+1F1E6 U+1F1E8",
      "image": "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/UG.svg"
    },
    {
      "country_code": 254,
      "name": "Kenya",
      "code": "KE",
      "emoji": "🇮🇩",
      "unicode": "U+1F1EE U+1F1E9",
      "image": "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/KE.svg"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: TextField(
            style: TextStyle( 
                  fontSize: 12, 
                  fontWeight: FontWeight.w600, 
                  fontFamily: "Manrope", 
                  color: Color(0xFF000000)  ),
            decoration: InputDecoration(
              hintText: '',
              hintStyle: TextStyle( 
                  fontSize: 12, 
                  fontWeight: FontWeight.w600, 
                  fontFamily: "Manrope", 
                  color: Color(0xFF929292)  
                ),
              prefixIcon: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedCountry,
                  icon: const Icon(Icons.arrow_drop_down),
                  items: nations.map((entry) {
                    // print( entry["code"] );

                    // return DropdownMenuItem<String>( 
                    //   value: entry.key,
                    //   child: Text('${entry.value}  +${entry.key}'),
                    // );
                    return (
                      DropdownMenuItem<String>( 
                      value: entry["country_code"].toString(),
                      child: FlagCode(
                        flagUrl: entry["image" ], 
                        country_code: entry["country_code"].toString()
                      ),
                    )
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

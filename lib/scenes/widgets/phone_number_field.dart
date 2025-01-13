import 'package:flutter/material.dart';
import 'package:redcross/scenes/widgets/flag_code.dart';

class PhoneNumberField extends StatefulWidget {
  final Function(String) handleTelephoneChange;

  const PhoneNumberField( { super.key, required this.handleTelephoneChange } );

  @override
  _PhoneNumberField createState() => _PhoneNumberField();
}

class _PhoneNumberField extends State<PhoneNumberField> {
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
    return Container(
            padding: EdgeInsets.symmetric( horizontal: 15 ),
            child: TextField(
            style: TextStyle( 
              fontSize: 16, 
              fontWeight: FontWeight.w600, 
              fontFamily: "Manrope", 
              color: Color(0xFF000000)  ),
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular( 10 ),
                borderSide: BorderSide(color: Color(0xFFED1C24), width: 1.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular( 10 ),
                borderSide: BorderSide(color: Color(0xFF545454), width: 1.0),
              ),
              hintText: '',
              hintStyle: const TextStyle( 
                  fontSize: 14, 
                  fontWeight: FontWeight.w600, 
                  fontFamily: "Manrope", 
                  color: Color(0xFF929292)  
                ),
              prefixIcon: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedCountry,
                  icon: Icon(Icons.arrow_drop_down),
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
                    // setState(() {
                    //   _selectedCountry = value!;
                    // });
                    // widget.handleTelephoneChange( value! );
                    print( value );
                  },
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
              keyboardType: TextInputType.phone,
            ),
          );
  }
}
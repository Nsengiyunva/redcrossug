import 'package:flutter/material.dart';
import 'package:redcross/scenes/widgets/flag.dart';
import 'package:redcross/scenes/widgets/flag_code.dart';
import 'package:redcross/utils/colors.dart';

class CountryPicker extends StatefulWidget {
  // final VoidCallback handleTelephoneChange;
   final TextEditingController textEditingController;
   final String question;

  const CountryPicker( { super.key, required this.textEditingController, required this.question } );

  @override
  _PhoneNumberField createState() => _PhoneNumberField();
}

class _PhoneNumberField extends State<CountryPicker> {
  String _selectedCountry = 'Uganda';

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
      // final List<String> _items = ['Apple', 'Banana', 'Cherry', 'Date', 'Grape'];
      // String? _selectedItem;

      return Container(
        padding: const EdgeInsets.symmetric( horizontal: 5 ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric( horizontal: 10 ),
              child: Text( widget.question, style: const TextStyle( 
                fontSize: 12.74, 
                fontFamily: "Inter", 
                fontWeight: FontWeight.w500, 
                color: AppColors.greyColorC 
                )
              ) 
            ),
            TextField(
              controller: widget.textEditingController,
              style: const TextStyle( 
                fontSize: 16, 
                fontWeight: FontWeight.w600, 
                fontFamily: "Manrope", 
                color: Color(0xFF000000)  
              ),
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular( 12 ),
                  borderSide: const BorderSide(color: AppColors.primaryRedColor, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular( 12 ),
                  borderSide: const BorderSide(color: AppColors.greyColorD, width: 1.0),
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
                    value: "Uganda",
                    icon: const Icon(Icons.arrow_drop_down),
                    items: nations.map((entry) {
                      return (
                        DropdownMenuItem<String>( 
                          value: entry["name"].toString(),
                          child: Flag(
                            flagUrl: entry["image" ], 
                            country_code: entry["name"].toString()
                          ),
                        )
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedCountry = value!;
                      } );
                      // widget.handleTelephoneChange( value! );
                      // print( value );
                    },
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
                keyboardType: TextInputType.phone,
              )
          ],
        ),
      );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:redcross/scenes/widgets/flag_code.dart';
import 'package:redcross/utils/colors.dart';

class PhoneNumberField extends StatefulWidget {
  // final VoidCallback handleTelephoneChange;
  final TextEditingController textEditingController;

  const PhoneNumberField({super.key, required this.textEditingController});

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
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/UG.svg"
    },
    {
      "country_code": 254,
      "name": "Kenya",
      "code": "KE",
      "emoji": "🇮🇩",
      "unicode": "U+1F1EE U+1F1E9",
      "image":
          "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/KE.svg"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: TextField(
        controller: widget.textEditingController,
        style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: "Manrope",
            color: AppColors.blackColor),
        // keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:
                const BorderSide(color: AppColors.primaryRedColor, width: 1.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:
                const BorderSide(color: AppColors.greyColorD, width: 1.0),
          ),
          hintText: '',
          hintStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              fontFamily: "Manrope",
              color: Color(0xFF929292)),
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
                return (DropdownMenuItem<String>(
                  value: entry["country_code"].toString(),
                  child: FlagCode(
                      flagUrl: entry["image"],
                      country_code: entry["country_code"].toString()),
                ));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCountry = value!;
                });
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
      ),
    );
  }
}

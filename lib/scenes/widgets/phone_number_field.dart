// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:redcross/scenes/widgets/flag_code.dart';
// import 'package:redcross/utils/colors.dart';

// class PhoneNumberField extends StatefulWidget {
//   // final VoidCallback handleTelephoneChange;
//   final TextEditingController textEditingController;

//   const PhoneNumberField({super.key, required this.textEditingController});
//   @override
//   _PhoneNumberField createState() => _PhoneNumberField();
// }

// class _PhoneNumberField extends State<PhoneNumberField> {
//   String _selectedCountry = '256';

//   final List<Map<String, dynamic>> nations = [
//     {
//       "country_code": 256,
//       "name": "Uganda",
//       "code": "UG",
//       "emoji": "🇺🇬",
//       "unicode": "U+1F1FA U+1F1EC",
//       "image":
//           "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/UG.svg"
//     },
//     {
//       "country_code": 213,
//       "name": "Algeria",
//       "code": "DZ",
//       "emoji": "🇩🇿",
//       "unicode": "U+1F1E9 U+1F1FF",
//       "image":
//           "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/DZ.svg"
//     },
//     {
//       "country_code": 244,
//       "name": "Angola",
//       "code": "AO",
//       "emoji": "🇦🇴",
//       "unicode": "U+1F1E6 U+1F1F4",
//       "image":
//           "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/AO.svg"
//     },
//     {
//       "country_code": 229,
//       "name": "Benin",
//       "code": "BJ",
//       "emoji": "🇧🇯",
//       "unicode": "U+1F1E7 U+1F1EF",
//       "image":
//           "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/BJ.svg"
//     },
//     {
//       "country_code": 267,
//       "name": "Botswana",
//       "code": "BW",
//       "emoji": "🇧🇼",
//       "unicode": "U+1F1E7 U+1F1FC",
//       "image":
//           "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/BW.svg"
//     },
//     {
//       "country_code": 226,
//       "name": "Burkina Faso",
//       "code": "BF",
//       "emoji": "🇧🇫",
//       "unicode": "U+1F1E7 U+1F1EB",
//       "image":
//           "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/BF.svg"
//     },
//     {
//       "country_code": 257,
//       "name": "Burundi",
//       "code": "BI",
//       "emoji": "🇧🇮",
//       "unicode": "U+1F1E7 U+1F1EE",
//       "image":
//           "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/BI.svg"
//     },
//     {
//       "country_code": 237,
//       "name": "Cameroon",
//       "code": "CM",
//       "emoji": "🇨🇲",
//       "unicode": "U+1F1E8 U+1F1F2",
//       "image":
//           "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/CM.svg"
//     },
//     {
//       "country_code": 238,
//       "name": "Cape Verde",
//       "code": "CV",
//       "emoji": "🇨🇻",
//       "unicode": "U+1F1E8 U+1F1FB",
//       "image":
//           "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/CV.svg"
//     },
//     {
//       "country_code": 236,
//       "name": "Central African Republic",
//       "code": "CF",
//       "emoji": "🇨🇫",
//       "unicode": "U+1F1E8 U+1F1EB",
//       "image":
//           "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/CF.svg"
//     },
//     {
//       "country_code": 235,
//       "name": "Chad",
//       "code": "TD",
//       "emoji": "🇹🇩",
//       "unicode": "U+1F1F9 U+1F1E9",
//       "image":
//           "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/TD.svg"
//     },
//     {
//       "country_code": 243,
//       "name": "Democratic Republic of the Congo",
//       "code": "CD",
//       "emoji": "🇨🇩",
//       "unicode": "U+1F1E8 U+1F1E9",
//       "image":
//           "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/CD.svg"
//     },
//     {
//       "country_code": 242,
//       "name": "Republic of the Congo",
//       "code": "CG",
//       "emoji": "🇨🇬",
//       "unicode": "U+1F1E8 U+1F1EC",
//       "image":
//           "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/CG.svg"
//     },
//     {
//       "country_code": 225,
//       "name": "Ivory Coast",
//       "code": "CI",
//       "emoji": "🇨🇮",
//       "unicode": "U+1F1E8 U+1F1EE",
//       "image":
//           "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/CI.svg"
//     },
//     {
//       "country_code": 20,
//       "name": "Egypt",
//       "code": "EG",
//       "emoji": "🇪🇬",
//       "unicode": "U+1F1EA U+1F1EC",
//       "image":
//           "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/EG.svg"
//     },
//     {
//       "country_code": 240,
//       "name": "Equatorial Guinea",
//       "code": "GQ",
//       "emoji": "🇬🇶",
//       "unicode": "U+1F1EC U+1F1F6",
//       "image":
//           "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/GQ.svg"
//     },
//     {
//       "country_code": 291,
//       "name": "Eritrea",
//       "code": "ER",
//       "emoji": "🇪🇷",
//       "unicode": "U+1F1EA U+1F1F7",
//       "image":
//           "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/ER.svg"
//     },
//     {
//       "country_code": 268,
//       "name": "Eswatini",
//       "code": "SZ",
//       "emoji": "🇸🇿",
//       "unicode": "U+1F1F8 U+1F1FF",
//       "image":
//           "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/SZ.svg"
//     },
//     {
//       "country_code": 251,
//       "name": "Ethiopia",
//       "code": "ET",
//       "emoji": "🇪🇹",
//       "unicode": "U+1F1EA U+1F1F9",
//       "image":
//           "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/ET.svg"
//     },
//     {
//       "country_code": 241,
//       "name": "Gabon",
//       "code": "GA",
//       "emoji": "🇬🇦",
//       "unicode": "U+1F1EC U+1F1E6",
//       "image":
//           "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/GA.svg"
//     },
//     {
//       "country_code": 220,
//       "name": "Gambia",
//       "code": "GM",
//       "emoji": "🇬🇲",
//       "unicode": "U+1F1EC U+1F1F2",
//       "image":
//           "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/GM.svg"
//     },
//     {
//       "country_code": 233,
//       "name": "Ghana",
//       "code": "GH",
//       "emoji": "🇬🇭",
//       "unicode": "U+1F1EC U+1F1ED",
//       "image":
//           "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/GH.svg"
//     },
//     {
//       "country_code": 224,
//       "name": "Guinea",
//       "code": "GN",
//       "emoji": "🇬🇳",
//       "unicode": "U+1F1EC U+1F1F3",
//       "image":
//           "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/GN.svg"
//     },
//     {
//       "country_code": 245,
//       "name": "Guinea-Bissau",
//       "code": "GW",
//       "emoji": "🇬🇼",
//       "unicode": "U+1F1EC U+1F1FC",
//       "image":
//           "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/GW.svg"
//     },
//     {
//       "country_code": 264,
//       "name": "Namibia",
//       "code": "NA",
//       "emoji": "🇳🇦",
//       "unicode": "U+1F1F3 U+1F1E6",
//       "image":
//           "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/NA.svg"
//     },
//     {
//       "country_code": 234,
//       "name": "Nigeria",
//       "code": "NG",
//       "emoji": "🇳🇬",
//       "unicode": "U+1F1F3 U+1F1EC",
//       "image":
//           "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/NG.svg"
//     },
//     {
//       "country_code": 221,
//       "name": "Senegal",
//       "code": "SN",
//       "emoji": "🇸🇳",
//       "unicode": "U+1F1F8 U+1F1F3",
//       "image":
//           "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/SN.svg"
//     },
//     {
//       "country_code": 27,
//       "name": "South Africa",
//       "code": "ZA",
//       "emoji": "🇿🇦",
//       "unicode": "U+1F1FF U+1F1E6",
//       "image":
//           "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/ZA.svg"
//     },
//     {
//       "country_code": 249,
//       "name": "Sudan",
//       "code": "SD",
//       "emoji": "🇸🇩",
//       "unicode": "U+1F1F8 U+1F1E9",
//       "image":
//           "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/SD.svg"
//     },
//     {
//       "country_code": 211,
//       "name": "South Sudan",
//       "code": "SS",
//       "emoji": "🇸🇸",
//       "unicode": "U+1F1F8 U+1F1F8",
//       "image":
//           "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/SS.svg"
//     },
//     {
//       "country_code": 255,
//       "name": "Tanzania",
//       "code": "TZ",
//       "emoji": "🇹🇿",
//       "unicode": "U+1F1F9 U+1F1FF",
//       "image":
//           "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/TZ.svg"
//     },
//     {
//       "country_code": 216,
//       "name": "Tunisia",
//       "code": "TN",
//       "emoji": "🇹🇳",
//       "unicode": "U+1F1F9 U+1F1F3",
//       "image":
//           "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/TN.svg"
//     },
//     {
//       "country_code": 260,
//       "name": "Zambia",
//       "code": "ZM",
//       "emoji": "🇿🇲",
//       "unicode": "U+1F1FF U+1F1F2",
//       "image":
//           "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/ZM.svg"
//     },
//     {
//       "country_code": 263,
//       "name": "Zimbabwe",
//       "code": "ZW",
//       "emoji": "🇿🇼",
//       "unicode": "U+1F1FF U+1F1FC",
//       "image":
//           "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/ZW.svg"
//     }
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 5),
//       child: TextField(
//         controller: widget.textEditingController,
//         style: const TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.w600,
//             fontFamily: "Manrope",
//             color: AppColors.blackColor),
//         // keyboardType: TextInputType.number,
//         inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//         decoration: InputDecoration(
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//             borderSide:
//                 const BorderSide(color: AppColors.primaryRedColor, width: 1.0),
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//             borderSide:
//                 const BorderSide(color: AppColors.greyColorD, width: 1.0),
//           ),
//           hintText: '',
//           hintStyle: const TextStyle(
//               fontSize: 14,
//               fontWeight: FontWeight.w600,
//               fontFamily: "Manrope",
//               color: Color(0xFF929292)),
//           prefixIcon: DropdownButtonHideUnderline(
//             child: DropdownButton<String>(
//               value: _selectedCountry,
//               icon: const Icon(Icons.arrow_drop_down),
//               items: nations.map((entry) {
//                 // print( entry["code"] );
//                 // return DropdownMenuItem<String>(
//                 //   value: entry.key,
//                 //   child: Text('${entry.value}  +${entry.key}'),
//                 // );
//                 return (DropdownMenuItem<String>(
//                   value: entry["country_code"].toString(),
//                   child: FlagCode(
//                       flagUrl: entry["image"],
//                       country_code: entry["country_code"].toString()),
//                 ));
//               }).toList(),
//               onChanged: (value) {
//                 setState(() {
//                   _selectedCountry = value!;
//                 });
//                 // widget.handleTelephoneChange( value! );
//                 // print( value );
//               },
//             ),
//           ),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//         ),
//         keyboardType: TextInputType.phone,
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhoneFormField extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) onCountryChanged;
  final String? Function(String?)? validator;

  const PhoneFormField({
    super.key,
    required this.controller,
    required this.onCountryChanged,
    this.validator,
  });

  @override
  State<PhoneFormField> createState() => _PhoneFormFieldState();
}

class _PhoneFormFieldState extends State<PhoneFormField> {
  String _selectedCode = "256";

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Country Code Dropdown
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedCode,
              items: const [
                DropdownMenuItem(value: "256", child: Text("+256")),
                DropdownMenuItem(value: "254", child: Text("+254")),
                DropdownMenuItem(value: "255", child: Text("+255")),
                DropdownMenuItem(value: "250", child: Text("+250")),
              ],
              onChanged: (value) {
                if (value == null) return;
                setState(() => _selectedCode = value);
                widget.onCountryChanged(value);
              },
            ),
          ),
        ),
        const SizedBox(width: 8),

        // Phone Number Input
        Expanded(
          child: TextFormField(
            controller: widget.controller,
            keyboardType: TextInputType.phone,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            ],
            validator: widget.validator,
            decoration: InputDecoration(
              hintText: "701234567",
              filled: true,
              fillColor: Colors.grey[50],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide(color: Colors.red, width: 2),
              ),
              errorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide(color: Colors.red),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class FormTextfield extends StatelessWidget {
  final String question;
  final TextEditingController textEditingController;

  const FormTextfield({ 
    super.key, 
    required this.question, 
    required this.textEditingController
  } );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(question, style: const TextStyle( fontSize: 12.74, fontFamily: "Inter", fontWeight: FontWeight.w500, color: Color(0xFF000000) )),
              const SizedBox( height: 2 ),
              TextField(
                controller: textEditingController,
                style: const TextStyle( fontFamily: "Inter", fontSize: 14, color: Color(0xFF293041) ),
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),

                  enabledBorder: OutlineInputBorder(  // Border when not focused
                    borderRadius: BorderRadius.circular(18),
                    borderSide: const BorderSide(color: Color(0xFF545454), width: 1 ),
                  ),
                  focusedBorder: OutlineInputBorder(  // Border when focused
                    borderRadius: BorderRadius.circular(18),
                    borderSide: const BorderSide(color: Color(0xFFED1C24), width:  1 ),
                  ),
                  errorBorder: OutlineInputBorder(   // Border when error occurs
                    borderRadius: BorderRadius.circular(18),
                    borderSide: const BorderSide(color: Color(0xFFED1C24), width:  1 ),
                  )
                ),
              ),
            ],
          ),
        ),
        );
      }
}


// TextField(
//             controller: textEditingController,
//             style: TextStyle( fontFamily: "Inter", fontSize: 14, color: Color(0xFF293041) ),
//             decoration: InputDecoration(
//               alignLabelWithHint: true,
//               fillColor: Colors.white54,
//               labelText: question,
//               labelStyle: TextStyle(color: Colors.black),
//               border: OutlineInputBorder(),
//               contentPadding: EdgeInsets.symmetric( vertical: 5, horizontal: 10 ),

//               enabledBorder: OutlineInputBorder(  // Border when not focused
//                 borderRadius: BorderRadius.circular(18),
//                 borderSide: const BorderSide(color: Color(0xFFD2D9DE), width: 2),
//               ),
//               focusedBorder: OutlineInputBorder(  // Border when focused
//                 borderRadius: BorderRadius.circular(18),
//                 borderSide: const BorderSide(color: Color(0xFFED1C24), width: 2),
//               ),
//               errorBorder: OutlineInputBorder(   // Border when error occurs
//                 borderRadius: BorderRadius.circular(18),
//                 borderSide: const BorderSide(color: Color(0xFFED1C24), width: 2),
//               ),
//             )
//            )
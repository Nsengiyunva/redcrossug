import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FlagCode extends StatelessWidget {
  final String flagUrl;
  final String country_code;

  const FlagCode({super.key, required this.flagUrl, required this.country_code });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric( horizontal: 10 ),
      child: Row(
        children: [
         Center(
          child: SvgPicture.network(
            flagUrl,
            placeholderBuilder: (context) =>
                CircularProgressIndicator(), // Loading indicator
            width: 25,
            height: 30,
          ),
        ),
            Padding(
              padding: EdgeInsets.symmetric( horizontal: 5 ),
              child: Text( 
                "+$country_code", 
                style: TextStyle( 
                  fontSize: 12, 
                  fontWeight: FontWeight.w600, 
                  fontFamily: "Manrope", 
                  color: Color(0xFF929292) 
                ), ),
            )
          ],
        )
    );
  }
}
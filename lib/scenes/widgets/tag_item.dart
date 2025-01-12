import 'package:flutter/material.dart';

class TagItem extends StatelessWidget {
  final String label;

  const TagItem({super.key, required this.label });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric( horizontal: 10 ),
      padding: EdgeInsets.symmetric( horizontal: 5 ),
      height: 23.35,
      width: 132,
      decoration: BoxDecoration(
        color: Color(0xFFFFDBDB),
        borderRadius: BorderRadius.circular( 5 )
      ),
      child: Center(
        child: Text( "$label", style: TextStyle( fontSize: 11.54, fontFamily: "Inter", fontWeight: FontWeight.w600, color: Color(0xFFE30000) ) ),
      )
    );
  }
}
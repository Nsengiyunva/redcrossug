import 'package:flutter/material.dart';

class TagItem extends StatelessWidget {
  final String label;
  final double height;
  final double width;

  const TagItem({super.key, required this.label, required this.height, required this.width });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric( horizontal: 10 ),
      padding: const EdgeInsets.symmetric( horizontal: 5 ),
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: const Color(0xFFFFDBDB),
        borderRadius: BorderRadius.circular( 5 )
      ),
      child: Center(
        child: Text( label, style: const TextStyle( fontSize: 11.54, fontFamily: "Inter", fontWeight: FontWeight.w600, color: Color(0xFFE30000) ) ),
      )
    );
  }
}
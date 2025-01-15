import 'package:flutter/material.dart';

class TextBoxArea extends StatefulWidget {
  const TextBoxArea({super.key});

  @override
  State<TextBoxArea> createState() => _TextBoxAreaState();
}

class _TextBoxAreaState extends State<TextBoxArea> {
  @override
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: TextField(
          style: const TextStyle(fontSize: 12, color: Colors.black, fontFamily: "Inter" ),
          // cursorColor: Colors.orange,  // Change cursor color
          cursorWidth: 3, 
          controller: _controller,
          maxLines: 3, // Allows up to 5 lines
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Write your message...',
            hintText: 'Type something...',
            labelStyle: TextStyle(color: Color(0xFF969492) ),
          ),
        ),
      ),
    );
  }
}
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
        // padding: const EdgeInsets.all( 5.0),
        child: TextField(
          controller: _controller,
          maxLines: 3, // Allows up to 5 lines
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Write your messages...',
            hintText: 'Type something...',
          ),
        ),
      ),
    );
  }
}
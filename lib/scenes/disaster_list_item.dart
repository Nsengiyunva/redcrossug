import 'package:flutter/material.dart';
import 'package:redcross/scenes/red_btn.dart';
import 'package:redcross/scenes/text_field.dart';

class DisasterListItem extends StatelessWidget {
  const DisasterListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text( 'Test 1' )
          ],
        )
        )
    );
  }
}
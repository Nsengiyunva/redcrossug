import 'package:flutter/material.dart';
import 'package:redcross/scenes/disaster_list_item.dart';
import 'package:redcross/scenes/list_tabs_container.dart';
import 'package:redcross/scenes/menu_list_items.dart';

class DisasterList extends StatelessWidget {
  const DisasterList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 30.0),
        padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 25.0),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text( 'Disasters', style: TextStyle( fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold ), ),
            MenuListItems()
          ],
        ),
    ),
    ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redcross/scenes/card_board.dart';
import 'package:redcross/scenes/home_badge.dart';
import 'package:redcross/scenes/screen_four.dart';

import 'package:redcross/scenes/default_home.dart';
import 'package:redcross/scenes/screen_three.dart';
import 'package:redcross/scenes/screen_two.dart';


class Home extends StatefulWidget {
  @override
  _BottomNavigationBarExampleState createState() => _BottomNavigationBarExampleState();
}

class _BottomNavigationBarExampleState extends State<Home> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    DefaultHome(),
    ScreenTwo(),
    ScreenThree(),
    ScreenFour()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('Bottom Navigation Bar')),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bloodtype_outlined),
            label: 'B.Donation',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_hospital_outlined),
            label: 'First Aid',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
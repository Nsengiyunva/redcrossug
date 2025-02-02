import 'package:flutter/material.dart';
import 'package:redcross/scenes/auth/profile.dart';
import 'package:redcross/scenes/first_aid/first_aid_home.dart';
import 'package:redcross/scenes/screen_four.dart';

import 'package:redcross/scenes/default_home.dart';
import 'package:redcross/scenes/screen_three.dart';
import 'package:redcross/scenes/screen_two.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _BottomNavigationBarExampleState createState() =>
      _BottomNavigationBarExampleState();
}

class _BottomNavigationBarExampleState extends State<Home> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    DefaultHome(),
    const ScreenTwo(),
    const FirstAidHome(),
    const Profile()
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
        items: const [
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

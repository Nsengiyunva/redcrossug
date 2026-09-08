// ignore_for_file: deprecated_member_use, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:redcross/scenes/auth/profile.dart';
import 'package:redcross/scenes/blood_donations/blood_donations_home.dart';
import 'package:redcross/scenes/first_aid/first_aid_home.dart';
import 'package:redcross/scenes/default_home.dart';
import 'package:redcross/utils/colors.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _BottomNavigationBarExampleState createState() =>
      _BottomNavigationBarExampleState();
}

class _BottomNavigationBarExampleState extends State<Home> {
  int _currentIndex = 0;

  final _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  void _onTap(int index) {
    if (_currentIndex == index) {
      _navigatorKeys[index].currentState?.popUntil((r) => r.isFirst);
    } else {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  Widget _buildOffStageNavigator(int index, Widget child) {
    return Offstage(
      offstage: _currentIndex != index,
      child: Navigator(
        key: _navigatorKeys[index],
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
            builder: (context) => child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;
        final NavigatorState currentTabNav =
            _navigatorKeys[_currentIndex].currentState!;
        if (currentTabNav.canPop()) {
          currentTabNav.pop();
        } else {
          // Close app if at root
          Navigator.of(context).maybePop();
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            _buildOffStageNavigator(0, const DefaultHome()),
            _buildOffStageNavigator(1, const BloodDonationsHome()),
            _buildOffStageNavigator(2, const FirstAidHome()),
            _buildOffStageNavigator(3, const Profile()),
          ],
        ),
        bottomNavigationBar: Container(
            decoration: const BoxDecoration(boxShadow: [
              BoxShadow(
                color: AppColors.greyColorN,
                blurRadius: 0.025, // soften the shadow
                spreadRadius: 0, // extend the shadow
                offset: Offset(0, -1), // move upward
              )
            ]),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed, // needed for 4+ items
              currentIndex: _currentIndex,
              onTap: _onTap,
              selectedItemColor: AppColors.primaryRedColor, // active tab color
              unselectedItemColor: AppColors.greyColorN, // inactive tabs
              selectedLabelStyle: const TextStyle(
                  fontFamily: "Inter", fontWeight: FontWeight.w400),
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.bloodtype), label: "Blood"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.medical_services), label: "First Aid"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: "Profile"),
              ],
            )),
      ),
    );
  }
}

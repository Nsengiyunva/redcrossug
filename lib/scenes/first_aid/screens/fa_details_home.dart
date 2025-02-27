import 'package:flutter/material.dart';
import 'package:redcross/scenes/first_aid/screens/bleeding_cut.dart';
import 'package:redcross/scenes/first_aid/screens/bleeding_cut_page2.dart';
import 'package:redcross/scenes/first_aid/screens/bleeding_cut_page3.dart';
import 'package:redcross/utils/colors.dart';

class FaDetailsHome extends StatefulWidget {
  const FaDetailsHome({super.key});

  @override
  _SliderWithDotsState createState() => _SliderWithDotsState();
}

class _SliderWithDotsState extends State<FaDetailsHome> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Widget> _pages = [
    const BleedingCut(),
    const BleedingCutPage2(),
    const BleedingCutPage3()
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(""),
          leading: const BackButton() // Back button added here
          ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (int index) {
                setState(() {
                  _currentPage = index;
                });
              },
              children: _pages,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _pages.length,
              (index) => Container(
                margin: const EdgeInsets.all(4.0),
                width: _currentPage == index ? 12.0 : 8.0,
                height: _currentPage == index ? 12.0 : 8.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      _currentPage == index ? AppColors.redColorA : Colors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

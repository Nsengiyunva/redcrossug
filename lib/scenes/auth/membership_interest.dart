import 'package:flutter/material.dart';

class MembershipInterest extends StatefulWidget {
  const MembershipInterest({Key? key}) : super(key: key);

  @override
  State<MembershipInterest> createState() => _UpdateMembershipScreenState();
}

class _UpdateMembershipScreenState extends State<MembershipInterest> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<BenefitItem> _benefits = [
    BenefitItem(
      title: 'Ambulance Assitance\ninCase of Accident /\nEmergency',
      imagePath: 'assets/ambulance.png',
    ),
    BenefitItem(
      title: 'Family First Aid Training\nand First Aid in Emergency\nCases',
      imagePath: 'assets/first_aid_kit.png',
    ),
    BenefitItem(
      title: 'Burial Assistance in\ncase of Accident',
      imagePath: 'assets/medical_box.png',
    ),
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
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {},
        ),
        title: const Text(
          'URCS Membership',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemCount: _benefits.length,
              itemBuilder: (context, index) {
                return BenefitPage(benefit: _benefits[index]);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 40.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _benefits.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _currentPage == index ? 8 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPage == index
                        ? const Color(0xFFE53935)
                        : const Color(0xFFE0E0E0),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BenefitPage extends StatelessWidget {
  final BenefitItem benefit;

  const BenefitPage({Key? key, required this.benefit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Membership',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Color(0xFFE53935),
              height: 1.2,
            ),
          ),
          const Text(
            'Benefits',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Color(0xFFE53935),
              height: 1.2,
            ),
          ),
          const SizedBox(height: 60),
          // Placeholder for images - replace with actual images or use icons
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: Icon(
                Icons.image,
                size: 80,
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(height: 40),
          Text(
            benefit.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black87,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class BenefitItem {
  final String title;
  final String imagePath;

  BenefitItem({
    required this.title,
    required this.imagePath,
  });
}

import 'package:flutter/material.dart';
import 'package:redcross/scenes/auth/account_success.dart';
import 'package:redcross/scenes/blood_donations/blood_donation_success.dart';
import 'package:redcross/scenes/widgets/red_btn.dart';
import 'package:redcross/utils/colors.dart';
import 'package:redcross/utils/storage_service.dart';

class BloodEligibility extends StatefulWidget {
  const BloodEligibility({super.key});

  @override
  State<BloodEligibility> createState() => _BloodEligibilityState();
}

class _BloodEligibilityState extends State<BloodEligibility> {
  final List<Item> _items = <Item>[
    Item(header: 'Platelet Donation', body: [
      'Donation frequency: Every 56 days, up to 6 times a year',
      'You must be in good health and feeling well',
      'You must be at least 16 years old in most states',
      'You must weigh at least 50 kgs',
      'You must be HIV/AIDS negative'
    ]),
    Item(header: 'Whole Blood Donation', body: [
      'Donation frequency: Every 56 days, up to 6 times a year',
      'You must be in good health and feeling well',
      'You must be at least 16 years old in most states',
      'You must weigh at least 50 kgs',
      'You must be HIV/AIDS negative'
    ]),
    Item(header: 'Plasma Donation', body: [
      'Donation frequency: Every 56 days, up to 6 times a year',
      'You must be in good health and feeling well',
      'You must be at least 16 years old in most states',
      'You must weigh at least 50 kgs',
      'You must be HIV/AIDS negative'
    ]),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Back'),
        leading: const BackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: ListView(
          children: [
            Text(
              "Blood",
              style: TextStyle(
                  fontSize: 26.33,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryRedColor,
                  height: StorageService.getHeight(28, 26),
                  letterSpacing: StorageService.getSpacing(26)),
            ),
            const SizedBox(height: 4),
            Text(
              "Donation Eligibility",
              style: TextStyle(
                  fontSize: 26.33,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Inter",
                  color: AppColors.blackColor,
                  height: StorageService.getHeight(28, 26),
                  letterSpacing: StorageService.getSpacing(26)),
            ),
            const SizedBox(height: 16),

            // 🔹 Sub heading
            Text(
              "Next Eligible donation date:",
              style: TextStyle(
                fontSize: 14.4,
                fontFamily: "Inter",
                fontWeight: FontWeight.w700,
                color: AppColors.blackColorZ,
                height: StorageService.getHeight(24, 14),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              "Saturday, July 10th, 2025",
              style: TextStyle(
                  fontSize: 14.4,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w700,
                  color: AppColors.blackColorZ,
                  height: StorageService.getHeight(24, 14)),
            ),
            const SizedBox(height: 15),

            ..._items.map((item) {
              return CustomExpandableTile(item: item);
            }).toList(),

            const SizedBox(height: 25),
            RedBtn(
              label: 'Continue',
              onPressed: () {
                // Get.toNamed("/blood-donation-eligibility");
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => BloodDonationSuccess()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CustomExpandableTile extends StatefulWidget {
  final Item item;
  const CustomExpandableTile({super.key, required this.item});

  @override
  State<CustomExpandableTile> createState() => _CustomExpandableTileState();
}

class _CustomExpandableTileState extends State<CustomExpandableTile>
    with SingleTickerProviderStateMixin {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _expanded = !_expanded;
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.red, width: 1.5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.water_drop_outlined, color: Colors.red),
                    const SizedBox(width: 10),
                    Text(
                      widget.item.header,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
                AnimatedRotation(
                  turns: _expanded ? 0.5 : 0, // 180° when expanded
                  duration: const Duration(milliseconds: 200),
                  child: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 28,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ),
        AnimatedCrossFade(
          firstChild: const SizedBox.shrink(),
          secondChild: Column(
            children: widget.item.body
                .map(
                  (text) => ListTile(
                    contentPadding: const EdgeInsets.only(left: 40, right: 10),
                    title: Text(
                      text,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                )
                .toList(),
          ),
          crossFadeState:
              _expanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 200),
        ),
      ],
    );
  }
}

class Item {
  final String header;
  final List<String> body;
  Item({required this.header, required this.body});
}

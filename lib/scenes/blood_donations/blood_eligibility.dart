import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redcross/utils/colors.dart';
import 'package:redcross/utils/storage_service.dart';

class BloodEligibility extends StatefulWidget {
  const BloodEligibility({super.key});

  @override
  _BloodEligibilityState createState() => _BloodEligibilityState();
}

class _BloodEligibilityState extends State<BloodEligibility> {
  final List<Item> _items = <Item>[
    Item(header: 'Platelet Donation', body: ['Apple', 'Banana', 'Orange']),
    Item(header: 'Whole Blood Donation', body: ['Carrot', 'Broccoli']),
    Item(header: 'Plasma Donation', body: ['Mango', 'Papaya']),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(''), leading: const BackButton()),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Blood",
                style: TextStyle(
                  fontFamily: "Inter",
                  fontSize: 26.33,
                  color: AppColors.primaryRedColor,
                  fontWeight: FontWeight.w700,
                  height: StorageService.getHeight(28, 26),
                  letterSpacing: StorageService.getSpacing(26),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                "Donation Eligibility",
                style: TextStyle(
                  fontFamily: "Inter",
                  fontSize: 26.33,
                  color: AppColors.blackColor,
                  fontWeight: FontWeight.w700,
                  height: StorageService.getHeight(28, 26),
                  letterSpacing: StorageService.getSpacing(26),
                ),
              ),
              const SizedBox(height: 15),
              Text(
                "Next Eligible donation date:",
                style: TextStyle(
                  fontFamily: "Inter",
                  fontSize: 14.4,
                  color: AppColors.blackColorZ,
                  fontWeight: FontWeight.w700,
                  height: StorageService.getHeight(24, 14),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                "Saturday, July 10th, 2025",
                style: TextStyle(
                  fontFamily: "Inter",
                  fontSize: 14.4,
                  color: AppColors.blackColorZ,
                  fontWeight: FontWeight.w700,
                  height: StorageService.getHeight(24, 14),
                ),
              ),
              const SizedBox(height: 15),

              // ✅ Custom expandable widgets instead of ExpansionPanelList
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  final item = _items[index];
                  return CustomExpandableTile(
                    title: item.header,
                    children: item.body,
                  );
                },
              ),

              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  // Get.toNamed("/blood-donation-history");
                },
                child: const Text('See'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Custom Expandable Tile
class CustomExpandableTile extends StatefulWidget {
  final String title;
  final List<String> children;

  const CustomExpandableTile({
    super.key,
    required this.title,
    required this.children,
  });

  @override
  _CustomExpandableTileState createState() => _CustomExpandableTileState();
}

class _CustomExpandableTileState extends State<CustomExpandableTile>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _isExpanded ? AppColors.primaryRedColor : Colors.grey.shade300,
          width: 2,
        ),
      ),
      child: Column(
        children: [
          // Header
          ListTile(
            title: Text(
              widget.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: _isExpanded ? AppColors.primaryRedColor : Colors.black,
              ),
            ),
            trailing: AnimatedRotation(
              turns: _isExpanded ? 0.5 : 0, // rotates 180° when expanded
              duration: const Duration(milliseconds: 200),
              child: Icon(
                Icons.keyboard_arrow_right, // 👈 your custom arrow
                size: 28,
                color: _isExpanded ? AppColors.primaryRedColor : Colors.black,
              ),
            ),
            onTap: () {
              setState(() => _isExpanded = !_isExpanded);
            },
          ),

          // Body
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: Column(
              children: widget.children
                  .map((text) => ListTile(
                        contentPadding:
                            const EdgeInsets.only(left: 40, right: 16),
                        title: Text(text),
                      ))
                  .toList(),
            ),
            crossFadeState: _isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 300),
          ),
        ],
      ),
    );
  }
}

class Item {
  String header;
  List<String> body;
  Item({required this.header, required this.body});
}

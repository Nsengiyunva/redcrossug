import 'package:flutter/material.dart';

class BloodEligibility extends StatefulWidget {
  const BloodEligibility({super.key});

  @override
  State<BloodEligibility> createState() => _BloodEligibilityState();
}

class _BloodEligibilityState extends State<BloodEligibility> {
  final List<Item> _items = <Item>[
    Item(header: 'Platelet Donation', body: ['Apple', 'Banana', 'Orange']),
    Item(header: 'Whole Blood Donation', body: ['Carrot', 'Broccoli']),
    Item(header: 'Plasma Donation', body: ['Potato', 'Tomato']),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Donation Eligibility'),
        leading: const BackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: _items.map((item) {
            return CustomExpandableTile(item: item);
          }).toList(),
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
                    const Icon(Icons.favorite, color: Colors.red),
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

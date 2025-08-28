import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BloodEligibility extends StatefulWidget {
  @override
  _BloodEligibilityState createState() => _BloodEligibilityState();
}

class _BloodEligibilityState extends State<BloodEligibility> {
  List<Item> _items = <Item>[
    Item(header: 'Platelet Donation', body: ['Apple', 'Banana', 'Orange']),
    Item(header: 'Whole Blood Donation', body: ['Carrot', 'Broccoli']),
    Item(header: 'Plasma Donation', body: ['Carrot', 'Broccoli']),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Blood Eligibility')),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ExpansionPanelList.radio(
              animationDuration: Duration(milliseconds: 300),
              children: _items
                  .map((item) => ExpansionPanelRadio(
                        value: item.header,
                        headerBuilder: (context, isExpanded) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                              color: isExpanded
                                  ? Colors.red.shade100
                                  : Colors.grey.shade200, // header background
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  isExpanded
                                      ? Icons.arrow_drop_down
                                      : Icons.arrow_right,
                                  color: Colors.red,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  item.header,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        body: Column(
                          children: item.body
                              .map((text) => ListTile(
                                    title: Text(text),
                                    contentPadding: EdgeInsets.only(left: 40),
                                  ))
                              .toList(),
                        ),
                      ))
                  .toList(),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.toNamed("/blood-donation-history");
            },
            child: Text('See'),
          )
        ],
      )),
    );
  }
}

class Item {
  String header;
  List<String> body;
  bool isExpanded;
  Item({required this.header, required this.body, this.isExpanded = false});
}

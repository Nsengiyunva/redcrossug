import 'package:flutter/material.dart';

class CollapsibleItem extends StatefulWidget {
  @override
  _CollapsibleItemState createState() => _CollapsibleItemState();
}

class _CollapsibleItemState extends State<CollapsibleItem> {
  List<Item> _items = <Item>[
    Item(header: 'Fruits', body: ['Apple', 'Banana', 'Orange']),
    Item(header: 'Vegetables', body: ['Carrot', 'Broccoli']),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height,
        ),
        child: ExpansionPanelList(
          animationDuration: Duration(milliseconds: 300),
          expansionCallback: (int index, bool isExpanded) {
            setState(() {
              _items[index].isExpanded = !isExpanded;
            });
          },
          children: _items.map<ExpansionPanel>((Item item) {
            return ExpansionPanel(
              headerBuilder: (context, isExpanded) {
                return ListTile(
                  title: Text(item.header),
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
              isExpanded: item.isExpanded,
            );
          }).toList(),
        ),
      ),
    );
  }
}

class Item {
  String header;
  List<String> body;
  bool isExpanded;
  Item({required this.header, required this.body, this.isExpanded = false});
}

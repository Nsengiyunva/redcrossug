import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:redcross/controllers/disasters_list_controller.dart';
import 'package:redcross/scenes/widgets/disaster_list_item.dart';
import 'package:redcross/scenes/widgets/menu_list_items.dart';
import 'package:redcross/utils/colors.dart';

class Item {
  final String name;
  final double price;
  final String description;

  Item({required this.name, required this.price, required this.description});
}

class DisasterList extends StatelessWidget {
  DisasterList({super.key});

  final DisastersListController disasterController =
      Get.put(DisastersListController());

  String truncateString(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return '${text.substring(0, maxLength)}...';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: AppBar(
            title: const Text(""),
            leading: const BackButton() // Back button added here
            ),
        body: Obx(() {
          if (disasterController.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (disasterController.disasters.isEmpty) {
            return const Center(
                child: Center(child: Text('No Disasters were found.')));
          }

          return Container(
            padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      'Disasters',
                      style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 26.33,
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.w700),
                    )),
                const SizedBox(height: 10),
                const MenuListItems(
                  first_title: "Active Disasters",
                  second_title: "",
                ),
                const SizedBox(height: 10),
                Expanded(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: ListView.builder(
                          itemCount: disasterController.disasters.length,
                          itemBuilder: (context, index) {
                            var item = disasterController.disasters[index];
                            return DisasterListItem(
                              id: item['id'] ?? '',
                              title: truncateString(
                                  item['name'] ?? 'Unnamed Disaster', 20),
                              subtitle: truncateString(
                                  item['summary'] ?? 'No summary available',
                                  80),
                              date: item['reported_date'] ?? 'Unknown date',
                              location: item['districts'] ?? 'Unknown location',
                              photo: item['banner_photo'] ??
                                  '', // or a default placeholder image
                            );
                            //disasters/wWflu35PtDeJeu8k7Nx5fHKXenorY0gIwtOWk6mY.jpg
                          },
                        )))
              ],
            ),
          );
        }));
  }
}

class CustomListItem extends StatelessWidget {
  final Item item;

  const CustomListItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      elevation: 4,
      child: ListTile(
        leading: const Icon(Icons.shopping_cart, color: Colors.green),
        title: Text(item.name,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(
            'Price: \$${item.price.toStringAsFixed(2)}\n${item.description}'),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Selected: ${item.name}')),
          );
        },
      ),
    );
  }
}

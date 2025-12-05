// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import 'package:redcross/controllers/disasters_list_controller.dart';
// import 'package:redcross/models/item.dart';
// import 'package:redcross/scenes/incidents/incident_list.dart';
// import 'package:redcross/scenes/widgets/disaster_list_item.dart';
// import 'package:redcross/scenes/widgets/menu_list_items.dart';
// import 'package:redcross/utils/colors.dart';

// class DisasterList extends StatelessWidget {
//   DisasterList({super.key});

//   final DisastersListController disasterController =
//       Get.put(DisastersListController());

//   String truncateString(String text, int maxLength) {
//     if (text.length <= maxLength) {
//       return text;
//     } else {
//       return '${text.substring(0, maxLength)}...';
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: AppColors.bgColor,
//         appBar: AppBar(
//             title: const Text(""),
//             leading: const BackButton() // Back button added here
//             ),
//         body: Obx(() {
//           if (disasterController.isLoading.value) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }

//           if (disasterController.disasters.isEmpty) {
//             return const Center(
//                 child: Center(child: Text('No Disasters were found.')));
//           }

//           return Container(
//             padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(children: [
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 15),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         const Text(
//                           'Disasters',
//                           style: TextStyle(
//                             fontFamily: "Inter",
//                             fontSize: 26.33,
//                             color: AppColors.blackColor,
//                             fontWeight: FontWeight.w700,
//                           ),
//                         ),

//                         // Right-side button
//                         ElevatedButton(
//                           onPressed: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => const IncidentList(),
//                               ),
//                             );
//                           },
//                           style: ElevatedButton.styleFrom(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 20, vertical: 12),
//                           ),
//                           child: const Text("View Incidents"),
//                         ),
//                       ],
//                     ),
//                   )
//                 ]),
//                 const SizedBox(height: 10),
//                 const MenuListItems(
//                   first_title: "Active Disasters",
//                   second_title: "",
//                 ),
//                 const SizedBox(height: 10),
//                 Expanded(
//                     child: Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 10),
//                         child: ListView.builder(
//                           itemCount: disasterController.disasters.length,
//                           itemBuilder: (context, index) {
//                             var item = disasterController.disasters[index];
//                             return DisasterListItem(
//                               id: item['id'] ?? '',
//                               title: truncateString(
//                                   item['name'] ?? 'Unnamed Disaster', 20),
//                               subtitle: truncateString(
//                                   item['summary'] ?? 'No summary available',
//                                   80),
//                               date: item['reported_date'] ?? 'Unknown date',
//                               location: item['districts'] ?? 'Unknown location',
//                               photo: item['banner_photo'] ??
//                                   '', // or a default placeholder image
//                             );
//                             //disasters/wWflu35PtDeJeu8k7Nx5fHKXenorY0gIwtOWk6mY.jpg
//                           },
//                         )))
//               ],
//             ),
//           );
//         }));
//   }
// }

// class CustomListItem extends StatelessWidget {
//   final Item item;

//   const CustomListItem({super.key, required this.item});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.all(10),
//       elevation: 4,
//       child: ListTile(
//         leading: const Icon(Icons.shopping_cart, color: Colors.green),
//         title: Text(item.name,
//             style: const TextStyle(fontWeight: FontWeight.bold)),
//         subtitle: Text(
//             'Price: \$${item.price.toStringAsFixed(2)}\n${item.description}'),
//         trailing: const Icon(Icons.arrow_forward_ios),
//         onTap: () {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Selected: ${item.name}')),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:redcross/controllers/disasters_list_controller.dart';
import 'package:redcross/models/item.dart';
import 'package:redcross/scenes/incidents/incident_list.dart';
import 'package:redcross/scenes/widgets/disaster_list_item.dart';
import 'package:redcross/scenes/widgets/menu_list_items.dart';
import 'package:redcross/utils/colors.dart';

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
        leading: const BackButton(),
        elevation: 0,
        backgroundColor: AppColors.bgColor,
      ),
      body: Obx(() {
        if (disasterController.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (disasterController.disasters.isEmpty) {
          return const Center(
            child: Text('No Disasters were found.'),
          );
        }

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section with improved layout
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title row with responsive layout
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Flexible(
                          child: Text(
                            'Disasters',
                            style: TextStyle(
                              fontFamily: "Inter",
                              fontSize: 28,
                              color: AppColors.blackColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        // View Incidents Button - Compact on mobile, full on tablet
                        Flexible(
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              bool isCompact =
                                  MediaQuery.of(context).size.width < 400;

                              return OutlinedButton.icon(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const IncidentList(),
                                    ),
                                  );
                                },
                                icon: Icon(
                                  Icons.list_alt,
                                  size: isCompact ? 18 : 20,
                                ),
                                label: Text(
                                  isCompact ? "Incidents" : "View Incidents",
                                  style: TextStyle(
                                    fontSize: isCompact ? 13 : 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                style: OutlinedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: isCompact ? 12 : 16,
                                    vertical: isCompact ? 10 : 12,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Active Disasters Header
              const MenuListItems(
                first_title: "Active Disasters",
                second_title: "",
              ),

              const SizedBox(height: 16),

              // Disasters List
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.only(bottom: 16),
                  itemCount: disasterController.disasters.length,
                  itemBuilder: (context, index) {
                    var item = disasterController.disasters[index];
                    return DisasterListItem(
                      id: item['id'] ?? '',
                      title: truncateString(
                        item['name'] ?? 'Unnamed Disaster',
                        20,
                      ),
                      subtitle: truncateString(
                        item['summary'] ?? 'No summary available',
                        80,
                      ),
                      date: item['reported_date'] ?? 'Unknown date',
                      location: item['districts'] ?? 'Unknown location',
                      photo: item['banner_photo'] ?? '',
                    );
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
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
        title: Text(
          item.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          'Price: \$${item.price.toStringAsFixed(2)}\n${item.description}',
        ),
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

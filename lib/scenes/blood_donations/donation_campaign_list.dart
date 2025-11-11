// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:redcross/controllers/donations_controller.dart';
// import 'package:redcross/scenes/blood_donations/donation_campaign_details.dart';
// import 'package:redcross/scenes/widgets/back_button_text.dart';
// import 'package:redcross/scenes/widgets/blood_donation_list_item.dart';
// import 'package:redcross/scenes/widgets/heading_tab.dart';
// import 'package:redcross/utils/colors.dart';

// class DonationCampaignList extends StatelessWidget {
//   DonationCampaignList({super.key});

//   final DonationsController donationsController =
//       Get.put(DonationsController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: AppColors.bgColor,
//         appBar: AppBar(
//           title: const BackButtonText(),
//         ),
//         body: Obx(() {
//           final selected = donationsController.selectedTab.value;

//           if (donationsController.isLoading.value) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }

//           if (donationsController.campaign_list.isEmpty) {
//             return const Center(
//                 child: Center(
//                     child: Text('No Blood Donation Campaigns were found.')));
//           }

//           return SingleChildScrollView(
//               child: Container(
//             width: double.infinity,
//             margin: const EdgeInsets.symmetric(vertical: 20.0),
//             padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 10),
//             child: Column(
//               children: [
//                 SizedBox(
//                   height: 25,
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Padding(
//                           padding: const EdgeInsets.only(left: 10),
//                           child: HeadingTab(
//                               title: 'Upcoming',
//                               active: true,
//                               onPressed: () {
//                                 donationsController.setTab('ongoing');
//                               })),
//                       Padding(
//                           padding: const EdgeInsets.only(left: 2),
//                           child: HeadingTab(
//                               title: 'Active',
//                               active: false,
//                               onPressed: () {
//                                 donationsController.setTab('active');
//                               })),
//                       Padding(
//                           padding: const EdgeInsets.only(right: 10),
//                           child: HeadingTab(
//                               title: 'Completed',
//                               active: false,
//                               onPressed: () {
//                                 donationsController.setTab('completed');
//                               })),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 ListView.builder(
//                   shrinkWrap: true, // ensures list takes only needed height
//                   physics:
//                       const NeverScrollableScrollPhysics(), // disables inner scrolling
//                   itemCount: donationsController.campaign_list.length,
//                   itemBuilder: (context, index) {
//                     var item = donationsController.campaign_list[index];
//                     var location = item["locations"][0];

//                     return Column(
//                       children: [
//                         const SizedBox(height: 15),
//                         BloodDonationListItem(
//                             name: item["name"],
//                             location:
//                                 '${location["region"]} ${location["district"]} ${location["location"]}',
//                             date: '${item["start_date"]}',
//                             time: '10AM-6PM',
//                             onPressed: () {
//                               Navigator.of(context).push(
//                                 MaterialPageRoute(
//                                     builder: (context) =>
//                                         DonationCampaignDetails(
//                                           campaign: item,
//                                         )),
//                               );
//                             })
//                       ],
//                     );
//                   },
//                 )
//               ],
//             ),
//           ));
//         }));
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redcross/controllers/donations_controller.dart';
import 'package:redcross/scenes/blood_donations/donation_campaign_details.dart';
import 'package:redcross/scenes/widgets/back_button_text.dart';
import 'package:redcross/scenes/widgets/blood_donation_list_item.dart';
import 'package:redcross/scenes/widgets/heading_tab.dart';
import 'package:redcross/utils/colors.dart';

class DonationCampaignList extends StatelessWidget {
  DonationCampaignList({super.key});

  final DonationsController donationsController =
      Get.put(DonationsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        title: const BackButtonText(),
        backgroundColor: AppColors.bgColor,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Obx(() {
              final selected = donationsController.selectedTab.value;
              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  HeadingTab(
                    title: 'Upcoming',
                    active: selected == 'ongoing',
                    onPressed: () => donationsController.setTab('ongoing'),
                  ),
                  HeadingTab(
                    title: 'Active',
                    active: selected == 'active',
                    onPressed: () => donationsController.setTab('active'),
                  ),
                  HeadingTab(
                    title: 'Completed',
                    active: selected == 'completed',
                    onPressed: () => donationsController.setTab('completed'),
                  ),
                ],
              );
            }),
          ),

          // ✅ Scrollable campaign list below
          Expanded(
            child: Obx(() {
              if (donationsController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              // Apply filter based on selected tab/status
              final filteredList =
                  donationsController.campaign_list.where((item) {
                final selected = donationsController.selectedTab.value;
                final status = (item["status"] ?? '').toLowerCase();
                return status == selected.toLowerCase();
              }).toList();

              if (filteredList.isEmpty) {
                return const Center(
                  child: Text('No Blood Donation Campaigns were found.'),
                );
              }

              return ListView.builder(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                itemCount: filteredList.length,
                itemBuilder: (context, index) {
                  var item = filteredList[index];
                  var location = item["locations"][0];

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: BloodDonationListItem(
                      name: item["name"],
                      location:
                          '${location["region"]} ${location["district"]} ${location["location"]}',
                      date: '${item["start_date"]}',
                      time: '10AM-6PM',
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                DonationCampaignDetails(campaign: item),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:redcross/controllers/disasters_list_controller.dart';
// import 'package:redcross/scenes/widgets/donation_progress.dart';
// import 'package:redcross/scenes/widgets/form_textfield.dart';
// import 'package:redcross/scenes/widgets/link_field.dart';
// import 'package:redcross/scenes/widgets/price_tag.dart';
// import 'package:redcross/scenes/widgets/red_btn.dart';
// import 'package:redcross/scenes/widgets/tag_item.dart';
// import 'package:redcross/utils/colors.dart';
// import 'package:redcross/utils/storage_service.dart';
// import 'dart:convert';

// class DisasterDetails extends StatefulWidget {
//   DisasterDetails({super.key});

//   final DisastersListController disasterController =
//       Get.put(DisastersListController());

//   @override
//   State<DisasterDetails> createState() => _DisasterDetailsState();
// }

// class _DisasterDetailsState extends State<DisasterDetails> {
//   Map<String, dynamic>? disasterDetails;
//   bool isLoading = true;

//   late final int disasterId;
//   late final String disasterTitle;

//   @override
//   void initState() {
//     super.initState();

//     final args = Get.arguments;
//     disasterId = args['id'];
//     disasterTitle = args['title'];

//     _fetchDisasterDetails();
//   }

//   Future<void> _fetchDisasterDetails() async {
//     String? token = await StorageService.getToken();

//     try {
//       final response = await http.get(
//         Uri.parse('https://urcs-api.taufeeq.dev/api/disasters/$disasterId'),
//         headers: {
//           'Authorization': "Bearer $token",
//           'X-Requested-With': 'XMLHttpRequest'
//         },
//       );

//       if (response.statusCode == 200) {
//         setState(() {
//           disasterDetails = json.decode(response.body);
//           isLoading = false;
//         });
//       } else {
//         setState(() {
//           isLoading = false;
//         });
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Failed to fetch Disaster Details.'),
//           backgroundColor: AppColors.primaryRedColor,
//           behavior: SnackBarBehavior.floating,
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;

//     final bool isSmallMobile = screenWidth < 360;
//     final bool isMobile = screenWidth < 600;
//     final bool isTablet = screenWidth >= 600 && screenWidth < 1024;
//     final bool isDesktop = screenWidth >= 1024;

//     final double horizontalPadding =
//         isDesktop ? 40 : (isTablet ? 30 : (isSmallMobile ? 15 : 25));
//     final double verticalSpacing = isDesktop ? 25 : (isTablet ? 20 : 15);
//     final double imageHeight = isDesktop
//         ? screenHeight * 0.4
//         : (isTablet ? screenHeight * 0.35 : screenHeight * 0.3);

//     final double titleFont =
//         isDesktop ? 32 : (isTablet ? 28 : (isSmallMobile ? 18 : 24));
//     final double subtitleFont =
//         isDesktop ? 18 : (isTablet ? 16 : (isSmallMobile ? 13 : 14));
//     final double smallFont = isDesktop ? 14 : (isTablet ? 13 : 12);
//     final double badgeFont = isDesktop ? 14 : (isTablet ? 13 : 12);

//     // Max content width for tablets/desktops
//     final double maxContentWidth =
//         isDesktop ? 1200 : (isTablet ? 800 : screenWidth);

//     if (isLoading) {
//       return const Scaffold(
//         body: Center(child: CircularProgressIndicator()),
//       );
//     }

//     if (disasterDetails == null) {
//       return Scaffold(
//         body: Center(
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
//             child: Text(
//               'No Data Found About this Disaster!',
//               style: TextStyle(fontSize: subtitleFont),
//               textAlign: TextAlign.center,
//             ),
//           ),
//         ),
//       );
//     }

//     final disasterImage = disasterDetails!['banner_photo'] ?? '';
//     final fatalities =
//         "${disasterDetails!['fatalities']?.toString() ?? "0"} lives lost";
//     final amountNeeded = disasterDetails!['funding_target']?.toString() ?? "0";
//     final currency = disasterDetails!['currency'] ?? "UGX";

//     return Scaffold(
//       backgroundColor: AppColors.bgColor,
//       appBar: AppBar(
//         title: const Text(""),
//         leading: const BackButton(),
//         elevation: 0,
//       ),
//       body: SingleChildScrollView(
//         child: Center(
//           child: ConstrainedBox(
//             constraints: BoxConstraints(maxWidth: maxContentWidth),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // --- Image with Badge ---
//                 Stack(
//                   children: [
//                     SizedBox(
//                       width: double.infinity,
//                       height: imageHeight,
//                       child: disasterImage.isNotEmpty
//                           ? Image.network(
//                               'https://urcs-api.taufeeq.dev/storage/$disasterImage',
//                               fit: BoxFit.cover,
//                               loadingBuilder:
//                                   (context, child, loadingProgress) {
//                                 if (loadingProgress == null) return child;
//                                 return const Center(
//                                     child: CircularProgressIndicator());
//                               },
//                               errorBuilder: (context, error, stackTrace) {
//                                 return Image.asset(
//                                   "assets/images/placeholder.jpg",
//                                   fit: BoxFit.cover,
//                                 );
//                               },
//                             )
//                           : Image.asset(
//                               "assets/images/placeholder.jpg",
//                               fit: BoxFit.cover,
//                             ),
//                     ),
//                     Positioned(
//                       left: horizontalPadding * 0.4,
//                       top: verticalSpacing,
//                       child: Container(
//                         padding: EdgeInsets.symmetric(
//                           horizontal: isSmallMobile ? 8 : 10,
//                           vertical: isSmallMobile ? 4 : 6,
//                         ),
//                         decoration: BoxDecoration(
//                           color: AppColors.primaryRedColor,
//                           borderRadius: BorderRadius.circular(5),
//                         ),
//                         child: Row(
//                           children: [
//                             Icon(
//                               Icons.circle_rounded,
//                               color: AppColors.whiteColor,
//                               size: isSmallMobile ? 5 : 6,
//                             ),
//                             SizedBox(width: isSmallMobile ? 4 : 5),
//                             Text(
//                               'Disaster',
//                               style: TextStyle(
//                                 fontSize: badgeFont,
//                                 fontWeight: FontWeight.w600,
//                                 color: AppColors.whiteColor,
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),

//                 SizedBox(height: verticalSpacing),

//                 // --- Disaster Name ---
//                 Padding(
//                   padding: EdgeInsets.symmetric(
//                     horizontal: horizontalPadding,
//                     vertical: verticalSpacing * 0.3,
//                   ),
//                   child: Text(
//                     StorageService.truncateString(
//                       disasterDetails!['name'] ?? 'Unnamed Disaster',
//                       isDesktop ? 80 : (isTablet ? 60 : 40),
//                     ),
//                     style: TextStyle(
//                         fontSize: titleFont,
//                         fontWeight: FontWeight.w700,
//                         color: AppColors.blackColor,
//                         height: 1.2,
//                         fontFamily: "Inter"),
//                     maxLines: isDesktop ? 3 : 2,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),

//                 SizedBox(height: verticalSpacing * 0.5),

//                 // --- Disaster Summary ---
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
//                   child: Text(
//                     disasterDetails!['summary'] ?? '',
//                     style: TextStyle(
//                         fontSize: subtitleFont,
//                         fontWeight: FontWeight.w400,
//                         color: AppColors.blackColor,
//                         height: 1.5,
//                         fontFamily: "Inter"),
//                   ),
//                 ),

//                 SizedBox(height: verticalSpacing),

//                 Padding(
//                   padding:
//                       EdgeInsets.symmetric(horizontal: horizontalPadding * 0.6),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // --- Fatalities & Needed Amount ---
//                       Container(
//                         padding: EdgeInsets.symmetric(
//                             vertical: verticalSpacing * 0.3),
//                         margin: EdgeInsets.symmetric(
//                             vertical: verticalSpacing * 0.3),
//                         decoration: const BoxDecoration(
//                           border: Border(
//                             top: BorderSide(
//                                 color: AppColors.primaryRedColor, width: 1),
//                           ),
//                         ),
//                         child: Wrap(
//                           spacing: isDesktop ? 25 : (isTablet ? 20 : 15),
//                           runSpacing: 8,
//                           children: [
//                             Text(
//                               fatalities,
//                               style: TextStyle(
//                                   fontSize: subtitleFont,
//                                   fontWeight: FontWeight.w600,
//                                   color: AppColors.primaryRedColor,
//                                   fontFamily: "Inter"),
//                             ),
//                             Text(
//                               "${StorageService.formatCurrency(double.parse(amountNeeded))} Needed",
//                               style: TextStyle(
//                                   fontSize: subtitleFont,
//                                   fontWeight: FontWeight.w600,
//                                   color: AppColors.primaryRedColor,
//                                   fontFamily: "Inter"),
//                             ),
//                           ],
//                         ),
//                       ),

//                       SizedBox(height: verticalSpacing * 0.7),
//                       TagItem(
//                         label: "Emergency Support",
//                         height: isSmallMobile ? 20 : 23.35,
//                         width: isSmallMobile ? 120 : 132,
//                       ),
//                       SizedBox(height: verticalSpacing * 0.7),

//                       // --- Link Fields ---
//                       const LinkField(label: 'Nearby Hospitals'),
//                       SizedBox(height: verticalSpacing * 0.7),
//                       const LinkField(label: 'Local Shelters'),
//                       SizedBox(height: verticalSpacing * 0.7),
//                       const LinkField(
//                           label: 'Food & Clothing Distribution Points'),
//                       SizedBox(height: verticalSpacing * 1.5),

//                       // --- Donation Progress ---
//                       DonationProgress(
//                         amount: StorageService.formatCurrency(double.parse(
//                                 disasterDetails!['funds_raised'] ?? '0')) ??
//                             "500,000",
//                         target: StorageService.formatCurrency(double.parse(
//                                 disasterDetails!['funding_target'] ?? '0')) ??
//                             "2,000,000",
//                         currency: currency,
//                       ),

//                       SizedBox(height: verticalSpacing * 1.5),

//                       // --- Donate Button ---
//                       RedBtn(
//                         squared: true,
//                         label: 'Donate to Emergency',
//                         onPressed: () {
//                           showModalBottomSheet(
//                             context: context,
//                             isScrollControlled: true,
//                             shape: const RoundedRectangleBorder(
//                               borderRadius: BorderRadius.vertical(
//                                   top: Radius.circular(20)),
//                             ),
//                             builder: (BuildContext context) {
//                               final sheetHeight = isDesktop
//                                   ? screenHeight * 0.6
//                                   : (isTablet
//                                       ? screenHeight * 0.7
//                                       : screenHeight * 0.75);

//                               return Container(
//                                 width: double.infinity,
//                                 height: sheetHeight,
//                                 padding: EdgeInsets.all(
//                                   isDesktop ? 40 : (isTablet ? 30 : 20),
//                                 ),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Center(
//                                       child: Text(
//                                         "Donation Amount",
//                                         style: TextStyle(
//                                           fontSize: isDesktop
//                                               ? 24
//                                               : (isTablet
//                                                   ? 20
//                                                   : subtitleFont * 1.3),
//                                           fontWeight: FontWeight.w600,
//                                           fontFamily: "Inter",
//                                           color: AppColors.blackColorG,
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(height: verticalSpacing),
//                                     Center(
//                                       child: ConstrainedBox(
//                                         constraints: BoxConstraints(
//                                           maxWidth:
//                                               isDesktop ? 500 : double.infinity,
//                                         ),
//                                         child: FormTextfield(
//                                           isNumberField: false,
//                                           no_question: false,
//                                           question: "Enter Price Manually",
//                                           textEditingController: widget
//                                               .disasterController
//                                               .donationAmount,
//                                           validator: (String? value) => null,
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(height: verticalSpacing),

//                                     // --- PriceTag Buttons with Wrap ---
//                                     Center(
//                                       child: ConstrainedBox(
//                                         constraints: BoxConstraints(
//                                           maxWidth:
//                                               isDesktop ? 600 : double.infinity,
//                                         ),
//                                         child: Wrap(
//                                           spacing: isDesktop
//                                               ? 12
//                                               : (isTablet ? 10 : 8),
//                                           runSpacing: isDesktop
//                                               ? 12
//                                               : (isTablet ? 10 : 8),
//                                           alignment: WrapAlignment.center,
//                                           children: List.generate(6, (index) {
//                                             final labels = [
//                                               '100K',
//                                               '250K',
//                                               '350K',
//                                               '500K',
//                                               '750K',
//                                               '1 million'
//                                             ];
//                                             final flagId = index + 1;
//                                             return PriceTag(
//                                               label: labels[index],
//                                               active: widget.disasterController
//                                                       .flagId ==
//                                                   flagId,
//                                               onPressed: () {
//                                                 widget.disasterController
//                                                     .setAmountActive(
//                                                         flagId, labels[index]);
//                                               },
//                                             );
//                                           }),
//                                         ),
//                                       ),
//                                     ),

//                                     const Spacer(),

// ignore_for_file: use_super_parameters, unused_local_variable, unrelated_type_equality_checks, avoid_print, use_build_context_synchronously

//                                     Center(
//                                       child: ConstrainedBox(
//                                         constraints: BoxConstraints(
//                                           maxWidth:
//                                               isDesktop ? 500 : double.infinity,
//                                         ),
//                                         child: RedBtn(
//                                           squared: true,
//                                           label: 'Continue to Payment',
//                                           onPressed: () {
//                                             Navigator.of(context).pop();
//                                             Get.toNamed("/initiate-payment",
//                                                 arguments: {
//                                                   "disasterId":
//                                                       disasterDetails!['id']
//                                                 });
//                                           },
//                                         ),
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               );
//                             },
//                           );
//                         },
//                       ),
//                       SizedBox(height: verticalSpacing * 1.5),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:redcross/controllers/disasters_list_controller.dart';
import 'package:redcross/scenes/donations/payment.dart';
import 'package:redcross/scenes/widgets/donation_progress.dart';
// import 'package:redcross/scenes/widgets/form_textfield.dart';
import 'package:redcross/scenes/widgets/link_field.dart';
import 'package:redcross/scenes/widgets/red_btn.dart';
import 'package:redcross/scenes/widgets/tag_item.dart';
import 'package:redcross/utils/colors.dart';
import 'package:redcross/utils/storage_service.dart';
import 'dart:convert';

class DisasterDetails extends StatefulWidget {
  final int id;
  final String title;

  DisasterDetails({super.key, required this.title, required this.id});

  final DisastersListController disasterController =
      Get.put(DisastersListController());

  @override
  State<DisasterDetails> createState() => _DisasterDetailsState();
}

class _DisasterDetailsState extends State<DisasterDetails> {
  Map<String, dynamic>? disasterDetails;
  bool isLoading = true;

  late final int disasterId;
  late final String disasterTitle;

  @override
  void initState() {
    super.initState();

    disasterId = widget.id;
    disasterTitle = widget.title;
    _fetchDisasterDetails();
  }

  Future<void> _fetchDisasterDetails() async {
    String? token = await StorageService.getToken();

    try {
      final response = await http.get(
        Uri.parse('https://urcs-api.taufeeq.dev/api/disasters/$disasterId'),
        headers: {
          'Authorization': "Bearer $token",
          'X-Requested-With': 'XMLHttpRequest'
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          disasterDetails = json.decode(response.body);
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to fetch Disaster Details.'),
          backgroundColor: AppColors.primaryRedColor,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final bool isSmallMobile = screenWidth < 360;
    final bool isMobile = screenWidth < 600;
    final bool isTablet = screenWidth >= 600 && screenWidth < 1024;
    final bool isDesktop = screenWidth >= 1024;

    final double horizontalPadding =
        isDesktop ? 40 : (isTablet ? 30 : (isSmallMobile ? 15 : 25));
    final double verticalSpacing = isDesktop ? 25 : (isTablet ? 20 : 15);
    final double imageHeight = isDesktop
        ? screenHeight * 0.4
        : (isTablet ? screenHeight * 0.35 : screenHeight * 0.3);

    final double titleFont =
        isDesktop ? 32 : (isTablet ? 28 : (isSmallMobile ? 18 : 24));
    final double subtitleFont =
        isDesktop ? 18 : (isTablet ? 16 : (isSmallMobile ? 13 : 14));
    final double smallFont = isDesktop ? 14 : (isTablet ? 13 : 12);
    final double badgeFont = isDesktop ? 14 : (isTablet ? 13 : 12);

    // Max content width for tablets/desktops
    final double maxContentWidth =
        isDesktop ? 1200 : (isTablet ? 800 : screenWidth);

    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (disasterDetails == null) {
      return Scaffold(
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Text(
              'No Data Found About this Disaster!',
              style: TextStyle(fontSize: subtitleFont),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }

    final disasterImage = disasterDetails!['banner_photo'] ?? '';
    final fatalities =
        "${disasterDetails!['fatalities']?.toString() ?? "0"} lives lost";
    final amountNeeded = disasterDetails!['funding_target']?.toString() ?? "0";
    final currency = disasterDetails!['currency'] ?? "UGX";

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        title: const Text(""),
        leading: const BackButton(),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxContentWidth),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- Image with Badge ---
                Stack(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: imageHeight,
                      child: disasterImage.isNotEmpty
                          ? Image.network(
                              'https://urcs-api.taufeeq.dev/storage/$disasterImage',
                              fit: BoxFit.cover,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return const Center(
                                    child: CircularProgressIndicator());
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  "assets/images/placeholder.jpg",
                                  fit: BoxFit.cover,
                                );
                              },
                            )
                          : Image.asset(
                              "assets/images/placeholder.jpg",
                              fit: BoxFit.cover,
                            ),
                    ),
                    Positioned(
                      left: horizontalPadding * 0.4,
                      top: verticalSpacing,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: isSmallMobile ? 8 : 10,
                          vertical: isSmallMobile ? 4 : 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primaryRedColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.circle_rounded,
                              color: AppColors.whiteColor,
                              size: isSmallMobile ? 5 : 6,
                            ),
                            SizedBox(width: isSmallMobile ? 4 : 5),
                            Text(
                              'Disaster',
                              style: TextStyle(
                                fontSize: badgeFont,
                                fontWeight: FontWeight.w600,
                                color: AppColors.whiteColor,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: verticalSpacing),

                // --- Disaster Name ---
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                    vertical: verticalSpacing * 0.3,
                  ),
                  child: Text(
                    StorageService.truncateString(
                      disasterDetails!['name'] ?? 'Unnamed Disaster',
                      isDesktop ? 80 : (isTablet ? 60 : 40),
                    ),
                    style: TextStyle(
                        fontSize: titleFont,
                        fontWeight: FontWeight.w700,
                        color: AppColors.blackColor,
                        height: 1.2,
                        fontFamily: "Inter"),
                    maxLines: isDesktop ? 3 : 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                SizedBox(height: verticalSpacing * 0.5),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: Text(
                    disasterDetails!['summary'] ?? '',
                    style: TextStyle(
                        fontSize: subtitleFont,
                        fontWeight: FontWeight.w400,
                        color: AppColors.blackColor,
                        height: 1.5,
                        fontFamily: "Inter"),
                  ),
                ),

                SizedBox(height: verticalSpacing),

                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: horizontalPadding * 0.6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // --- Fatalities & Needed Amount ---
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: verticalSpacing * 0.3),
                        margin: EdgeInsets.symmetric(
                            vertical: verticalSpacing * 0.3),
                        decoration: const BoxDecoration(
                          border: Border(
                            top: BorderSide(
                                color: AppColors.primaryRedColor, width: 1),
                          ),
                        ),
                        child: Wrap(
                          spacing: isDesktop ? 25 : (isTablet ? 20 : 15),
                          runSpacing: 8,
                          children: [
                            Text(
                              fatalities,
                              style: TextStyle(
                                  fontSize: subtitleFont,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryRedColor,
                                  fontFamily: "Inter"),
                            ),
                            Text(
                              "${StorageService.formatCurrency(double.parse(amountNeeded))} Needed",
                              style: TextStyle(
                                  fontSize: subtitleFont,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryRedColor,
                                  fontFamily: "Inter"),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: verticalSpacing * 0.7),
                      TagItem(
                        label: "Emergency Support",
                        height: isSmallMobile ? 20 : 23.35,
                        width: isSmallMobile ? 120 : 132,
                      ),
                      SizedBox(height: verticalSpacing * 0.7),

                      // --- Link Fields ---
                      const LinkField(label: 'Nearby Hospitals'),
                      SizedBox(height: verticalSpacing * 0.7),
                      const LinkField(label: 'Local Shelters'),
                      SizedBox(height: verticalSpacing * 0.7),
                      const LinkField(
                          label: 'Food & Clothing Distribution Points'),
                      SizedBox(height: verticalSpacing * 1.5),

                      // --- Donation Progress ---
                      DonationProgress(
                        amount: StorageService.formatCurrency(double.parse(
                                disasterDetails!['funds_raised'] ?? '0')) ??
                            "500,000",
                        target: StorageService.formatCurrency(double.parse(
                                disasterDetails!['funding_target'] ?? '0')) ??
                            "2,000,000",
                        currency: currency,
                      ),

                      SizedBox(height: verticalSpacing * 1.5),

                      // --- Donate Button ---
                      RedBtn(
                        squared: true,
                        label: 'Donate to Emergency',
                        onPressed: () {
                          _showDonationBottomSheet(
                            context,
                            screenHeight,
                            screenWidth,
                            isDesktop,
                            isTablet,
                            isSmallMobile,
                          );
                        },
                      ),
                      SizedBox(height: verticalSpacing * 1.5),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showDonationBottomSheet(
    BuildContext context,
    double screenHeight,
    double screenWidth,
    bool isDesktop,
    bool isTablet,
    bool isSmallMobile,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return DonationAmountBottomSheet(
          disasterController: widget.disasterController,
          disasterDetails: disasterDetails,
          screenHeight: screenHeight,
          screenWidth: screenWidth,
          isDesktop: isDesktop,
          isTablet: isTablet,
          isSmallMobile: isSmallMobile,
          disasterId: disasterDetails!['id'],
        );
      },
    );
  }
}

// Donation Amount Bottom Sheet
class DonationAmountBottomSheet extends StatefulWidget {
  final DisastersListController disasterController;
  final Map<String, dynamic>? disasterDetails;
  final double screenHeight;
  final double screenWidth;
  final bool isDesktop;
  final bool isTablet;
  final bool isSmallMobile;
  final int disasterId;

  const DonationAmountBottomSheet({
    Key? key,
    required this.disasterController,
    required this.disasterDetails,
    required this.screenHeight,
    required this.screenWidth,
    required this.isDesktop,
    required this.isTablet,
    required this.isSmallMobile,
    required this.disasterId,
  }) : super(key: key);

  @override
  _DonationAmountBottomSheetState createState() =>
      _DonationAmountBottomSheetState();
}

class _DonationAmountBottomSheetState extends State<DonationAmountBottomSheet> {
  int? selectedAmountIndex;
  final amountController = TextEditingController();

  final Map<String, int> amountValues = {
    '100K': 100000,
    '250K': 250000,
    '350K': 350000,
    '500K': 500000,
    '750K': 750000,
    '1 million': 1000000,
  };

  @override
  Widget build(BuildContext context) {
    final amounts = ['100K', '250K', '350K', '500K', '750K', '1 million'];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              margin: EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            Padding(
              padding: EdgeInsets.all(widget.isDesktop ? 32 : 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Text(
                      'Donation amount',
                      style: TextStyle(
                        fontSize:
                            widget.isDesktop ? 22 : (widget.isTablet ? 20 : 18),
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        fontFamily: "Inter",
                      ),
                    ),
                  ),
                  SizedBox(
                      height:
                          widget.isDesktop ? 24 : (widget.isTablet ? 20 : 16)),

                  // Custom amount input
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey[200]!),
                    ),
                    child: TextField(
                      controller: amountController,
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                        fontSize: widget.isDesktop ? 16 : 14,
                        fontFamily: "Inter",
                      ),
                      decoration: InputDecoration(
                        hintText: 'Enter Amount Manually',
                        hintStyle: TextStyle(
                          color: Colors.grey[400],
                          fontSize: widget.isDesktop ? 16 : 14,
                          fontFamily: "Inter",
                        ),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 12),
                      ),
                      onChanged: (value) {
                        setState(() {
                          selectedAmountIndex = null;
                          // widget.disasterController.flagId = 0;
                        });
                      },
                    ),
                  ),

                  SizedBox(
                      height:
                          widget.isDesktop ? 24 : (widget.isTablet ? 20 : 16)),

                  // Quick amount selection grid
                  Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: widget.isDesktop
                            ? 600
                            : (widget.isTablet ? 500 : double.infinity),
                      ),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: widget.isDesktop
                              ? 2.8
                              : (widget.isTablet ? 2.6 : 2.4),
                          crossAxisSpacing: widget.isDesktop ? 12 : 10,
                          mainAxisSpacing: widget.isDesktop ? 12 : 10,
                        ),
                        itemCount: amounts.length,
                        itemBuilder: (context, index) {
                          String amount = amounts[index];
                          bool isSelected = selectedAmountIndex == index;

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedAmountIndex = index;

                                // Populate the visible text field with the
                                // picked amount (amountController is what
                                // the TextField above is actually bound to).
                                int numericValue = amountValues[amount]!;
                                amountController.text = numericValue.toString();
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Color(0xFFFFE5E5)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: isSelected
                                      ? AppColors.primaryRedColor
                                      : Colors.grey[300]!,
                                  width: isSelected ? 2 : 1,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  amount,
                                  style: TextStyle(
                                    fontSize: widget.isDesktop
                                        ? 16
                                        : (widget.isTablet ? 15 : 14),
                                    fontWeight: isSelected
                                        ? FontWeight.w600
                                        : FontWeight.w500,
                                    color: isSelected
                                        ? AppColors.primaryRedColor
                                        : Colors.black87,
                                    fontFamily: "Inter",
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  SizedBox(
                      height:
                          widget.isDesktop ? 32 : (widget.isTablet ? 28 : 24)),

                  // Continue button
                  Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: widget.isDesktop
                            ? 500
                            : (widget.isTablet ? 400 : double.infinity),
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        height: widget.isDesktop ? 56 : 52,
                        child: ElevatedButton(
                          onPressed: () {
                            // final amount = amountController.text.trim();

                            final text = amountController.text.trim();

                            if (text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content:
                                        Text("Please enter an amount in UGX.")),
                              );
                              return;
                            }

                            final amount = int.tryParse(text);

                            if (amount == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Invalid number.")),
                              );
                              return;
                            }

                            if (amount < 5000) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(
                                        "Minimum amount to be donated is 5,000 UGX")),
                              );
                              return;
                            }

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => Payment(
                                    amount: amount,
                                    disasterId: widget.disasterId),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryRedColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                          ),
                          child: Text(
                            'Continue to Payment',
                            style: TextStyle(
                              color: AppColors.whiteColor,
                              fontSize: widget.isDesktop ? 17 : 16,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Inter",
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

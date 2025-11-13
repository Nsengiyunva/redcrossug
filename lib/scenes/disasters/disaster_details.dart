import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:redcross/controllers/disasters_list_controller.dart';
import 'package:redcross/scenes/widgets/donation_progress.dart';
import 'package:redcross/scenes/widgets/form_textfield.dart';
import 'package:redcross/scenes/widgets/link_field.dart';
import 'package:redcross/scenes/widgets/price_tag.dart';
import 'package:redcross/scenes/widgets/red_btn.dart';
import 'package:redcross/scenes/widgets/tag_item.dart';
import 'package:redcross/utils/colors.dart';
import 'package:redcross/utils/storage_service.dart';
import 'dart:convert';

class DisasterDetails extends StatefulWidget {
  DisasterDetails({super.key});

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

    // Safely get arguments here
    final args = Get.arguments;
    disasterId = args['id'];
    disasterTitle = args['title'];

    _fetchDisasterDetails();
  }

  Future<void> _fetchDisasterDetails() async {
    String? token = await StorageService.getToken();

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
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Responsive font sizes
    final titleFont = screenWidth * 0.06; // ~6% of screen width
    final subtitleFont = screenWidth * 0.035;
    final smallFont = screenWidth * 0.03;

    // Max content width for tablets/desktops
    final maxContentWidth = screenWidth > 700 ? 700.0 : screenWidth;

    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (disasterDetails == null) {
      return const Scaffold(
        body: Center(child: Text('No Data Found About this Disaster!')),
      );
    }

    final disasterImage = disasterDetails!['banner_photo'] ?? '';
    final fatalities =
        (disasterDetails!['fatalities']?.toString() ?? "0") + " lives lost";
    final amountNeeded = disasterDetails!['funding_target']?.toString() ?? "0";
    final currency = disasterDetails!['currency'] ?? "UGX";

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(title: const Text(""), leading: const BackButton()),
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxContentWidth),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: screenHeight * 0.35,
                      child: disasterImage.length > 0
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
                      left: 10,
                      top: screenHeight * 0.03,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.primaryRedColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          children: const [
                            Icon(
                              Icons.circle_rounded,
                              color: AppColors.whiteColor,
                              size: 6,
                            ),
                            SizedBox(width: 5),
                            Text(
                              'Disaster',
                              style: TextStyle(
                                fontSize: 12,
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

                const SizedBox(height: 10),

                // --- Disaster Name ---
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      StorageService.truncateString(
                          disasterDetails!['name'] ?? 'Unnamed Disaster', 40),
                      style: TextStyle(
                        fontSize: titleFont,
                        fontWeight: FontWeight.w700,
                        color: AppColors.blackColor,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // --- Disaster Summary ---
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Text(
                    disasterDetails!['summary'] ?? '',
                    style: TextStyle(
                      fontSize: subtitleFont,
                      fontWeight: FontWeight.w400,
                      color: AppColors.blackColor,
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // --- Fatalities & Needed Amount ---
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        decoration: const BoxDecoration(
                          border: Border(
                            top: BorderSide(
                                color: AppColors.primaryRedColor, width: 1),
                          ),
                        ),
                        child: Wrap(
                          spacing: 15,
                          runSpacing: 8,
                          children: [
                            Text(
                              fatalities,
                              style: TextStyle(
                                  fontSize: subtitleFont,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryRedColor),
                            ),
                            Text(
                              "${StorageService.formatCurrency(double.parse(amountNeeded))} Needed",
                              style: TextStyle(
                                  fontSize: subtitleFont,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryRedColor),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 10),
                      const TagItem(
                          label: "Emergency Support",
                          height: 23.35,
                          width: 132),
                      const SizedBox(height: 10),

                      // --- Link Fields ---
                      const LinkField(label: 'Nearby Hospitals'),
                      const SizedBox(height: 10),
                      const LinkField(label: 'Local Shelters'),
                      const SizedBox(height: 10),
                      const LinkField(
                          label: 'Food & Clothing Distribution Points'),
                      const SizedBox(height: 25),

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

                      const SizedBox(height: 25),

                      // --- Donate Button ---
                      RedBtn(
                        squared: true,
                        label: 'Donate to Emergency',
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(0)),
                            ),
                            builder: (BuildContext context) {
                              final sheetHeight = screenHeight * 0.75;

                              return Container(
                                width: double.infinity,
                                height: sheetHeight,
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Text(
                                        "Donation Amount",
                                        style: TextStyle(
                                          fontSize: screenWidth * 0.045,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.blackColorG,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 25),
                                    Center(
                                      child: FormTextfield(
                                        isNumberField: false,
                                        no_question: false,
                                        question: "Enter Price Manually",
                                        textEditingController: widget
                                            .disasterController.donationAmount,
                                        validator: (String? value) => null,
                                      ),
                                    ),
                                    const SizedBox(height: 25),

                                    // --- PriceTag Buttons with Wrap ---
                                    Wrap(
                                      spacing: 8,
                                      runSpacing: 8,
                                      children: List.generate(6, (index) {
                                        final labels = [
                                          '100K',
                                          '250K',
                                          '350K',
                                          '500K',
                                          '750K',
                                          '1 million'
                                        ];
                                        final flagId = index + 1;
                                        return PriceTag(
                                          label: labels[index],
                                          active: widget
                                                  .disasterController.flagId ==
                                              flagId,
                                          onPressed: () {
                                            widget.disasterController
                                                .setAmountActive(
                                                    flagId, labels[index]);
                                          },
                                        );
                                      }),
                                    ),

                                    const Spacer(),

                                    RedBtn(
                                      squared: true,
                                      label: 'Continue to Payment',
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        Get.toNamed("/initiate-payment",
                                            arguments: {
                                              "disasterId":
                                                  disasterDetails!['id']
                                            });
                                      },
                                    )
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 25),
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
}

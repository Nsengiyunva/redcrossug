import 'package:flutter/material.dart';
import 'package:redcross/scenes/first_aid/first_aid_emergencies.dart';
import 'package:redcross/scenes/first_aid/training/training_home.dart';
import 'package:redcross/scenes/widgets/icon_card.dart';
import 'package:redcross/scenes/widgets/red_btn.dart';
import 'package:redcross/utils/colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';

class FirstAidHome extends StatefulWidget {
  const FirstAidHome({super.key});

  @override
  State<FirstAidHome> createState() => _FirstAidHomeState();
}

class _FirstAidHomeState extends State<FirstAidHome> {
  final _phoneController = TextEditingController();
  final _msgController = TextEditingController(text: "Hello from Flutter!");
  String androidPackageName = "com.whatsapp";

  @override
  void dispose() {
    _phoneController.dispose();
    _msgController.dispose();
    super.dispose();
  }

  Future<void> openWhatsApp(
      {required String phone, required String message}) async {
    try {
      final encodedMsg = Uri.encodeComponent(message);
      final whatsappUri =
          Uri.parse('whatsapp://send?phone=$phone&text=$encodedMsg');
      final waMeUri = Uri.parse('https://wa.me/$phone?text=$encodedMsg');

      await Future.delayed(const Duration(milliseconds: 100));

      if (await canLaunchUrl(whatsappUri)) {
        await launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
        return;
      }

      if (await canLaunchUrl(waMeUri)) {
        await launchUrl(waMeUri, mode: LaunchMode.externalApplication);
        return;
      }

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text(
                  'Could not open WhatsApp. It appears not be installed. Install the app and try again.')),
        );
      }
    } catch (e) {
      debugPrint("Error opening WhatsApp: $e");
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  Future<void> _openApp() async {
    if (Platform.isAndroid) {
      final Uri androidUri =
          Uri.parse("intent://#Intent;package=$androidPackageName;end");
      if (!await launchUrl(androidUri)) {
        debugPrint("App not installed on Android");
      }
    }
  }

  Future<void> callEmergencyNumber(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);

    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 360;
    final padding = size.width * 0.05;

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        title: const Text(""),
        leading: const BackButton(),
        elevation: 0,
        backgroundColor: AppColors.bgColor,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          openWhatsApp(
            phone: "256760588189",
            message: "Hey, Hello Uganda Red Cross Society",
          );
        },
        backgroundColor: const Color(0xFF25D366), // WhatsApp green
        icon: const Icon(Icons.chat_bubble, color: Colors.white),
        label: const Text(
          'Chat with Us',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
        elevation: 4,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              vertical: size.height * 0.03,
              horizontal: padding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Section with Icon
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.medical_services,
                        color: Colors.red.shade700,
                        size: isSmallScreen ? 28 : 32,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "First Aid",
                            style: TextStyle(
                              fontFamily: "Inter",
                              fontSize: isSmallScreen ? 24 : 28,
                              fontWeight: FontWeight.w700,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Emergency care at your fingertips",
                            style: TextStyle(
                              fontFamily: "Inter",
                              fontSize: isSmallScreen ? 13 : 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: size.height * 0.04),

                // Info Card
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.red.shade50,
                        Colors.red.shade100.withOpacity(0.5),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.red.shade200,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: Colors.red.shade700,
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          "Quick access to life-saving information and emergency services",
                          style: TextStyle(
                            fontSize: isSmallScreen ? 13 : 14,
                            color: Colors.red.shade900,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: size.height * 0.03),

                // Action Cards
                LayoutBuilder(
                  builder: (context, constraints) {
                    final cardWidth = (constraints.maxWidth - 16) / 2;
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: cardWidth,
                          child: IconCard(
                            icon_name: 'add',
                            label: "First Aid Guide",
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const FirstAidEmergencies(),
                                ),
                              );
                              // Get.to(SomePage());  // if using GetX
                            },
                          ),
                        ),
                        SizedBox(
                          width: cardWidth,
                          child: IconCard(
                            icon_name: 'hospital',
                            label: "Request Training",
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const TrainingHome(),
                                ),
                              );
                              // Get.to(SomePage());  // if using GetX
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),

                SizedBox(height: size.height * 0.025),

                // Emergency Button with enhanced styling
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.red.withOpacity(0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: RedBtn(
                    label: 'Call for Emergency Services',
                    onPressed: () {
                      callEmergencyNumber("+256760588189");
                    },
                  ),
                ),

                SizedBox(height: size.height * 0.03),

                // Help Section
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.support_agent,
                            color: Colors.green.shade700,
                            size: 24,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            "Need Help?",
                            style: TextStyle(
                              fontSize: isSmallScreen ? 16 : 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "Our team is available 24/7 to assist you with any emergency or questions.",
                        style: TextStyle(
                          fontSize: isSmallScreen ? 13 : 14,
                          color: Colors.black54,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 16),
                      InkWell(
                        onTap: () {
                          openWhatsApp(
                            phone: "256760588189",
                            message: "Hey, Hello Uganda Red Cross Society",
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green.shade50,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.green.shade200,
                              width: 1.5,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.message,
                                color: Colors.green.shade700,
                                size: 20,
                              ),
                              const SizedBox(width: 10),
                              Flexible(
                                child: Text(
                                  'Message Uganda Red Cross Society',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.green.shade700,
                                    fontWeight: FontWeight.w600,
                                    fontSize: isSmallScreen ? 13 : 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: size.height * 0.03),

                // Bottom spacing for FAB
                const SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

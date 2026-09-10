import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:redcross/controllers/ambulance_controller.dart';
import 'package:redcross/scenes/ambulances/ambulance_emergency.dart';
import 'package:redcross/scenes/ambulances/ambulance_form.dart';
import 'package:redcross/scenes/ambulances/ambulance_list.dart';
import 'package:redcross/scenes/ambulances/available_ambulances.dart';
import 'package:redcross/scenes/widgets/red_btn.dart';
import 'package:redcross/utils/colors.dart';
import 'package:redcross/utils/storage_service.dart';

class AmbulanceHome extends StatelessWidget {
  AmbulanceHome({super.key});

  final AmbulanceController ambulanceController =
      Get.put(AmbulanceController());

  Future<void> _callNumber(BuildContext context, String phoneNumber) async {
    final Uri uri = Uri(scheme: 'tel', path: phoneNumber);
    try {
      // No canLaunchUrl gate — see the note in default_home.dart's
      // _openAboutUsUrl for why that check unreliably reports false.
      final launched = await launchUrl(uri);
      if (!launched && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not open dialer for $phoneNumber.')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final bool isTablet = screenWidth >= 600;

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Obx(() {
        if (ambulanceController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return Center(
          child: ConstrainedBox(
            constraints:
                BoxConstraints(maxWidth: isTablet ? 560 : double.infinity),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.08,
                vertical: screenHeight * 0.035,
              ),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  /// TITLE
                  Text(
                    "Ambulance Services",
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontSize: (screenWidth * 0.07).clamp(24.0, 34.0),
                      fontWeight: FontWeight.w700,
                      letterSpacing: StorageService.getSpacing(26),
                      height: StorageService.getHeight(30, 26),
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.025),

                  /// IMAGE
                  Center(
                    child: Image.asset(
                      'assets/images/ambulance.png',
                      width: screenWidth * 0.4,
                      height: (screenWidth * 0.37).clamp(110.0, 190.0),
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.03),

                  /// COMMERCIAL BUTTON
                  RedBtn(
                    label: 'Commercial Ambulance',
                    squared: true,
                    font: 14,
                    iconned: true,
                    icon_name: "alert",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => AmbulanceForm()),
                      );
                    },
                  ),

                  const SizedBox(height: 12),

                  /// EMERGENCY BUTTON
                  RedBtn(
                    is_white: true,
                    label: 'Emergency Response',
                    squared: true,
                    font: 14,
                    iconned: true,
                    icon_name: "alert",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => AmbulanceEmergency()),
                      );
                    },
                  ),

                  const SizedBox(height: 20),

                  /// ACTIVE REQUESTS + HISTORY
                  Row(
                    children: [
                      Expanded(
                        child: _QuickLinkButton(
                          icon: Icons.assignment_outlined,
                          label: 'Active Requests',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => AmbulanceList()),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _QuickLinkButton(
                          icon: Icons.local_shipping_outlined,
                          label: 'Ambulance List',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => AvailableAmbulances()),
                            );
                          },
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: screenHeight * 0.03),

                  /// HOTLINES CARD
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppColors.redColorD.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: AppColors.primaryRedColor.withOpacity(0.15),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.support_agent_rounded,
                              size: 18,
                              color: AppColors.primaryRedColor,
                            ),
                            const SizedBox(width: 8),
                            const Expanded(
                              child: Text(
                                "RedCross Ambulance Hotlines",
                                style: TextStyle(
                                  fontFamily: "Inter",
                                  fontSize: 13.4,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.blackColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        _HotlineNumber(
                          number: "+256 770 123 123",
                          onTap: () => _callNumber(context, "+256770123123"),
                        ),
                        const SizedBox(height: 8),
                        _HotlineNumber(
                          number: "+256 410 678 896",
                          onTap: () => _callNumber(context, "+256410678896"),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.03),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

/// A tappable hotline row — phone icon, number, and a call affordance —
/// that opens the phone dialer via [onTap].
class _HotlineNumber extends StatelessWidget {
  final String number;
  final VoidCallback onTap;

  const _HotlineNumber({required this.number, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.whiteColor,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AppColors.primaryRedColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.call_rounded,
                  size: 16,
                  color: AppColors.primaryRedColor,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  number,
                  style: const TextStyle(
                    color: AppColors.blackColorB,
                    fontSize: 14.7,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Inter",
                  ),
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                size: 20,
                color: AppColors.greyColorC,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Pill-style quick-link button used for "Active Requests" / "Ambulance List".
/// Sits visually between the solid and outlined [RedBtn] styles above it —
/// a light teal chip so the pair reads as secondary navigation rather than
/// another pair of primary actions.
class _QuickLinkButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const _QuickLinkButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.greenColorA.withOpacity(0.06),
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.greenColorA.withOpacity(0.3)),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 16, color: AppColors.greenColorA),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontFamily: "Inter",
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.greenColorA,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

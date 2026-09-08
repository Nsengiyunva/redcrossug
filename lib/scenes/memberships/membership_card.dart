import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MembershipCard extends StatelessWidget {
  const MembershipCard({super.key});

  static const String _memberRegistrationUrl =
      'https://vms.redcrossug.org/member/register/';

  Future<void> _openMemberRegistrationUrl(BuildContext context) async {
    final Uri uri = Uri.parse(_memberRegistrationUrl);
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content:
                  Text('Could not open the membership registration page.')),
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
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 360;
    final padding = size.width * 0.05;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FC),
      appBar: AppBar(
        title: const Text(""),
        leading: const BackButton(),
        elevation: 0,
        backgroundColor: const Color(0xFFF6F8FC),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              vertical: size.height * 0.02,
              horizontal: padding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// --------------------------------------------------
                /// HEADER
                /// --------------------------------------------------
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.card_membership,
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
                            "Become a URCS Member",
                            style: TextStyle(
                              fontFamily: "Inter",
                              fontSize: isSmallScreen ? 22 : 26,
                              fontWeight: FontWeight.w700,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Be part of the Red Cross family.",
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
                SizedBox(height: size.height * 0.035),

                /// --------------------------------------------------
                /// INTRO
                /// --------------------------------------------------
                Text(
                  'Membership of the Uganda Red Cross Society gives you an '
                  'opportunity to formally belong to the Society and '
                  'contribute to its humanitarian mission.',
                  style: TextStyle(
                    fontSize: isSmallScreen ? 13 : 14,
                    color: Colors.grey[700],
                    height: 1.6,
                  ),
                ),
                SizedBox(height: size.height * 0.018),
                Text(
                  'As a member, you can participate in URCS activities, '
                  'connect with other members, contribute your ideas and '
                  'skills, and support humanitarian action in your '
                  'community and across Uganda.',
                  style: TextStyle(
                    fontSize: isSmallScreen ? 13 : 14,
                    color: Colors.grey[700],
                    height: 1.6,
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE31E24).withOpacity(0.06),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color(0xFFE31E24).withOpacity(0.2),
                    ),
                  ),
                  child: Text(
                    'Membership is about belonging, participation and '
                    'contributing to the strength of the Society.',
                    style: TextStyle(
                      fontSize: isSmallScreen ? 13 : 14,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFFB01519),
                      height: 1.5,
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.035),

                /// --------------------------------------------------
                /// CALL TO ACTION
                /// --------------------------------------------------
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFE31E24), Color(0xFFB01519)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFE31E24).withOpacity(0.3),
                        blurRadius: 14,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Ready to join?",
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: isSmallScreen ? 17 : 19,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Register as a URCS member and become part of the "
                        "Red Cross family.",
                        style: TextStyle(
                          fontSize: isSmallScreen ? 13 : 14,
                          color: Colors.white.withOpacity(0.9),
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 18),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () =>
                              _openMemberRegistrationUrl(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.how_to_reg,
                                color: const Color(0xFFE31E24),
                                size: isSmallScreen ? 18 : 20,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                "Register as a Member",
                                style: TextStyle(
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w700,
                                  fontSize: isSmallScreen ? 14 : 15,
                                  color: const Color(0xFFE31E24),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

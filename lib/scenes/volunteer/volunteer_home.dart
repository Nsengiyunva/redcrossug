import 'package:flutter/material.dart';
import 'package:redcross/utils/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class VolunteerHome extends StatelessWidget {
  const VolunteerHome({super.key});

  static const String _vmsLoginUrl = 'https://vms.redcrossug.org/login/';

  static const List<_VolunteerReason> _reasons = [
    _VolunteerReason(
      icon: Icons.volunteer_activism,
      text: 'Serve and support people in need.',
    ),
    _VolunteerReason(
      icon: Icons.school,
      text: 'Develop practical skills and experience.',
    ),
    _VolunteerReason(
      icon: Icons.groups,
      text: 'Take part in humanitarian and community activities.',
    ),
    _VolunteerReason(
      icon: Icons.emergency,
      text: 'Support your community during emergencies and disasters.',
    ),
    _VolunteerReason(
      icon: Icons.diversity_3,
      text: 'Connect with other volunteers and be part of the Red Cross '
          'family.',
    ),
  ];

  Future<void> _openVmsLogin(BuildContext context) async {
    final Uri uri = Uri.parse(_vmsLoginUrl);
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Could not open the volunteer registration '
                  'page.')),
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
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        title: const Text(""),
        leading: const BackButton(),
        elevation: 0,
        backgroundColor: AppColors.bgColor,
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
                        Icons.volunteer_activism,
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
                            "Volunteers",
                            style: TextStyle(
                              fontFamily: "Inter",
                              fontSize: isSmallScreen ? 24 : 28,
                              fontWeight: FontWeight.w700,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Serve. Support. Make a difference.",
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
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
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
                  child: Text(
                    "URCS volunteers serve voluntarily and in accordance "
                    "with the Fundamental Principles of the International "
                    "Red Cross and Red Crescent Movement. Volunteers may "
                    "support activities in their communities, branches and "
                    "across the country, depending on their interests, "
                    "skills and the needs of the Society.",
                    style: TextStyle(
                      fontSize: isSmallScreen ? 13 : 14,
                      color: Colors.red.shade900,
                      fontWeight: FontWeight.w500,
                      height: 1.6,
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.035),

                /// --------------------------------------------------
                /// WHY VOLUNTEER
                /// --------------------------------------------------
                Text(
                  "Why volunteer with URCS?",
                  style: TextStyle(
                    fontFamily: "Inter",
                    fontSize: isSmallScreen ? 17 : 19,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: size.height * 0.018),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
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
                    children: [
                      for (int i = 0; i < _reasons.length; i++) ...[
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 10,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.red.shade50,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Icon(
                                  _reasons[i].icon,
                                  color: Colors.red.shade700,
                                  size: isSmallScreen ? 18 : 20,
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Text(
                                  _reasons[i].text,
                                  style: TextStyle(
                                    fontSize: isSmallScreen ? 13 : 14,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w500,
                                    height: 1.4,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (i != _reasons.length - 1)
                          Divider(
                            height: 1,
                            thickness: 1,
                            color: Colors.grey.shade100,
                            indent: 10,
                            endIndent: 10,
                          ),
                      ],
                    ],
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
                    color: AppColors.primaryRedColor,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryRedColor.withOpacity(0.3),
                        blurRadius: 14,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Ready to make a difference?",
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: isSmallScreen ? 17 : 19,
                          fontWeight: FontWeight.w700,
                          color: AppColors.whiteColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Register as a URCS volunteer and join a community "
                        "of people committed to helping others.",
                        style: TextStyle(
                          fontSize: isSmallScreen ? 13 : 14,
                          color: AppColors.whiteColor.withOpacity(0.9),
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 18),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => _openVmsLogin(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.whiteColor,
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
                                color: AppColors.primaryRedColor,
                                size: isSmallScreen ? 18 : 20,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                "Register as a Volunteer",
                                style: TextStyle(
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w700,
                                  fontSize: isSmallScreen ? 14 : 15,
                                  color: AppColors.primaryRedColor,
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

class _VolunteerReason {
  final IconData icon;
  final String text;

  const _VolunteerReason({required this.icon, required this.text});
}

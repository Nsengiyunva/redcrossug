import 'package:flutter/material.dart';
import 'package:redcross/utils/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class TrainingHome extends StatelessWidget {
  const TrainingHome({super.key});

  static const String _firstAidInAfricaPlayStoreUrl =
      'https://play.google.com/store/search?q=First%20Aid%20in%20Africa&c=apps&hl=en';

  Future<void> _openFirstAidInAfrica(BuildContext context) async {
    final Uri uri = Uri.parse(_firstAidInAfricaPlayStoreUrl);
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open the Play Store link.')),
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

  /// A single feature row: a tinted icon badge, a bold title, and a
  /// supporting line — all inside a soft white card.
  Widget _featureCard({
    required IconData icon,
    required Color accentColor,
    required String title,
    required String description,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(11),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: accentColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(11),
            ),
            alignment: Alignment.center,
            child: Icon(icon, color: accentColor, size: 19),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                    color: AppColors.blackColor,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: const TextStyle(
                    fontFamily: "Inter",
                    fontSize: 12,
                    height: 1.35,
                    color: AppColors.blackColorC,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        title: const Text(
          "First Aid",
          style: TextStyle(
            fontFamily: "Inter",
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: AppColors.blackColor,
          ),
        ),
        leading: const BackButton(),
        elevation: 0,
        backgroundColor: AppColors.bgColor,
        surfaceTintColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero banner — same copy as before, now framed as a compact
            // gradient card. Icon sits beside the title instead of above
            // it, and the supporting paragraph is a touch smaller, so the
            // whole card takes noticeably less vertical space.
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                gradient: LinearGradient(
                  colors: [AppColors.primaryRedColor, AppColors.redColorA],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryRedColor.withOpacity(0.30),
                    blurRadius: 14,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.18),
                          borderRadius: BorderRadius.circular(11),
                        ),
                        alignment: Alignment.center,
                        child: const Text('🚨', style: TextStyle(fontSize: 17)),
                      ),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Text(
                          'Empower Yourself to Save Lives with First Aid',
                          style: TextStyle(
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w700,
                            // fontStyle: FontStyle.italic,
                            fontSize: 16.5,
                            height: 1.25,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Accidents can happen anywhere, anytime. By learning '
                    'first aid, you can be the difference between life and '
                    'death during a medical emergency.',
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 12.5,
                      height: 1.4,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            const Text(
              "I highly recommend downloading the First Aid in Africa "
              "app—it's free, easy to use, and packed with critical "
              "emergency tools:",
              style: TextStyle(
                fontFamily: "Inter",
                fontSize: 13,
                height: 1.4,
                color: AppColors.blackColorC,
              ),
            ),

            const SizedBox(height: 12),

            _featureCard(
              icon: Icons.medical_information_rounded,
              accentColor: AppColors.blueColorA,
              title: 'Step-by-Step Guides',
              description: 'Clear instructions to walk you through medical '
                  'emergencies.',
            ),
            _featureCard(
              icon: Icons.phone_in_talk_rounded,
              accentColor: AppColors.deepGreenA,
              title: 'Toll-Free Numbers',
              description: 'Immediate access to Ambulance, Police, and Fire '
                  'services.',
            ),
            _featureCard(
              icon: Icons.psychology_alt_rounded,
              accentColor: AppColors.deepYellowA,
              title: 'Interactive First Aid Topics and Quizzes',
              description: 'Learn life-saving basics, test your knowledge and '
                  'book for in class one day practical session.',
            ),

            const SizedBox(height: 4),

            // CTA card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.redColorB, width: 1.2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Download the App Today:',
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: AppColors.blackColor,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => _openFirstAidInAfrica(context),
                      borderRadius: BorderRadius.circular(14),
                      child: Ink(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 13),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColors.primaryRedColor,
                              AppColors.redColorA,
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              color:
                                  AppColors.primaryRedColor.withOpacity(0.28),
                              blurRadius: 12,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.file_download_rounded,
                                color: Colors.white, size: 20),
                            SizedBox(width: 8),
                            Text(
                              'Download First Aid in Africa',
                              style: TextStyle(
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w700,
                                fontSize: 14.5,
                                color: Colors.white,
                              ),
                            ),
                          ],
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

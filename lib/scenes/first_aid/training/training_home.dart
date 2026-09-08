import 'package:flutter/material.dart';
import 'package:redcross/scenes/widgets/red_btn.dart';
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
          const SnackBar(
              content: Text('Could not open the Play Store link.')),
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

  Widget _bulletItem(String emoji, String boldPart, String rest) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 10),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontFamily: "Inter",
                  fontSize: 14,
                  height: 1.5,
                  color: AppColors.blackColorC,
                ),
                children: [
                  TextSpan(
                    text: boldPart,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  TextSpan(text: rest),
                ],
              ),
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
          title: const Text("Request Training",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: AppColors.blackColor,
              )),
          leading: const BackButton() // Back button added here
          ),
      body: SingleChildScrollView(
          child: Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 30.0),
              padding:
                  const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(
                          text: 'Empower Yourself to Save Lives with '
                              'First Aid ',
                          style: TextStyle(
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.italic,
                            fontSize: 17,
                            color: AppColors.blackColor,
                          ),
                        ),
                        const TextSpan(text: '🚨'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    'Accidents can happen anywhere, anytime. By learning '
                    'first aid, you can be the difference between life and '
                    'death during a medical emergency.',
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 14,
                      height: 1.5,
                      color: AppColors.blackColorC,
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    'I highly recommend downloading the First Aid in '
                    'Africa app—it\'s free, easy to use, and packed with '
                    'critical emergency tools:',
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 14,
                      height: 1.5,
                      color: AppColors.blackColorC,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _bulletItem(
                    '🩺',
                    'Step-by-Step Guides: ',
                    'Clear instructions to walk you through medical '
                        'emergencies.',
                  ),
                  _bulletItem(
                    '📞',
                    'Toll-Free Numbers: ',
                    'Immediate access to Ambulance, Police, and Fire '
                        'services.',
                  ),
                  _bulletItem(
                    '🧠',
                    'Interactive First aid Topics and Quizzes: ',
                    'Learn life-saving basics, test your knowledge and '
                        'book for in class one day practical session.',
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Download the App Today:',
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      color: AppColors.blackColor,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    '🌐 Website: Scan the QR code or get direct links at '
                    'redcrossug.org',
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 14,
                      height: 1.5,
                      color: AppColors.blackColorC,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Download our App \'First Aid in Africa\' today!',
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: AppColors.blackColorC,
                    ),
                  ),
                  const SizedBox(height: 24),
                  RedBtn(
                    label: 'Download First Aid in Africa',
                    onPressed: () => _openFirstAidInAfrica(context),
                  ),
                ],
              ))),
    );
  }
}

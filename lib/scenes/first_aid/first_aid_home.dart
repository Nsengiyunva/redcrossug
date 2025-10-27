import 'package:flutter/material.dart';
import 'package:redcross/scenes/first_aid/first_aid_emergencies.dart';
import 'package:redcross/scenes/widgets/icon_card.dart';
import 'package:redcross/scenes/widgets/red_btn.dart';
import 'package:redcross/utils/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class FirstAidHome extends StatefulWidget {
  const FirstAidHome({super.key});

  @override
  State<FirstAidHome> createState() => _FirstAidHomeState();
}

class _FirstAidHomeState extends State<FirstAidHome> {
  final _phoneController = TextEditingController();
  final _msgController = TextEditingController(text: "Hello from Flutter!");

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

      // Delay a tiny bit to ensure platform channel ready
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
              content: Text('Could not open WhatsApp. Is it installed?')),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        title: const Text(""),
        leading: const BackButton(),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 30.0),
          padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "First Aid",
                style: TextStyle(
                  fontFamily: "Inter",
                  fontSize: 26.33,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 30),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconCard(icon_name: 'add', label: "First Aid Guide"),
                  IconCard(icon_name: 'hospital', label: "Request Training"),
                ],
              ),
              const SizedBox(height: 20),
              RedBtn(
                label: 'Call for Emergency Services',
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const FirstAidEmergencies(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 30),
              Center(
                  child: TextButton.icon(
                icon: const Icon(Icons.chat, color: AppColors.deepGreenA),
                label: const Text(
                  'Talk to Red Cross Society',
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: TextButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  backgroundColor: Colors.green.withOpacity(0.1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  openWhatsApp(
                    phone: "256773917523",
                    message: "Hey, Hello Red Cross Society",
                  );
                },
              )),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:redcross/utils/colors.dart';
import 'package:url_launcher/url_launcher.dart';

/// Opens the phone dialer for [dialNumber]. No canLaunchUrl gate — see the
/// note in default_home.dart's _openAboutUsUrl.
Future<void> dialNumber(BuildContext context, String number) async {
  final uri = Uri(scheme: 'tel', path: number);
  try {
    final launched = await launchUrl(uri);
    if (!launched && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not open dialer for $number.')),
      );
    }
  } catch (e) {
    if (context.mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }
}

/// Bottom sheet showing a single contact (team / hotline) with a big
/// "Call" button and an optional secondary action.
Future<void> showContactSheet(
  BuildContext context, {
  required IconData icon,
  required String title,
  required String subtitle,
  required String numberLabel,
  required String numberDisplay,
  required String numberDial,
  String? badge,
  String? secondaryLabel,
  VoidCallback? onSecondary,
}) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: Colors.white,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (sheetContext) => SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.redColorD,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child:
                      Icon(icon, color: AppColors.primaryRedColor, size: 26),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontFamily: "Inter",
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: AppColors.blackColorB,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontFamily: "Inter",
                          fontSize: 13,
                          color: AppColors.greyColorB,
                          height: 1.35,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.bgColor,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.greyColorH),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          numberLabel,
                          style: const TextStyle(
                            fontFamily: "Inter",
                            fontSize: 12,
                            color: AppColors.greyColorC,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          numberDisplay,
                          style: const TextStyle(
                            fontFamily: "Inter",
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: AppColors.blackColorB,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (badge != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF00A86B).withOpacity(0.12),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        badge,
                        style: const TextStyle(
                          fontFamily: "Inter",
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF00875A),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryRedColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              icon: const Icon(Icons.call_rounded),
              label: Text(
                'Call $numberDisplay',
                style: const TextStyle(
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
              onPressed: () => dialNumber(context, numberDial),
            ),
            if (secondaryLabel != null && onSecondary != null) ...[
              const SizedBox(height: 8),
              TextButton(
                onPressed: () {
                  Navigator.of(sheetContext).pop();
                  onSecondary();
                },
                child: Text(
                  secondaryLabel,
                  style: const TextStyle(
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w600,
                    color: AppColors.greyColorB,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    ),
  );
}

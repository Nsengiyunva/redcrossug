import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:redcross/controllers/donations_controller.dart';
import 'package:redcross/utils/colors.dart';

/// Turns a raw campaign map from the API into display strings, tolerating
/// missing or differently-shaped fields.
class CampaignText {
  static String name(Map<String, dynamic> c) =>
      (c['name'] ?? c['title'] ?? 'Blood donation campaign').toString();

  static String location(Map<String, dynamic> c) {
    final locs = c['locations'];
    if (locs is List && locs.isNotEmpty && locs.first is Map) {
      final l = locs.first as Map;
      final parts = [l['location'], l['district'], l['region']]
          .where((p) => p != null && p.toString().trim().isNotEmpty)
          .map((p) => p.toString().trim())
          .toList();
      if (parts.isNotEmpty) {
        final more = locs.length > 1 ? '  +${locs.length - 1} more' : '';
        return parts.join(', ') + more;
      }
    }
    final flat = c['location'] ?? c['venue'] ?? c['address'];
    return flat?.toString() ?? 'Location to be announced';
  }

  static String date(Map<String, dynamic> c) {
    final start = DateTime.tryParse('${c['start_date'] ?? ''}');
    final end = DateTime.tryParse('${c['end_date'] ?? ''}');
    if (start == null) return 'Date to be announced';
    final f = DateFormat('EEE, d MMM yyyy');
    if (end == null || DateUtils.isSameDay(start, end)) return f.format(start);
    if (start.year == end.year) {
      return '${DateFormat('d MMM').format(start)} – ${f.format(end)}';
    }
    return '${f.format(start)} – ${f.format(end)}';
  }

  /// "10:00 AM – 5:00 PM" when the API provides times, otherwise null.
  static String? time(Map<String, dynamic> c) {
    String? fmt(dynamic v) {
      if (v == null || v.toString().isEmpty) return null;
      final s = v.toString();
      final dt = DateTime.tryParse(s) ?? DateTime.tryParse('1970-01-01 $s');
      return dt == null ? s : DateFormat('h:mm a').format(dt);
    }

    final a = fmt(c['start_time']);
    final b = fmt(c['end_time']);
    if (a != null && b != null) return '$a – $b';
    return a ?? b;
  }
}

class _StatusStyle {
  final String label;
  final Color bg;
  final Color fg;
  const _StatusStyle(this.label, this.bg, this.fg);

  static _StatusStyle of(String tab) {
    switch (tab) {
      case CampaignTab.active:
        return const _StatusStyle(
            'Active', AppColors.greenColorB, Color(0xFF0E8A1B));
      case CampaignTab.completed:
        return const _StatusStyle(
            'Completed', AppColors.greyColorA, AppColors.greyColorB);
      default:
        return const _StatusStyle(
            'Upcoming', AppColors.yellowColorB, AppColors.deepYellowA);
    }
  }
}

class BloodDonationListItem extends StatelessWidget {
  final String name;
  final String location;
  final String date;
  final String? time;

  /// One of [CampaignTab] values; shows a small status chip when set.
  final String? status;
  final VoidCallback onPressed;

  const BloodDonationListItem({
    super.key,
    required this.name,
    required this.date,
    this.time,
    required this.location,
    this.status,
    required this.onPressed,
  });

  factory BloodDonationListItem.fromCampaign(
    Map<String, dynamic> campaign, {
    Key? key,
    required VoidCallback onPressed,
  }) {
    return BloodDonationListItem(
      key: key,
      name: CampaignText.name(campaign),
      location: CampaignText.location(campaign),
      date: CampaignText.date(campaign),
      time: CampaignText.time(campaign),
      status: DonationsController.tabFor(campaign),
      onPressed: onPressed,
    );
  }

  @override
  Widget build(BuildContext context) {
    final style = status == null ? null : _StatusStyle.of(status!);
    final when = time == null ? date : '$date · $time';

    return Material(
      color: AppColors.whiteColor,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFEEF0F4)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: AppColors.redColorD,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.water_drop_rounded,
                    size: 26, color: AppColors.primaryRedColor),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              height: 1.3,
                              color: AppColors.blackColorX,
                            ),
                          ),
                        ),
                        if (style != null) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: style.bg,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              style.label,
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 10.5,
                                fontWeight: FontWeight.w600,
                                color: style.fg,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 6),
                    _MetaRow(
                      icon: Icons.location_on_outlined,
                      text: location,
                      color: AppColors.greyColorB,
                    ),
                    const SizedBox(height: 4),
                    _MetaRow(
                      icon: Icons.schedule_rounded,
                      text: when,
                      color: AppColors.primaryRedColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MetaRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;

  const _MetaRow({required this.icon, required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 1),
          child: Icon(icon, size: 14, color: color),
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            text,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 12,
              height: 1.3,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}

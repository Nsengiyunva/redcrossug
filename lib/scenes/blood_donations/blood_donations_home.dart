import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redcross/controllers/donations_controller.dart';
import 'package:redcross/scenes/blood_donations/appointments.dart';
import 'package:redcross/scenes/blood_donations/blood_banks_list.dart';
import 'package:redcross/scenes/blood_donations/blood_donation_faq_screen.dart';
import 'package:redcross/scenes/blood_donations/blood_drive_requests_list.dart';
import 'package:redcross/scenes/blood_donations/blood_eligibility.dart';
import 'package:redcross/scenes/blood_donations/donation_campaign_details.dart';
import 'package:redcross/scenes/blood_donations/donation_campaign_list.dart';
import 'package:redcross/scenes/blood_donations/donation_register.dart';
import 'package:redcross/scenes/donations/donation_history.dart';
import 'package:redcross/scenes/widgets/blood_donation_list_item.dart';
import 'package:redcross/utils/colors.dart';

class BloodDonationsHome extends StatelessWidget {
  const BloodDonationsHome({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blood Donation',
      // Match the app-wide theme (Inter + Red Cross red). This used to be
      // 'SF Pro', which isn't bundled, so this tab rendered in a different
      // font from the rest of the app.
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Inter',
        scaffoldBackgroundColor: AppColors.bgColor,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryRedColor,
          primary: AppColors.primaryRedColor,
        ),
      ),
      home: const BloodDonationHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}


// ---------------------------------------------------------------------------
// Design tokens for this screen. Fixed sizes (instead of screenWidth * x) so
// text stays a sensible size on large phones and respects system text scale.
// ---------------------------------------------------------------------------
const _ink = Color(0xFF1F2430);
const _muted = Color(0xFF6B7280);
const _border = Color(0xFFEEF0F4);
const _tint = Color(0xFFFFEEEE);

class _Action {
  final String label;
  final IconData icon;
  final WidgetBuilder builder;
  const _Action(this.label, this.icon, this.builder);
}

class BloodDonationHome extends StatelessWidget {
  const BloodDonationHome({super.key});

  static final List<_Action> _actions = [
    _Action('Eligibility', Icons.fact_check_outlined,
        (_) => const BloodEligibility()),
    _Action('Register as Donor', Icons.person_add_alt_1_outlined,
        (_) => const DonationRegister()),
    _Action('Blood Drive Request', Icons.event_note_outlined,
        (_) => const BloodDriveRequestsList()),
    _Action('Blood Banks', Icons.local_hospital_outlined,
        (_) => const BloodBanksList()),
    _Action('My Appointments', Icons.event_available_outlined,
        (_) => const Appointments()),
    _Action('FAQs', Icons.help_outline_rounded,
        (_) => const BloodDonationFaqScreen()),
  ];

  void _open(BuildContext context, WidgetBuilder builder) {
    Navigator.push(context, MaterialPageRoute(builder: builder));
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DonationsController());
    // Covers the case where the controller was created before sign-in.
    // Deferred so observables aren't changed in the middle of a build.
    WidgetsBinding.instance
        .addPostFrameCallback((_) => controller.ensureCampaignsLoaded());

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: SafeArea(
        child: RefreshIndicator(
          color: AppColors.primaryRedColor,
          onRefresh: controller.fetchCampaignList,
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            children: [
              const Text(
                'Blood Donation',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: _ink,
                  letterSpacing: -0.3,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Give blood, save lives.',
                style: TextStyle(fontSize: 13, color: _muted),
              ),
              const SizedBox(height: 16),

              _HeroCard(
                onTap: () =>
                    _open(context, (_) => const DonationCampaignList()),
              ),
              const SizedBox(height: 20),

              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: _actions.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.98,
                ),
                itemBuilder: (context, i) {
                  final a = _actions[i];
                  return _ActionTile(
                    label: a.label,
                    icon: a.icon,
                    onTap: () => _open(context, a.builder),
                  );
                },
              ),
              const SizedBox(height: 24),

              _SectionHeader(
                title: 'Donation Campaigns',
                onSeeAll: () =>
                    _open(context, (_) => const DonationCampaignList()),
              ),
              const SizedBox(height: 10),
              Obx(() {
                final featured = controller.featuredCampaigns;
                if (controller.isLoading.value &&
                    controller.campaign_list.isEmpty) {
                  return const _InfoCard(
                    child: SizedBox(
                      height: 22,
                      width: 22,
                      child: CircularProgressIndicator(
                          strokeWidth: 2.4,
                          color: AppColors.primaryRedColor),
                    ),
                  );
                }
                if (controller.campaignError.value.isNotEmpty &&
                    controller.campaign_list.isEmpty) {
                  return _InfoCard(
                    child: Column(
                      children: [
                        Text(
                          controller.campaignError.value,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 13, color: _muted),
                        ),
                        TextButton(
                          onPressed: controller.fetchCampaignList,
                          child: const Text('Try again',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryRedColor)),
                        ),
                      ],
                    ),
                  );
                }
                if (featured.isEmpty) {
                  return const _InfoCard(
                    child: Text(
                      'No upcoming campaigns right now. Check back soon.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 13, color: _muted),
                    ),
                  );
                }
                return Column(
                  children: [
                    for (final item in featured.take(3)) ...[
                      BloodDonationListItem.fromCampaign(
                        item,
                        onPressed: () => _open(
                          context,
                          (_) => DonationCampaignDetails(campaign: item),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ],
                );
              }),
              const SizedBox(height: 14),

              _SectionHeader(
                title: 'Donation History',
                onSeeAll: () => _open(context, (_) => const DonationHistory()),
              ),
              const SizedBox(height: 10),
              // TODO: replace with the user's real blood donation history.
              const _HistoryItem(
                  title: 'NITA-U Staff Donation', date: 'May 10, 2025', units: 1),
              const SizedBox(height: 10),
              const _HistoryItem(
                  title: 'NITA-U Staff Donation', date: 'May 10, 2025', units: 1),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeroCard extends StatelessWidget {
  final VoidCallback onTap;
  const _HeroCard({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Ink(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: const LinearGradient(
              colors: [Color(0xFFED1C24), Color(0xFFC8102E)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryRedColor.withOpacity(0.25),
                blurRadius: 14,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.18),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.search_rounded,
                    color: Colors.white, size: 24),
              ),
              const SizedBox(width: 14),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Find Donation Campaigns',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'Blood drives happening near you',
                      style: TextStyle(color: Colors.white70, fontSize: 12.5),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded,
                  color: Colors.white, size: 26),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _ActionTile(
      {required this.label, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: _border),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: const BoxDecoration(
                  color: _tint,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: AppColors.primaryRedColor, size: 21),
              ),
              const SizedBox(height: 8),
              Text(
                label,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  height: 1.25,
                  color: _ink,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback onSeeAll;
  const _SectionHeader({required this.title, required this.onSeeAll});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: _ink,
            ),
          ),
        ),
        GestureDetector(
          onTap: onSeeAll,
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 2),
            child: Text(
              'See all',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryRedColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _InfoCard extends StatelessWidget {
  final Widget child;
  const _InfoCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _border),
      ),
      child: child,
    );
  }
}

class _HistoryItem extends StatelessWidget {
  final String title;
  final String date;
  final int units;

  const _HistoryItem(
      {required this.title, required this.date, required this.units});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _border),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: _tint,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.water_drop_rounded,
                color: AppColors.primaryRedColor, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: _ink,
                  ),
                ),
                const SizedBox(height: 2),
                Text(date,
                    style: const TextStyle(fontSize: 12, color: _muted)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                units.toString().padLeft(2, '0'),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: _ink,
                ),
              ),
              Text(units == 1 ? 'Unit' : 'Units',
                  style: const TextStyle(fontSize: 11.5, color: _muted)),
            ],
          ),
        ],
      ),
    );
  }
}

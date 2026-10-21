import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redcross/controllers/donations_controller.dart';
import 'package:redcross/scenes/blood_donations/donation_campaign_details.dart';
import 'package:redcross/scenes/widgets/back_button_text.dart';
import 'package:redcross/scenes/widgets/blood_donation_list_item.dart';
import 'package:redcross/utils/colors.dart';

class DonationCampaignList extends StatefulWidget {
  const DonationCampaignList({super.key});

  @override
  State<DonationCampaignList> createState() => _DonationCampaignListState();
}

class _DonationCampaignListState extends State<DonationCampaignList> {
  // Get.put returns the existing instance if one was already created
  // elsewhere (e.g. by DonationCategories), in which case onInit will not run
  // again, so we explicitly make sure the campaigns are loaded.
  final DonationsController c = Get.put(DonationsController());

  static const _tabs = <List<String>>[
    [CampaignTab.upcoming, 'Upcoming'],
    [CampaignTab.active, 'Active'],
    [CampaignTab.completed, 'Completed'],
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => c.ensureCampaignsLoaded());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        title: const BackButtonText(),
        backgroundColor: AppColors.bgColor,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        titleSpacing: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 4, 16, 12),
            child: Text(
              'Donation Campaigns',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppColors.blackColorX,
              ),
            ),
          ),
          // Segmented tabs with counts
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Obx(() {
              final selected = c.selectedTab.value;
              // touch the list so counts rebuild when data arrives
              c.campaign_list.length;
              return Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: const Color(0xFFECEFF4),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: _tabs.map((t) {
                    final active = selected == t[0];
                    final count = c.countFor(t[0]);
                    return Expanded(
                      child: GestureDetector(
                        onTap: () => c.setTab(t[0]),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 180),
                          padding: const EdgeInsets.symmetric(vertical: 9),
                          decoration: BoxDecoration(
                            color: active ? Colors.white : Colors.transparent,
                            borderRadius: BorderRadius.circular(9),
                            boxShadow: active
                                ? [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.06),
                                      blurRadius: 6,
                                      offset: const Offset(0, 1),
                                    )
                                  ]
                                : null,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            count > 0 ? '${t[1]} ($count)' : t[1],
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 13,
                              fontWeight:
                                  active ? FontWeight.w600 : FontWeight.w500,
                              color: active
                                  ? AppColors.primaryRedColor
                                  : AppColors.greyColorB,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              );
            }),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Obx(() {
              final loading = c.isLoading.value;
              final error = c.campaignError.value;
              final items = c.campaignsFor(c.selectedTab.value);

              if (loading && c.campaign_list.isEmpty) {
                return const Center(
                  child: CircularProgressIndicator(
                      color: AppColors.primaryRedColor),
                );
              }

              if (error.isNotEmpty && c.campaign_list.isEmpty) {
                return _EmptyState(
                  icon: Icons.cloud_off_rounded,
                  title: 'Couldn\'t load campaigns',
                  message: error,
                  onRetry: c.fetchCampaignList,
                );
              }

              return RefreshIndicator(
                color: AppColors.primaryRedColor,
                onRefresh: c.fetchCampaignList,
                child: items.isEmpty
                    ? ListView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.55,
                            child: _EmptyState(
                              icon: Icons.event_busy_rounded,
                              title: 'No campaigns here yet',
                              message: c.campaign_list.isEmpty
                                  ? 'There are no blood donation campaigns at the moment. Pull down to refresh.'
                                  : 'Nothing in this tab. Check the other tabs.',
                            ),
                          ),
                        ],
                      )
                    : ListView.separated(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                        itemCount: items.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 10),
                        itemBuilder: (context, index) {
                          final item = items[index];
                          return BloodDonationListItem.fromCampaign(
                            item,
                            onPressed: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) =>
                                    DonationCampaignDetails(campaign: item),
                              ),
                            ),
                          );
                        },
                      ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;
  final Future<void> Function()? onRetry;

  const _EmptyState({
    required this.icon,
    required this.title,
    required this.message,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: const BoxDecoration(
                color: AppColors.redColorD,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 30, color: AppColors.primaryRedColor),
            ),
            const SizedBox(height: 14),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: AppColors.blackColorX,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 13,
                height: 1.4,
                color: AppColors.greyColorB,
              ),
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh_rounded, size: 18),
                label: const Text('Try again'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primaryRedColor,
                  side: const BorderSide(color: AppColors.primaryRedColor),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  textStyle: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 13,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

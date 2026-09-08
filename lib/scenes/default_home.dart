import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redcross/models/user.dart';
import 'package:redcross/controllers/bulletins_controller.dart';
import 'package:redcross/scenes/ambulances/ambulance_home.dart';
import 'package:redcross/scenes/blood_donations/blood_donations_home.dart';
import 'package:redcross/scenes/bulletins/bulletins_list.dart';
import 'package:redcross/scenes/bulletins/bulletin_detail.dart';
import 'package:redcross/scenes/chat/floating_chat_button.dart';
import 'package:redcross/scenes/disasters/disaster_list.dart';
import 'package:redcross/scenes/first_aid/first_aid_home.dart';
import 'package:redcross/scenes/memberships/membership_card.dart';
import 'package:redcross/scenes/volunteer/volunteer_home.dart';
import 'package:redcross/utils/storage_service.dart';

class DefaultHome extends StatefulWidget {
  const DefaultHome({super.key});

  @override
  State<DefaultHome> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<DefaultHome> {
  var time = StorageService.displayWhatTime();
  User? loggedInUser;
  final int _selectedIndex = 0;
  final BulletinsController bulletinsController =
      Get.put(BulletinsController());

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  void loadUser() async {
    loggedInUser = await StorageService.getUser();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 600;

    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isTablet ? 32.0 : 20.0,
                  vertical: 16.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(),
                    SizedBox(height: isTablet ? 40 : 30),
                    _buildServiceGrid(isTablet, context),
                    SizedBox(height: isTablet ? 40 : 30),
                    _buildBulletinCard(),
                    const SizedBox(height: 16),
                    _buildFullWidthActionButton(
                      icon: Icons.campaign_outlined,
                      label: 'View All Bulletins',
                      subtitle: 'Browse all news and announcements',
                      color: const Color(0xFFFFF3E0),
                      iconColor: const Color(0xFFFF6F00),
                      textColor: const Color(0xFF2C2C2C),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => const BulletinsList()),
                        );
                      },
                    ),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),
          ),
          const FloatingChatButton(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                time,
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                loggedInUser?.name ?? "",
                style: const TextStyle(
                  fontSize: 28,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2C2C2C),
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF2C3E50), Color(0xFF34495E)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF2C3E50).withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Icon(
            Icons.notifications_outlined,
            color: Colors.white,
            size: 24,
          ),
        ),
      ],
    );
  }

  Widget _buildServiceGrid(bool isTablet, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeroCard(
          icon: Icons.water_drop,
          label: 'Blood Donation',
          subtitle: 'Save lives by donating blood',
          gradient: const LinearGradient(
            colors: [Color(0xFFE31E24), Color(0xFFB71C1C)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => const BloodDonationsHome()),
            );
          },
        ),

        const SizedBox(height: 24),

        // Section Title
        const Text(
          'Quick Actions',
          style: TextStyle(
            fontSize: 20,
            fontFamily: "Inter",
            fontWeight: FontWeight.bold,
            color: Color(0xFF2C2C2C),
          ),
        ),

        const SizedBox(height: 16),

        // Secondary Services Grid
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: isTablet ? 3 : 2,
          crossAxisSpacing: isTablet ? 20.0 : 16.0,
          mainAxisSpacing: isTablet ? 20.0 : 16.0,
          childAspectRatio: isTablet ? 1.3 : 1.15,
          children: [
            _buildServiceCard(
              icon: Icons.medical_services_outlined,
              label: 'First Aid',
              color: const Color(0xFFFF5252),
              iconColor: Colors.white,
              textColor: Colors.white,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const FirstAidHome()),
                );
              },
            ),
            _buildServiceCard(
              icon: Icons.local_hospital_outlined,
              label: 'Ambulance',
              color: Colors.white,
              iconColor: const Color(0xFFE31E24),
              textColor: const Color(0xFF2C2C2C),
              hasBorder: true,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AmbulanceHome()),
                );
              },
            ),
            _buildServiceCard(
              icon: Icons.warning_amber_rounded,
              label: 'Disasters',
              color: const Color(0xFFFFF3E0),
              iconColor: const Color(0xFFFF6F00),
              textColor: const Color(0xFF2C2C2C),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => DisasterList()),
                );
              },
            ),
            _buildServiceCard(
              icon: Icons.card_membership_outlined,
              label: 'Memberships',
              color: const Color(0xFFE8F5E9),
              iconColor: const Color(0xFF2E7D32),
              textColor: const Color(0xFF2C2C2C),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => const MembershipCard()),
                );
              },
            ),
          ],
        ),

        const SizedBox(height: 16),

        // Volunteers - Full width button
        _buildFullWidthActionButton(
          icon: Icons.volunteer_activism_outlined,
          label: 'Become a Volunteer',
          subtitle: 'Make a difference today',
          color: const Color(0xFFF3E5F5),
          iconColor: const Color(0xFF7B1FA2),
          textColor: const Color(0xFF2C2C2C),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const VolunteerHome()),
            );
          },
        ),
      ],
    );
  }

  Widget _buildFullWidthActionButton({
    required IconData icon,
    required String label,
    required String subtitle,
    required Color color,
    required Color iconColor,
    required Color textColor,
    required VoidCallback onPressed,
  }) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: iconColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    color: iconColor,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        label,
                        style: TextStyle(
                          color: textColor,
                          fontSize: 16,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: TextStyle(
                          color: textColor.withOpacity(0.6),
                          fontSize: 12,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: iconColor,
                  size: 18,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeroCard({
    required IconData icon,
    required String label,
    required String subtitle,
    required Gradient gradient,
    required VoidCallback onPressed,
  }) {
    return Container(
      height: 140,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFE31E24).withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        label,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        subtitle,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 15,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 48,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildServiceCard({
    required IconData icon,
    required String label,
    required Color color,
    required Color iconColor,
    required Color textColor,
    bool hasBorder = false,
    required VoidCallback onPressed,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
        border: hasBorder
            ? Border.all(color: const Color(0xFFE0E0E0), width: 2)
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: iconColor,
                  size: 48,
                ),
                const SizedBox(height: 12),
                Text(
                  label,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 16,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBulletinCard() {
    return Obx(() {
      // Get the first upcoming event or latest bulletin
      final upcomingEvents = bulletinsController.getUpcomingEvents();
      final bulletin = upcomingEvents.isNotEmpty
          ? upcomingEvents.first
          : (bulletinsController.bulletins.isNotEmpty
              ? bulletinsController.bulletins.first
              : null);

      if (bulletin == null) {
        // Show placeholder if no bulletins
        return Container(
          height: 100,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFFF6B9D), Color(0xFFC06C84)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BulletinsList(),
                  ),
                );
              },
              borderRadius: BorderRadius.circular(16),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.campaign_outlined,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'View Bulletins & Updates',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Tap to see latest news',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: 18,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }

      // Show actual bulletin
      return Container(
        height: 100,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFFF6B9D), Color(0xFFC06C84)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BulletinDetail(bulletin: bulletin),
                ),
              );
            },
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.campaign_outlined,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          bulletin.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        if (bulletin.eventStartDate != null)
                          Row(
                            children: [
                              const Icon(
                                Icons.calendar_today,
                                color: Colors.white,
                                size: 12,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                _formatDate(bulletin.eventStartDate!),
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.9),
                                  fontSize: 13,
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          )
                        else if (bulletin.publishedAt != null)
                          Row(
                            children: [
                              const Icon(
                                Icons.access_time,
                                color: Colors.white,
                                size: 12,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                _formatDate(bulletin.publishedAt!),
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.9),
                                  fontSize: 13,
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 18,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = date.difference(now);

    if (diff.inDays == 0) {
      return 'Today';
    } else if (diff.inDays == 1) {
      return 'Tomorrow';
    } else if (diff.inDays > 0 && diff.inDays < 7) {
      return 'In ${diff.inDays} days';
    } else {
      final months = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec'
      ];
      return '${months[date.month - 1]} ${date.day}, ${date.year}';
    }
  }
}

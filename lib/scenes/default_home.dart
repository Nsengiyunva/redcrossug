import 'package:flutter/material.dart';
import 'package:redcross/models/user.dart';
import 'package:redcross/scenes/ambulances/ambulance_home.dart';
import 'package:redcross/scenes/blood_donations/blood_donations_home.dart';
import 'package:redcross/scenes/bulletins/bulletins_list.dart';
import 'package:redcross/scenes/chat/floating_chat_button.dart';
import 'package:redcross/scenes/disasters/disaster_list.dart';
import 'package:redcross/scenes/first_aid/first_aid_home.dart';
import 'package:redcross/scenes/memberships/membership_card.dart';
import 'package:redcross/scenes/volunteer/volunteer_home.dart';
import 'package:redcross/utils/storage_service.dart';
import 'package:url_launcher/url_launcher.dart';

class DefaultHome extends StatefulWidget {
  const DefaultHome({super.key});

  @override
  State<DefaultHome> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<DefaultHome> {
  var time = StorageService.displayWhatTime();
  User? loggedInUser;

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  void loadUser() async {
    loggedInUser = await StorageService.getUser();
    setState(() {});
  }

  Future<void> _openAboutUsUrl(BuildContext context) async {
    final Uri uri = Uri.parse('https://redcrossug.org/');
    try {
      // Go straight to launchUrl instead of gating on canLaunchUrl.
      // On Android 11+ (API 30+), canLaunchUrl reports false for a
      // perfectly valid https:// link unless the app also declares a
      // <queries> block in AndroidManifest.xml — which was missing here,
      // so every tap fell into the "Could not open" branch even though
      // the link itself was fine. launchUrl doesn't need that check.
      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
      if (!launched && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open redcrossug.org.')),
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
    final isTablet = size.width > 600;
    final horizontalPadding = isTablet ? 32.0 : 20.0;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FB),
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                horizontalPadding,
                16.0,
                horizontalPadding,
                90.0, // clears the floating chat button
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 20),
                  _buildAboutUsBanner(context),
                  const SizedBox(height: 26),
                  const Text(
                    'Our Services',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E1E1E),
                      letterSpacing: -0.2,
                    ),
                  ),
                  const SizedBox(height: 14),
                  _buildServiceGrid(context, isTablet),
                  const SizedBox(height: 18),
                  _buildQuickActionButtons(context),
                ],
              ),
            ),
          ),
          const FloatingChatButton(),
        ],
      ),
    );
  }

  /// Greeting row: avatar initial, time-of-day + name, notification bell.
  Widget _buildHeader() {
    final initial = (loggedInUser?.name.isNotEmpty ?? false)
        ? loggedInUser!.name[0].toUpperCase()
        : "U";

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [Color(0xFFE31E24), Color(0xFFB71C1C)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFE31E24).withOpacity(0.35),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Text(
                  initial,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      time,
                      style: TextStyle(
                        fontSize: 13,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[600],
                        letterSpacing: 0.2,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      loggedInUser?.name ?? "",
                      style: const TextStyle(
                        fontSize: 21,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E1E1E),
                        letterSpacing: -0.3,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        Container(
          padding: const EdgeInsets.all(11),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFEDEDF2), width: 1.2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: const Icon(
            Icons.notifications_outlined,
            color: Color(0xFF2C3E50),
            size: 22,
          ),
        ),
      ],
    );
  }

  /// Promo-style banner (mirrors the "Setup Wallet" banner in the
  /// reference design) that links out to redcrossug.org.
  Widget _buildAboutUsBanner(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: const LinearGradient(
          colors: [Color(0xFF2C3E50), Color(0xFF16212C)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2C3E50).withOpacity(0.30),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Learn about the work URCS does\nfor communities across Uganda',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15.5,
              fontFamily: "Inter",
              fontWeight: FontWeight.w600,
              height: 1.35,
            ),
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () => _openAboutUsUrl(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF2C3E50),
                padding:
                    const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 0,
              ),
              child: const Text(
                'About URCS',
                style: TextStyle(
                  fontFamily: "Inter",
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 3-column grid of white, icon-badge service cards — styled after the
  /// reference screenshot: white rounded cards, a soft-tinted icon badge
  /// up top, a bold left-aligned label below, and an optional "NEW" tag.
  ///
  /// Bulletins and Give Feedback have been pulled out of this grid — see
  /// [_buildQuickActionButtons] — so this now only holds the six core
  /// services.
  Widget _buildServiceGrid(BuildContext context, bool isTablet) {
    final services = <_ServiceItem>[
      _ServiceItem(
        icon: Icons.water_drop_rounded,
        label: 'Blood Donation',
        accentColor: const Color(0xFFE31E24),
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const BloodDonationsHome()),
        ),
      ),
      _ServiceItem(
        icon: Icons.medical_services_rounded,
        label: 'First Aid',
        accentColor: const Color(0xFFFF7043),
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const FirstAidHome()),
        ),
      ),
      _ServiceItem(
        icon: Icons.local_hospital_rounded,
        label: 'Ambulance',
        accentColor: const Color(0xFF2C7BE5),
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => AmbulanceHome()),
        ),
      ),
      _ServiceItem(
        icon: Icons.warning_rounded,
        label: 'Disasters',
        accentColor: const Color(0xFFFFA000),
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => DisasterList()),
        ),
      ),
      _ServiceItem(
        icon: Icons.card_membership_rounded,
        label: 'Membership',
        accentColor: const Color(0xFF7C4DFF),
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const MembershipCard()),
        ),
      ),
      _ServiceItem(
        icon: Icons.volunteer_activism_rounded,
        label: 'Volunteers',
        accentColor: const Color(0xFF00BFA5),
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const VolunteerHome()),
        ),
      ),
    ];

    final crossAxisCount = isTablet ? 4 : 3;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: services.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.92,
      ),
      itemBuilder: (context, index) => _buildServiceCard(services[index]),
    );
  }

  Widget _buildServiceCard(_ServiceItem item) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: item.onPressed,
        borderRadius: BorderRadius.circular(20),
        splashColor: item.accentColor.withOpacity(0.12),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 14,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 16, 12, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: item.accentColor.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      alignment: Alignment.center,
                      child: Icon(item.icon, color: item.accentColor, size: 24),
                    ),
                    const Spacer(),
                    Text(
                      item.label,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1E1E1E),
                        height: 1.2,
                        letterSpacing: -0.1,
                      ),
                    ),
                  ],
                ),
              ),
              if (item.isNew)
                Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: const BoxDecoration(
                      color: Color(0xFF00BFA5),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomRight: Radius.circular(14),
                      ),
                    ),
                    child: const Text(
                      'NEW',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 9,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.4,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  /// Bulletins and Give Feedback, rendered as full-width long buttons
  /// stacked below the services grid instead of as grid cards.
  Widget _buildQuickActionButtons(BuildContext context) {
    final actions = <_ServiceItem>[
      _ServiceItem(
        icon: Icons.campaign_rounded,
        label: 'Bulletins',
        accentColor: const Color(0xFFEC407A),
        isNew: true,
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const BulletinsList()),
        ),
      ),
      _ServiceItem(
        icon: Icons.feedback_rounded,
        label: 'Give Feedback',
        accentColor: const Color(0xFF26A69A),
        onPressed: () => _openFeedbackUrl(context),
      ),
    ];

    return Column(
      children: [
        for (int i = 0; i < actions.length; i++) ...[
          _buildLongButton(actions[i]),
          if (i != actions.length - 1) const SizedBox(height: 12),
        ],
      ],
    );
  }

  Widget _buildLongButton(_ServiceItem item) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: item.onPressed,
        borderRadius: BorderRadius.circular(18),
        splashColor: item.accentColor.withOpacity(0.12),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
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
                  color: item.accentColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                alignment: Alignment.center,
                child: Icon(item.icon, color: item.accentColor, size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  item.label,
                  style: const TextStyle(
                    fontSize: 14.5,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1E1E1E),
                    letterSpacing: -0.1,
                  ),
                ),
              ),
              if (item.isNew) ...[
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: const Color(0xFF00BFA5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'NEW',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 9,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.4,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
              ],
              Icon(
                Icons.chevron_right_rounded,
                color: Colors.grey.shade400,
                size: 22,
              ),
            ],
          ),
        ),
      ),
    );
  }

  static const String _feedbackFormUrl = 'https://ee.ifrc.org/x/Nxc7RtB9';

  Future<void> _openFeedbackUrl(BuildContext context) async {
    final Uri uri = Uri.parse(_feedbackFormUrl);
    try {
      // Direct launchUrl call (no canLaunchUrl gate) — see the fix
      // applied to the About URCS / membership / volunteer links.
      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
      if (!launched && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open the feedback form.')),
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
}

class _ServiceItem {
  final IconData icon;
  final String label;
  final Color accentColor;
  final bool isNew;
  final VoidCallback onPressed;

  _ServiceItem({
    required this.icon,
    required this.label,
    required this.accentColor,
    this.isNew = false,
    required this.onPressed,
  });
}

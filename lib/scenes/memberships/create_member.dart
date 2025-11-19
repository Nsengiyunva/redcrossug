import 'package:flutter/material.dart';
import 'package:redcross/models/member_profile.dart';
import 'package:redcross/models/membership.dart';

class CreateMember extends StatefulWidget {
  const CreateMember({super.key});

  @override
  State<CreateMember> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<CreateMember> {
  MemberProfile? _profileData;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    // Simulating API call - replace with actual API endpoint
    await Future.delayed(const Duration(seconds: 1));

    // Mock data - replace with actual API call
    final mockData = {
      "success": true,
      "profile": {
        "membership_id": "URCS-102/M/3768/2024",
        "volunteer_id": "",
        "name": "ZUHURA BABIRYE",
        "surname": "BABIRYE",
        "firstname": "ZUHURA",
        "othername": "KISAKYE",
        "email": "br*******@gmail.com",
        "phone": "******7879",
        "alternative_phone": "",
        "gender": "Female",
        "dob": "2003-02-24",
        "nin": "**********D3HK",
        "identification_type": "National ID",
        "district": "Kampala",
        "member_subcounty": "KAWEMPE",
        "member_parish": "BWAISE II",
        "member_village": "BWAISE",
        "branch": {"id": 61, "name": "Kampala North", "districts": "d-136"},
        "is_member": true,
        "is_volunteer": false,
        "membership_paid": true,
        "membership_active": true,
        "primary_language": "",
        "secondary_language": "",
        "category": "",
        "group_name": null,
        "group_type": null,
        "corporate_entity": null,
        "account_approved_status": "Pending",
        "account_approved": false,
        "account_verified": true
      },
      "memberships": [
        {
          "id": 290,
          "category": "Individual",
          "tier": "Senior",
          "reason": "Registration",
          "reason_verbose": "Registration",
          "start_date": "2024-02-17",
          "end_date": "2025-02-17",
          "fee": "20000.00",
          "active": true,
          "approved": false,
          "approved_on": "2024-02-21T13:11:34.093870+00:00",
          "status": "pending_agreement",
          "payment_status": "payment successful",
          "payment_method": "mobile",
          "payment_ref": "768128582053",
          "order_no": null,
          "group_membership_name": null,
          "is_expired": true,
          "created": "2024-02-17T15:10:10.973706+00:00"
        }
      ],
      "active_membership": {
        "id": 290,
        "category": "Individual",
        "tier": "Senior",
        "start_date": "2024-02-17",
        "end_date": "2025-02-17",
        "active": true,
        "status": "pending_agreement",
        "payment_status": "payment successful",
        "is_expired": true
      }
    };

    setState(() {
      _profileData = MemberProfile.fromJson(mockData);
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white70),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.white70),
            onPressed: () {
              if (_profileData != null) {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => EditMember(
                //       profile: _profileData!.profile,
                //     ),
                //   ),
                // ).then((_) => _loadProfile());
              }
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFED1C24)),
              ),
            )
          : _profileData == null
              ? const Center(
                  child: Text(
                    'Failed to load profile',
                    style: TextStyle(color: Colors.white70),
                  ),
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildProfileHeader(),
                        const SizedBox(height: 24),
                        _buildMembershipStatus(),
                        const SizedBox(height: 24),
                        _buildPersonalInfo(),
                        const SizedBox(height: 24),
                        _buildLocationInfo(),
                        const SizedBox(height: 24),
                        _buildMembershipHistory(),
                      ],
                    ),
                  ),
                ),
    );
  }

  Widget _buildProfileHeader() {
    final profile = _profileData!.profile;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: const Color(0xFFED1C24),
            child: Text(
              profile.firstname.isNotEmpty ? profile.firstname[0] : 'U',
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            profile.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            profile.membershipId,
            style: const TextStyle(
              color: Colors.white54,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildStatusBadge(
                profile.accountVerified ? 'Verified' : 'Unverified',
                profile.accountVerified,
              ),
              const SizedBox(width: 8),
              _buildStatusBadge(
                profile.membershipActive ? 'Active' : 'Inactive',
                profile.membershipActive,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(String label, bool isActive) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isActive
            ? const Color(0xFFED1C24).withOpacity(0.2)
            : Colors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isActive ? const Color(0xFFED1C24) : Colors.grey,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildMembershipStatus() {
    final membership = _profileData!.activeMembership;
    if (membership == null) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'ACTIVE MEMBERSHIP',
            style: TextStyle(
              color: Colors.white54,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 16),
          _buildInfoRow('Category', membership.category),
          _buildInfoRow('Tier', membership.tier),
          _buildInfoRow('Start Date', membership.startDate),
          _buildInfoRow('End Date', membership.endDate),
          _buildInfoRow(
              'Status', membership.status.replaceAll('_', ' ').toUpperCase()),
          if (membership.isExpired)
            Container(
              margin: const EdgeInsets.only(top: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                children: [
                  Icon(Icons.warning_amber_rounded,
                      color: Colors.orange, size: 20),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Your membership has expired. Please renew to continue.',
                      style: TextStyle(color: Colors.orange, fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPersonalInfo() {
    final profile = _profileData!.profile;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'PERSONAL INFORMATION',
            style: TextStyle(
              color: Colors.white54,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 16),
          _buildInfoRow('Full Name',
              '${profile.firstname} ${profile.othername} ${profile.surname}'),
          _buildInfoRow('Email', profile.email),
          _buildInfoRow('Phone', profile.phone),
          if (profile.alternativePhone.isNotEmpty)
            _buildInfoRow('Alternative Phone', profile.alternativePhone),
          _buildInfoRow('Gender', profile.gender),
          _buildInfoRow('Date of Birth', profile.dob),
          _buildInfoRow('NIN', profile.nin),
          _buildInfoRow('ID Type', profile.identificationType),
        ],
      ),
    );
  }

  Widget _buildLocationInfo() {
    final profile = _profileData!.profile;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'LOCATION DETAILS',
            style: TextStyle(
              color: Colors.white54,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 16),
          _buildInfoRow('Branch', profile.branch.name),
          _buildInfoRow('District', profile.district),
          _buildInfoRow('Subcounty', profile.memberSubcounty),
          _buildInfoRow('Parish', profile.memberParish),
          _buildInfoRow('Village', profile.memberVillage),
        ],
      ),
    );
  }

  Widget _buildMembershipHistory() {
    final memberships = _profileData!.memberships;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'MEMBERSHIP HISTORY',
            style: TextStyle(
              color: Colors.white54,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 16),
          ...memberships.map((membership) => _buildMembershipItem(membership)),
        ],
      ),
    );
  }

  Widget _buildMembershipItem(Membership membership) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${membership.category} - ${membership.tier}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'UGX ${membership.fee}',
                style: const TextStyle(
                  color: Color(0xFFED1C24),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '${membership.startDate} - ${membership.endDate}',
            style: const TextStyle(
              color: Colors.white54,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: membership.paymentStatus.contains('successful')
                      ? Colors.green.withOpacity(0.2)
                      : Colors.orange.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  membership.paymentStatus.toUpperCase(),
                  style: TextStyle(
                    color: membership.paymentStatus.contains('successful')
                        ? Colors.green
                        : Colors.orange,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              if (membership.isExpired)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    'EXPIRED',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white54,
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

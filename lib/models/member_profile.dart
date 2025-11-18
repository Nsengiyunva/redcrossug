// Model classes
import 'package:redcross/models/active_membership.dart';
import 'package:redcross/models/membership.dart';
import 'package:redcross/models/profile.dart';

class MemberProfile {
  final bool success;
  final Profile profile;
  final List<Membership> memberships;
  final ActiveMembership? activeMembership;

  MemberProfile({
    required this.success,
    required this.profile,
    required this.memberships,
    this.activeMembership,
  });

  factory MemberProfile.fromJson(Map<String, dynamic> json) {
    return MemberProfile(
      success: json['success'] ?? false,
      profile: Profile.fromJson(json['profile']),
      memberships: (json['memberships'] as List)
          .map((m) => Membership.fromJson(m))
          .toList(),
      activeMembership: json['active_membership'] != null
          ? ActiveMembership.fromJson(json['active_membership'])
          : null,
    );
  }
}

import 'package:redcross/models/branch.dart';

class Profile {
  final String membershipId;
  final String volunteerId;
  final String name;
  final String surname;
  final String firstname;
  final String othername;
  final String email;
  final String phone;
  final String alternativePhone;
  final String gender;
  final String dob;
  final String nin;
  final String identificationType;
  final String district;
  final String memberSubcounty;
  final String memberParish;
  final String memberVillage;
  final Branch branch;
  final bool isMember;
  final bool isVolunteer;
  final bool membershipPaid;
  final bool membershipActive;
  final String accountApprovedStatus;
  final bool accountApproved;
  final bool accountVerified;

  Profile({
    required this.membershipId,
    required this.volunteerId,
    required this.name,
    required this.surname,
    required this.firstname,
    required this.othername,
    required this.email,
    required this.phone,
    required this.alternativePhone,
    required this.gender,
    required this.dob,
    required this.nin,
    required this.identificationType,
    required this.district,
    required this.memberSubcounty,
    required this.memberParish,
    required this.memberVillage,
    required this.branch,
    required this.isMember,
    required this.isVolunteer,
    required this.membershipPaid,
    required this.membershipActive,
    required this.accountApprovedStatus,
    required this.accountApproved,
    required this.accountVerified,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      membershipId: json['membership_id'] ?? '',
      volunteerId: json['volunteer_id'] ?? '',
      name: json['name'] ?? '',
      surname: json['surname'] ?? '',
      firstname: json['firstname'] ?? '',
      othername: json['othername'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      alternativePhone: json['alternative_phone'] ?? '',
      gender: json['gender'] ?? '',
      dob: json['dob'] ?? '',
      nin: json['nin'] ?? '',
      identificationType: json['identification_type'] ?? '',
      district: json['district'] ?? '',
      memberSubcounty: json['member_subcounty'] ?? '',
      memberParish: json['member_parish'] ?? '',
      memberVillage: json['member_village'] ?? '',
      branch: Branch.fromJson(json['branch']),
      isMember: json['is_member'] ?? false,
      isVolunteer: json['is_volunteer'] ?? false,
      membershipPaid: json['membership_paid'] ?? false,
      membershipActive: json['membership_active'] ?? false,
      accountApprovedStatus: json['account_approved_status'] ?? '',
      accountApproved: json['account_approved'] ?? false,
      accountVerified: json['account_verified'] ?? false,
    );
  }
}

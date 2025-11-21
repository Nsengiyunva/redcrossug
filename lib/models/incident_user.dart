class IncidentUser {
  final int id;
  final String name;
  final String email;
  final String phoneNo;
  final String? membershipId;

  IncidentUser({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNo,
    this.membershipId,
  });

  factory IncidentUser.fromJson(Map<String, dynamic> json) {
    return IncidentUser(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phoneNo: json['phone_no'] ?? '',
      membershipId: json['membership_id'],
    );
  }
}

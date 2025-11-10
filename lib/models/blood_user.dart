class BloodUser {
  final int id;
  final String name;
  final String firstName;
  final String lastName;
  final String email;
  final String? membershipId;
  final String phoneNo;
  final String nationality;

  BloodUser({
    required this.id,
    required this.name,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.membershipId,
    required this.phoneNo,
    required this.nationality,
  });

  factory BloodUser.fromJson(Map<String, dynamic> json) {
    return BloodUser(
      id: json['id'],
      name: json['name'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      membershipId: json['membership_id'],
      phoneNo: json['phone_no'],
      nationality: json['nationality'],
    );
  }
}

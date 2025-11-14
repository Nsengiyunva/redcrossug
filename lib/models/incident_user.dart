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
}

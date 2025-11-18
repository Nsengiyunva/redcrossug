class ActiveMembership {
  final int id;
  final String category;
  final String tier;
  final String startDate;
  final String endDate;
  final bool active;
  final String status;
  final bool isExpired;

  ActiveMembership({
    required this.id,
    required this.category,
    required this.tier,
    required this.startDate,
    required this.endDate,
    required this.active,
    required this.status,
    required this.isExpired,
  });

  factory ActiveMembership.fromJson(Map<String, dynamic> json) {
    return ActiveMembership(
      id: json['id'] ?? 0,
      category: json['category'] ?? '',
      tier: json['tier'] ?? '',
      startDate: json['start_date'] ?? '',
      endDate: json['end_date'] ?? '',
      active: json['active'] ?? false,
      status: json['status'] ?? '',
      isExpired: json['is_expired'] ?? false,
    );
  }
}

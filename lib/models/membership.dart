class Membership {
  final int id;
  final String category;
  final String tier;
  final String startDate;
  final String endDate;
  final String fee;
  final bool active;
  final String status;
  final String paymentStatus;
  final bool isExpired;

  Membership({
    required this.id,
    required this.category,
    required this.tier,
    required this.startDate,
    required this.endDate,
    required this.fee,
    required this.active,
    required this.status,
    required this.paymentStatus,
    required this.isExpired,
  });

  factory Membership.fromJson(Map<String, dynamic> json) {
    return Membership(
      id: json['id'] ?? 0,
      category: json['category'] ?? '',
      tier: json['tier'] ?? '',
      startDate: json['start_date'] ?? '',
      endDate: json['end_date'] ?? '',
      fee: json['fee'] ?? '0',
      active: json['active'] ?? false,
      status: json['status'] ?? '',
      paymentStatus: json['payment_status'] ?? '',
      isExpired: json['is_expired'] ?? false,
    );
  }
}

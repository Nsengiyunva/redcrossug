class Donation {
  final int id;
  final String organizationName;
  final double amount;
  final DateTime date;
  final String paymentMode;
  final String donationType;
  final String donorName;

  Donation({
    required this.id,
    required this.organizationName,
    required this.amount,
    required this.date,
    required this.paymentMode,
    required this.donationType,
    required this.donorName,
  });
}

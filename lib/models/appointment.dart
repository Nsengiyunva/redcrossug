class Appointment {
  final int id;
  final int bloodDonorId;
  final String donorName;
  final String location;
  final String phoneNumber;
  final DateTime lastDonationDate;
  final int preferredBloodBankId;
  final DateTime preferredDonationDate;
  final String status;
  final String timePreference;
  final String preferredTime;
  final String? notes;
  final String? cancellationReason;
  final String statusLabel;
  final String statusColor;
  final bool canBeModified;
  final bool canBeCancelled;
  final bool isOverdue;
  final int daysUntilAppointment;
  final BloodBank preferredBloodBank;

  Appointment({
    required this.id,
    required this.bloodDonorId,
    required this.donorName,
    required this.location,
    required this.phoneNumber,
    required this.lastDonationDate,
    required this.preferredBloodBankId,
    required this.preferredDonationDate,
    required this.status,
    required this.timePreference,
    required this.preferredTime,
    this.notes,
    this.cancellationReason,
    required this.statusLabel,
    required this.statusColor,
    required this.canBeModified,
    required this.canBeCancelled,
    required this.isOverdue,
    required this.daysUntilAppointment,
    required this.preferredBloodBank,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'] ?? 0,
      bloodDonorId: json['blood_donor_id'] ?? 0,
      donorName: json['donor_name'] ?? '',
      location: json['location'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      lastDonationDate: DateTime.parse(json['last_donation_date']),
      preferredBloodBankId: json['preferred_blood_bank_id'] ?? 0,
      preferredDonationDate: DateTime.parse(json['preferred_donation_date']),
      status: json['status'] ?? '',
      timePreference: json['time_preference'] ?? '',
      preferredTime: json['preferred_time'] ?? '',
      notes: json['notes'],
      cancellationReason: json['cancellation_reason'],
      statusLabel: json['status_label'] ?? '',
      statusColor: json['status_color'] ?? '',
      canBeModified: json['can_be_modified'] ?? false,
      canBeCancelled: json['can_be_cancelled'] ?? false,
      isOverdue: json['is_overdue'] ?? false,
      daysUntilAppointment: json['days_until_appointment'] ?? 0,
      preferredBloodBank: BloodBank.fromJson(json['preferred_blood_bank']),
    );
  }
}

class BloodBank {
  final int id;
  final String name;
  final String district;
  final String address;
  final String phone;
  final double latitude;
  final double longitude;

  BloodBank({
    required this.id,
    required this.name,
    required this.district,
    required this.address,
    required this.phone,
    required this.latitude,
    required this.longitude,
  });

  factory BloodBank.fromJson(Map<String, dynamic> json) {
    return BloodBank(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      district: json['district'] ?? '',
      address: json['address'] ?? '',
      phone: json['phone'] ?? '',
      latitude: double.tryParse(json['latitude'].toString()) ?? 0.0,
      longitude: double.tryParse(json['longitude'].toString()) ?? 0.0,
    );
  }
}

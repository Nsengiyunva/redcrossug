import 'package:redcross/models/preferred_blood_bank.dart';

class Appointment {
  final int id;
  final int bloodDonorId;
  final String donorName;
  final String location;
  final String phoneNumber;
  final DateTime? lastDonationDate;
  final int preferredBloodBankId;
  final DateTime preferredDonationDate;
  final String status;
  final String timePreference;
  final String? preferredTime;
  final DateTime? reminderSentAt;
  final DateTime? confirmedAt;
  final DateTime? completedAt;
  final String? notes;
  final String? cancellationReason;
  final int createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String statusLabel;
  final String statusColor;
  final bool canBeModified;
  final bool canBeCancelled;
  final bool isOverdue;
  final int daysUntilAppointment;
  final PreferredBloodBank preferredBloodBank;

  Appointment({
    required this.id,
    required this.bloodDonorId,
    required this.donorName,
    required this.location,
    required this.phoneNumber,
    this.lastDonationDate,
    required this.preferredBloodBankId,
    required this.preferredDonationDate,
    required this.status,
    required this.timePreference,
    this.preferredTime,
    this.reminderSentAt,
    this.confirmedAt,
    this.completedAt,
    this.notes,
    this.cancellationReason,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
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
      id: json['id'],
      bloodDonorId: json['blood_donor_id'],
      donorName: json['donor_name'],
      location: json['location'],
      phoneNumber: json['phone_number'],
      lastDonationDate: json['last_donation_date'] != null
          ? DateTime.parse(json['last_donation_date'])
          : null,
      preferredBloodBankId: json['preferred_blood_bank_id'],
      preferredDonationDate: DateTime.parse(json['preferred_donation_date']),
      status: json['status'],
      timePreference: json['time_preference'],
      preferredTime: json['preferred_time'],
      reminderSentAt: json['reminder_sent_at'] != null
          ? DateTime.parse(json['reminder_sent_at'])
          : null,
      confirmedAt: json['confirmed_at'] != null
          ? DateTime.parse(json['confirmed_at'])
          : null,
      completedAt: json['completed_at'] != null
          ? DateTime.parse(json['completed_at'])
          : null,
      notes: json['notes'],
      cancellationReason: json['cancellation_reason'],
      createdBy: json['created_by'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      statusLabel: json['status_label'],
      statusColor: json['status_color'],
      canBeModified: json['can_be_modified'],
      canBeCancelled: json['can_be_cancelled'],
      isOverdue: json['is_overdue'],
      daysUntilAppointment: json['days_until_appointment'],
      preferredBloodBank:
          PreferredBloodBank.fromJson(json['preferred_blood_bank']),
    );
  }
}

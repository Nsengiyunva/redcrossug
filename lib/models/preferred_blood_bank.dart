class PreferredBloodBank {
  final int id;
  final String name;
  final String district;
  final String address;
  final String phone;
  final String? email;
  final String affiliatedHospital;
  final String latitude;
  final String longitude;
  final bool isActive;

  PreferredBloodBank({
    required this.id,
    required this.name,
    required this.district,
    required this.address,
    required this.phone,
    this.email,
    required this.affiliatedHospital,
    required this.latitude,
    required this.longitude,
    required this.isActive,
  });

  factory PreferredBloodBank.fromJson(Map<String, dynamic> json) {
    return PreferredBloodBank(
      id: json['id'],
      name: json['name'],
      district: json['district'],
      address: json['address'],
      phone: json['phone'],
      email: json['email'],
      affiliatedHospital: json['affiliated_hospital'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      isActive: json['is_active'] ?? true,
    );
  }
}

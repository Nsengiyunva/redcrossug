class BloodBank {
  final int id;
  final String name;
  final String district;
  final String address;
  final String phone;
  final String? email;
  final String affiliatedHospital;
  final double latitude;
  final double longitude;

  BloodBank({
    required this.id,
    required this.name,
    required this.district,
    required this.address,
    required this.phone,
    this.email,
    required this.affiliatedHospital,
    required this.latitude,
    required this.longitude,
  });

  factory BloodBank.fromJson(Map<String, dynamic> json) {
    return BloodBank(
      id: json['id'],
      name: json['name'],
      district: json['district'],
      address: json['address'],
      phone: json['phone'],
      email: json['email'],
      affiliatedHospital: json['affiliated_hospital'],
      latitude: double.parse(json['latitude']),
      longitude: double.parse(json['longitude']),
    );
  }
}

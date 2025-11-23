class Branch {
  final int id;
  final String name;
  final String districts;
  double? latitude;
  double? longitude;

  Branch(
      {required this.id,
      required this.name,
      required this.districts,
      this.latitude,
      this.longitude});

  factory Branch.fromJson(Map<String, dynamic> json) {
    return Branch(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      districts: json['districts'] ?? '',
      latitude: json['latitude'] ?? '',
      longitude: json['longitude'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'districts': districts,
        'latitude': latitude,
        'longitude': longitude
      };
}

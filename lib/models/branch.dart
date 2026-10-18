// class Branch {
//   final int id;
//   final String name;
//   final String districts;
//   double? latitude;
//   double? longitude;

//   Branch(
//       {required this.id,
//       required this.name,
//       required this.districts,
//       this.latitude,
//       this.longitude});

//   factory Branch.fromJson(Map<String, dynamic> json) {
//     return Branch(
//       id: json['id'] ?? 0,
//       name: json['name'] ?? '',
//       districts: json['districts'] ?? '',
//       latitude: json['latitude'] ?? '',
//       longitude: json['longitude'] ?? '',
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         'id': id,
//         'name': name,
//         'districts': districts,
//         'latitude': latitude,
//         'longitude': longitude
//       };
// }

class Branch {
  final int id;
  final String name;
  final String districts;
  final double? latitude;
  final double? longitude;
  // Optional extras for the Branch Locator — absent from older API payloads.
  final String? region;
  final String? address;
  final String? phone;

  Branch({
    required this.id,
    required this.name,
    required this.districts,
    required this.latitude,
    required this.longitude,
    this.region,
    this.address,
    this.phone,
  });

  bool get hasLocation => latitude != null && longitude != null;

  static double? _toDouble(dynamic v) {
    if (v == null) return null;
    if (v is num) return v.toDouble();
    return double.tryParse(v.toString());
  }

  factory Branch.fromJson(Map<String, dynamic> json) => Branch(
        id: json['id'] is int
            ? json['id']
            : int.tryParse('${json['id']}') ?? 0,
        name: json['name'] ?? '',
        districts: json['districts'] ?? '',
        latitude: _toDouble(json['latitude']),
        longitude: _toDouble(json['longitude']),
        region: json['region'],
        address: json['address'],
        phone: json['phone'],
      );
}

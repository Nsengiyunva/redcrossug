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

  Branch({
    required this.id,
    required this.name,
    required this.districts,
    required this.latitude,
    required this.longitude,
  });

  factory Branch.fromJson(Map<String, dynamic> json) => Branch(
        id: json['id'] ?? 0,
        name: json['name'] ?? '',
        districts: json['districts'] ?? '',
        latitude: json['latitude'] == null
            ? null
            : (json['latitude'] as num).toDouble(),
        longitude: json['longitude'] == null
            ? null
            : (json['longitude'] as num).toDouble(),
      );
}

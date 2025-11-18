class Branch {
  final int id;
  final String name;
  final String districts;

  Branch({
    required this.id,
    required this.name,
    required this.districts,
  });

  factory Branch.fromJson(Map<String, dynamic> json) {
    return Branch(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      districts: json['districts'] ?? '',
    );
  }
}

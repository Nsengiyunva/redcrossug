class District {
  final int id;
  final String name;
  final String value;

  District({required this.id, required this.name, required this.value});

  factory District.fromJson(Map<String, dynamic> json) {
    return District(
      id: json['id'],
      name: json['name'],
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'value': value};
}

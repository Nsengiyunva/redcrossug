class Specialization {
  final int id;
  final String name;
  final String date_created;
  final String date_updated;

  Specialization(
      {required this.id,
      required this.name,
      required this.date_created,
      required this.date_updated});

  factory Specialization.fromJson(Map<String, dynamic> json) {
    return Specialization(
      id: json['id'],
      name: json['name'],
      date_created: json['date_created'],
      date_updated: json['date_updated'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'date_created': date_created,
        'date_updated': date_updated
      };
}

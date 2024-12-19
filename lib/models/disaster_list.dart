
class DisasterList {
  final String name;
  final int age;

  DisasterList({required this.name, required this.age});

  // Convert object to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'age': age,
    };
  }

  // Create object from JSON
  factory DisasterList.fromJson(Map<String, dynamic> json) {
    return DisasterList(
      name: json['name'],
      age: json['age'],
    );
  }
}
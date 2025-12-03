// ignore_for_file: prefer_typing_uninitialized_variables

class DisasterList {
  var name;
  var age;

  DisasterList( { required this.name, required this.age } );
  // Convert object to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'age': age,
    };
  }

  // Create object from JSON
  DisasterList.fromJson(Map<String, dynamic> json) {
    DisasterList(
      name: json['name'],
      age: json['age'],
    );
  }
}
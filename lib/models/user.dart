class User {
  String name;

  User({required this.name});

  Map<String, dynamic> toJson() {
    return {"name": name};
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(name: json['name']);
  }
}

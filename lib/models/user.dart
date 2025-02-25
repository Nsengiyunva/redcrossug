class User {
  String name;
  String phone_no;

  User({required this.name, required this.phone_no});

  Map<String, dynamic> toJson() {
    return {"name": name, "phone_no": phone_no};
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(name: json['name'], phone_no: json['phone_no']);
  }
}

class Note {
  String title;
  String desc;
  String token;

  Note(this.title, this.desc, this.token);

  static toMap(Note note) {
    return {"title": note.title, "desc": note.desc, "token": note.token};
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(map['title'], map['desc'], map['token']);
  }
}

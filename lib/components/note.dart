import 'dart:convert';

Note noteFromMap(String str) => Note.fromMap(json.decode(str));

String noteToMap(Note data) => json.encode(data.toMap());

class Note {
  Note({
    this.body,
    this.date,
  });

  String date;
  String body;

  factory Note.fromMap(Map<String, dynamic> data) {
    return Note(
      body: data['body'],
      date: data['date'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'body': this.body,
      'date': this.date,
    };
  }
}

import 'dart:convert';

class Note {
  int? id;
  final String title;
  final String text;
  final int color;

  Note({
    this.id,
    required this.title,
    required this.text,
    required this.color,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'text': text,
      'color': color,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id']?.toInt(),
      title: map['title'] ?? '',
      text: map['text'] ?? '',
      color: map['color']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Note.fromJson(String source) => Note.fromMap(json.decode(source));
}

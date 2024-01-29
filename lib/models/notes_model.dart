// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class NoteModel {
  final String? uid;
  final String? title;
  final String? description;

  NoteModel({this.uid, this.title, this.description});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'title': title,
      'description': description,
    };
  }

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      uid: map['_id'] as String? ??
          '', // Handle null case by providing a default value
      title: map['title'] as String? ?? '',
      description: map['description'] as String? ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory NoteModel.fromJson(String source) =>
      NoteModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

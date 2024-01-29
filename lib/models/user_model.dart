import 'dart:convert';

import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String? uid;
  final String? username;
  final String? email;
  final String? password;

  const UserModel({
    this.uid = "",
    this.username,
    this.email,
    this.password,
  });

  @override
  List<Object?> get props => [uid, username, email, password];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'username': username,
      'email': email,
      'password': password,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['_id'] as String? ?? '', // Provide a default value if null
      username:
          map['username'] as String? ?? '', // Provide a default value if null
      email: map['email'] as String? ?? '', // Provide a default value if null
      password:
          map['password'] as String? ?? '', // Provide a default value if null
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );
}

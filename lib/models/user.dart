// To parse this JSON data, do
//
//     final user = userFromMap(jsonString);

import 'dart:convert';

class User {
  User({
    required this.nickname,
    required this.password,
    this.id,
    this.bestTry,
    this.numTries,
    this.bestTime,
    this.numTries2,
  });

  String nickname;
  String password;
  int? id;
  int? bestTry;
  int? numTries;
  int? bestTime;
  int? numTries2;

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        nickname: json["nickname"],
        password: json["password"],
        id: json["id"],
        bestTry: json["bestTry"],
        numTries: json["numTries"],
        bestTime: json["bestTime"],
        numTries2: json["numTries2"],
      );

  Map<String, dynamic> toMap() => {
        "nickname": nickname,
        "password": password,
        "id": id,
        "bestTry": bestTry,
        "numTries": numTries,
        "bestTime": bestTime,
        "numTries2": numTries2,
      };
}

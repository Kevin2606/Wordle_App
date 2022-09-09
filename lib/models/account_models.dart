// To parse this JSON data, do
//
//     final Account = AccountFromMap(jsonString);

import 'dart:convert';

class Account {
  Account({required this.nickname, required this.password, this.id});

  String nickname;
  String password;
  int? id;

  factory Account.fromJson(String str) => Account.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());
  String toJsonFirebase() => json.encode(toMapFirebase());

  factory Account.fromMap(Map<String, dynamic> json) => Account(
      nickname: json["nickname"], password: json["password"], id: json["id"]);

  Map<String, dynamic> toMap() =>
      {"nickname": nickname, "password": password, "id": id};
  Map<String, dynamic> toMapFirebase() => {
        nickname: {"nickname": nickname, "password": password}
      };
}

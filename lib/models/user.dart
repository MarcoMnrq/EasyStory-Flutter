// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.telephone,
    required this.subscribers,
    required this.subscriptions,
  });

  DateTime createdAt;
  DateTime updatedAt;
  int id;
  String username;
  String firstName;
  String lastName;
  String email;
  String telephone;
  int subscribers;
  int subscriptions;

  factory User.fromJson(Map<String, dynamic> json) => User(
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        id: json["id"],
        username: json["username"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        telephone: json["telephone"],
        subscribers: json["subscribers"],
        subscriptions: json["subscriptions"],
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "id": id,
        "username": username,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "telephone": telephone,
        "subscribers": subscribers,
        "subscriptions": subscriptions,
      };
}

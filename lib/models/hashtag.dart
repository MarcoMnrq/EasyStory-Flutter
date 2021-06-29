// To parse this JSON data, do
//
//     final hashtag = hashtagFromJson(jsonString);

import 'dart:convert';

Hashtag hashtagFromJson(String str) => Hashtag.fromJson(json.decode(str));

String hashtagToJson(Hashtag data) => json.encode(data.toJson());

class Hashtag {
  Hashtag({
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.id,
  });

  DateTime createdAt;
  DateTime updatedAt;
  String name;
  int id;

  factory Hashtag.fromJson(Map<String, dynamic> json) => Hashtag(
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        name: json["name"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "name": name,
        "id": id,
      };
}

// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:convert';

Post postFromJson(String str) => Post.fromJson(json.decode(str));

String postToJson(Post data) => json.encode(data.toJson());

class Post {
  Post({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.content,
  });

  DateTime createdAt;
  DateTime updatedAt;
  int id;
  int userId;
  String title;
  String description;
  String content;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        id: json["id"],
        userId: json["userId"],
        title: json["title"],
        description: json["description"],
        content: json["content"],
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "id": id,
        "userId": userId,
        "title": title,
        "description": description,
        "content": content,
      };
}

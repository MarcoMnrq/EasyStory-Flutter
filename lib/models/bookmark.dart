import 'dart:convert';

// To parse this JSON data, do
//
//     final bookmark = bookmarkFromJson(jsonString);

import 'dart:convert';

Bookmark bookmarkFromJson(String str) => Bookmark.fromJson(json.decode(str));

String bookmarkToJson(Bookmark data) => json.encode(data.toJson());

class Bookmark {
  Bookmark({
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
    required this.postId,
  });

  DateTime createdAt;
  DateTime updatedAt;
  int userId;
  int postId;

  factory Bookmark.fromJson(Map<String, dynamic> json) => Bookmark(
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        userId: json["userId"],
        postId: json["postId"],
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "userId": userId,
        "postId": postId,
      };
}

import 'dart:convert';

Comment commentFromJson(String str) => Comment.fromJson(json.decode(str));

String commentToJson(Comment data) => json.encode(data.toJson());

class Comment {
  Comment({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.userId,
    required this.postId,
    required this.content,
  });

  DateTime createdAt;
  DateTime updatedAt;
  int id;
  int userId;
  int postId;
  String content;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        id: json["id"],
        userId: json["userId"],
        postId: json["postId"],
        content: json["content"],
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "id": id,
        "userId": userId,
        "postId": postId,
        "content": content,
      };
}

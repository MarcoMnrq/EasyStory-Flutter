import 'dart:convert';

Qualification qualificationFromJson(String str) =>
    Qualification.fromJson(json.decode(str));

String qualificationToJson(Qualification data) => json.encode(data.toJson());

class Qualification {
  Qualification({
    required this.id,
    required this.userId,
    required this.postId,
    required this.qualification,
  });

  int id;
  int userId;
  int postId;
  int qualification;

  factory Qualification.fromJson(Map<String, dynamic> json) => Qualification(
        id: json["id"],
        userId: json["userId"],
        postId: json["postId"],
        qualification: json["qualification"].truncate(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "postId": postId,
        "qualification": qualification,
      };
}

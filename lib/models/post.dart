class Post {
  DateTime createdAt;
  DateTime updatedAt;
  int id;
  int userId;
  String title;
  String description;
  String content;

  Post({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.content,
  });

  // Parsing data from json for networking
  factory Post.fromJson(Map<String, dynamic> map) {
    return Post(
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
      id: map['id'],
      userId: map['userId'],
      title: map['title'],
      description: map['description'],
      content: map['content'],
    );
  }

  // Serializing to map for local persistence
  Map<String, dynamic> toMap() {
    return {
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'id': id,
      'userId': userId,
      'title': title,
      'description': description,
      'content': content,
    };
  }

  // Parsing data from map for local persistence
  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      updatedAt: map['createdAt'],
      createdAt: map['updatedAt'],
      id: map['id'],
      userId: map['userId'],
      title: map['title'],
      description: map['description'],
      content: map['content'],
    );
  }
}

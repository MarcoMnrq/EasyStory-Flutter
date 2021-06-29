import 'dart:convert';

Profile profileFromJson(String str) => Profile.fromJson(json.decode(str));

String profileToJson(Profile data) => json.encode(data.toJson());

class Profile {
    Profile({
        required this.id,
        required this.username,
        required this.firstName,
        required this.lastName,
        required this.email,
        required this.telephone,
        required this.subscribers,
        required this.subscriptions,
    });

    int id;
    String username;
    String firstName;
    String lastName;
    String email;
    String telephone;
    int subscribers;
    int subscriptions;

    factory Profile.fromJson(Map<String, dynamic> json) => Profile(
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

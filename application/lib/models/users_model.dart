// To parse this JSON data, do
//
//     final users = usersFromJson(jsonString);

import 'dart:convert';

Users usersFromJson(String str) => Users.fromJson(json.decode(str));

String usersToJson(Users data) => json.encode(data.toJson());

class Users {
    int userId;
    String role;
    String username;
    String password;
    dynamic token;

    Users({
        required this.userId,
        required this.role,
        required this.username,
        required this.password,
        this.token,
    });

    factory Users.fromJson(Map<String, dynamic> json) => Users(
        userId: json["user_id"],
        role: json["role"],
        username: json["username"],
        password: json["password"],
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId,
        "role": role,
        "username": username,
        "password": password,
        "token": token,
    };
}

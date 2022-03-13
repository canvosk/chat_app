import 'package:flutter/cupertino.dart';

class Users {
  String userId;
  String name;
  String username;
  String email;
  String password;

  Users({
    required this.userId,
    required this.name,
    required this.username,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'name': name,
        'username': username,
        'email': email,
        'password': password,
      };

  static Users fromJson(Map<String, dynamic> json) => Users(
        userId: json['userId'],
        name: json['name'],
        username: json['username'],
        email: json['email'],
        password: json['password'],
      );
}

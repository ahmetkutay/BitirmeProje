import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class User {
  String userId;
  String userName;
  String email;
  String password;

  User({
    @required this.userId,
    @required this.email,
  });
  User.internal();
  Map<String, dynamic> toMap() {
    return {
      "userId": userId,
      "email": email,
      "userName": userName,
    };
  }

  User.fromMap(Map<String, dynamic> map)
      : userId = map["userId"],
        userName = map["userName"],
        email = map["email"];
}

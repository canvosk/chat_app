import 'package:chat_app/core/models/user.dart' as user;
import 'package:chat_app/core/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class UserModelState with ChangeNotifier {
  final AuthService _auth = AuthService(FirebaseAuth.instance);
  List<user.User> currentUser = [];

  // List<Message> _messages = [];

  Future<List<user.User>> getCurrentUser() async {
    Map<String, dynamic> toGet = {};
    toGet = await _auth.getCurrentUser();
    user.User newUser = user.User(
        userId: toGet['userId'],
        name: toGet['name'],
        username: toGet['username'],
        email: toGet['email'],
        password: toGet['password']);
    currentUser.add(newUser);
    notifyListeners();
    return currentUser;
  }

  getMessage() async {
    // Message _newMessage;
    // await _auth.getMessage();
  }
}

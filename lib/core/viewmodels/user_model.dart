import 'package:chat_app/core/models/user.dart';
import 'package:chat_app/core/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class UserModelState with ChangeNotifier {
  final AuthService _auth = AuthService(FirebaseAuth.instance);
  Users? currentUser;

  // List<Message> _messages = [];

  Future<void> getCurrentUser() async {
    currentUser = await _auth.getCurrentUser();
    notifyListeners();
    //return currentUser;
  }

  Future<void> updateUser({
    required String uid,
    required String name,
    required String username,
    required String email,
    required String password,
  }) async {
    await _auth.updateUser(
      uid: uid,
      name: name,
      username: username,
      email: email,
      password: password,
    );

    notifyListeners();
  }

  getMessage() async {
    // Message _newMessage;
    // await _auth.getMessage();
  }
}

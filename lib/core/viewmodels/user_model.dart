import 'dart:io';

import 'package:chat_app/core/models/user.dart';
import 'package:chat_app/core/services/auth_service.dart';
import 'package:chat_app/core/services/storage_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class UserModelState with ChangeNotifier {
  final AuthService _auth = AuthService(FirebaseAuth.instance);
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final StorageService _storageService = StorageService();
  Users? currentUser;

  String mediaUrl = "";

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

  Future<void> uploadImage(
    String uid,
    File file,
  ) async {
    var ref = _firestore.collection('users');

    mediaUrl = await _storageService.uploadMedia(uid, File(file.path));

    _auth.updateProfileImage(uid: uid, url: mediaUrl);
  }
}

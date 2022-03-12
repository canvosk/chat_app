import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthService {
  final FirebaseAuth _auth;

  AuthService(this._auth);

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Stream<User?> get authStateChanges => _auth.idTokenChanges();

  Future<String?> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return "Signed in";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<void> signOut() async {
    return await _auth.signOut();
  }

  Future<String> createUser({
    required String name,
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      CollectionReference users = _firestore.collection('users');
      String uid = _auth.currentUser!.uid.toString();
      users.add({
        'userId': uid,
        'name': name,
        'username': username,
        'email': email,
        'password': password,
      });
      //signIn(email, password);
      return "Signed up";
    } on FirebaseAuthException catch (e) {
      log(e.message.toString());
      return e.message.toString();
    }
  }
}

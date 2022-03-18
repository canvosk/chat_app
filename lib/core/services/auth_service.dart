import 'dart:developer';
import 'package:chat_app/core/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthService {
  final FirebaseAuth _auth;

  AuthService(this._auth);

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  //final user.User userModel;
  Users? _currentUser;
  Stream<User?> get authStateChanges => _auth.idTokenChanges();

  Future<Users?> getCurrentUser() async {
    CollectionReference _ref = _firestore.collection('users');
    final User? _user = _auth.currentUser;
    final userId = _user!.uid;

    final docUser = _ref.doc(userId);
    final snapshot = await docUser.get();

    if (snapshot.exists) {
      _currentUser = Users.fromJson(snapshot.data() as Map<String, dynamic>);
      return Users.fromJson(snapshot.data() as Map<String, dynamic>);
    } else {
      _currentUser = Users.fromJson(snapshot.data() as Map<String, dynamic>);
      return Users.fromJson(snapshot.data() as Map<String, dynamic>);
    }
  }

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

      String uid = _auth.currentUser!.uid.toString();
      Map<String, dynamic> _toAdd = {
        'userId': uid,
        'name': name,
        'username': username,
        'email': email,
        'password': password,
        'profileUrl':
            "https://firebasestorage.googleapis.com/v0/b/chat-app-7d6cc.appspot.com/o/nonprofile.png?alt=media&token=c0d3ef51-7921-4379-a56c-64c6a4356f55",
      };
      _firestore.collection('users').doc(uid).set(_toAdd);
      return "Signed up";
    } on FirebaseAuthException catch (e) {
      log(e.message.toString());
      return e.message.toString();
    }
  }

  Future<void> updateUser({
    required String uid,
    required String name,
    required String username,
    required String email,
    required String password,
  }) async {
    CollectionReference _ref = _firestore.collection('users');
    Map<String, dynamic> _toUpdate = {
      'userId': uid,
      'name': name,
      'username': username,
      'email': email,
      'password': password,
    };

    await _ref.doc(uid).set(_toUpdate);
  }

  Future<void> updateProfileImage(
      {required String uid, required String url}) async {
    CollectionReference _ref = _firestore.collection('users');
    await _ref.doc(uid).update({'profileUrl': url});
  }
}

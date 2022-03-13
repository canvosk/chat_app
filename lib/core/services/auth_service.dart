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

  Future<Map<String, dynamic>> getCurrentUser() async {
    CollectionReference _ref = _firestore.collection('users');
    final User? user = _auth.currentUser;
    final userId = user!.uid;
    Map<String, dynamic> _currentUser = {};

    _ref.doc(userId).get().then((value) {
      var x = value.data();
      _currentUser = {
        'userId': userId,
        'name': (x as Map)['name'],
        'username': x['username'],
        'email': x['email'],
        'password': x['password'],
      };
    });
    log(_currentUser.toString());
    return _currentUser;
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
      };
      _firestore.collection('users').doc(uid).set(_toAdd);

      // users.add({
      //   'userId': uid,
      //   'name': name,
      //   'username': username,
      //   'email': email,
      //   'password': password,
      // });
      return "Signed up";
    } on FirebaseAuthException catch (e) {
      log(e.message.toString());
      return e.message.toString();
    }
  }

  // Future<List<Object>> getMessage() async {
  //   CollectionReference _message = _firestore.collection('messages');
  //   List<Object> _messageList = [];
  //   try {
  //     await _message.get().then((x) {
  //       x.docs.forEach((element) {
  //         _messageList.add(element.data);
  //       });
  //     });
  //     return _messageList;
  //   } catch (e) {
  //     print(e.toString());
  //     return _messageList;
  //   }
  // }
}

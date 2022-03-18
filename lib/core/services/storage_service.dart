import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  //Upload File
  Future<String> uploadMedia(String uid, File file) async {
    var uploadTask =
        _firebaseStorage.ref().child("${uid}_profile.png").putFile(file);

    uploadTask.snapshotEvents.listen((event) {});

    var storageRef = await uploadTask.then((p0) => p0.ref.getDownloadURL());

    return await storageRef;
  }
}

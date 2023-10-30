import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageRepo{
  static final _storage = FirebaseStorageRepo._();

  late FirebaseStorage repo;

  FirebaseStorageRepo._(){
    repo = FirebaseStorage.instance;
  }

  factory FirebaseStorageRepo(){
    return _storage;
  }

  Future<String> uploadFileToFirebaseStorage(File file) async {
    final String url = 'ProfilePic/${FirebaseAuth.instance.currentUser!.phoneNumber}';
    final UploadTask task =  repo.ref().child(url).putFile(file);
    final TaskSnapshot snap = await task;
    final String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

}
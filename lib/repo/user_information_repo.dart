import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:news_app_task/models/favourite_model.dart';
import 'package:news_app_task/models/headline_model.dart';
import 'package:news_app_task/models/user_model.dart';
import 'package:news_app_task/repo/firebase_storage_repo.dart';
import 'package:uuid/uuid.dart';

import '../controller/auth_controller.dart';

class UserRepo {
  final FirebaseFirestore fireStore;
  final FirebaseAuth auth;

  UserRepo({
    required this.fireStore,
    required this.auth,
  });


  saveUserInfoToFireStore({
    required context,
    required name,
    required url,
    required occupation,
    required File? image}) async
  {
    try {
      final String uid = auth.currentUser!.uid;
      final String phoneNumber = auth.currentUser!.phoneNumber!;

      String profileUrl;
      if (image != null) {
        profileUrl =
        await FirebaseStorageRepo().uploadFileToFirebaseStorage(image);
      }
      else if(url != null){
        profileUrl = url;
      }
      else{
        profileUrl =
        'https://thumbs.dreamstime.com/b/default-avatar-profile-icon-vector-social-media-user-portrait-176256935.jpg';
      }
      UserModel model = UserModel(
          userName: name,
          profileUrl: profileUrl,
          phoneNumber: phoneNumber,
          uid: uid,
          occupation: occupation);
      await fireStore.collection('users').doc(auth.currentUser!.uid).set(
          model.toMap());


    }
    catch (error) {
      Fluttertoast.showToast(msg: error.toString());
    }
  }// Fun


   Stream<UserModel> getUserModel() {
     return fireStore.collection('users').doc(auth.currentUser!.uid).snapshots().map((doc) =>
         UserModel.fromMap(doc.data()!));

  }

  // Verify Is User Has Account In FireBase Or Not
  verifyUserAccount(context, String phoneNumber) async {
    var data = await fireStore.collection('users').get();
    var listMap = data.docs;
    for(var map in listMap){
       var model = UserModel.fromMap(map.data());
       if(model.phoneNumber == phoneNumber){
         await AuthController().verifyPhone(
             context: context,
             phoneNumber: phoneNumber);
         break;
       }
       Fluttertoast.showToast(msg: 'User does not exists.');
    }
  }

  addToFavourites({
    required String title,
    required String publishedAt,
    required String urlToImage,
    required String source,
    required String description,
}) async {
    try{
      debugPrint('start');
      String uid = auth.currentUser!.uid;
      String docId = const Uuid().v1();
      FavouriteModel data = FavouriteModel(title: title, publishedAt: publishedAt, urlToImage: urlToImage, docId: docId, source: source, description: description);
      await fireStore.collection('users').doc(uid).collection('favourite').doc(docId).set(data.toMap());
    }
    catch (error){
      Fluttertoast.showToast(msg: error.toString());
    }
  }

   Future<List<FavouriteModel>> getFavourites() async {
    List<FavouriteModel> list = [];
    try{
      String uid = auth.currentUser!.uid;
      var query = await fireStore.collection('users').doc(uid).collection('favourite').get();
      var doc = query.docs;
      for(var map in doc){
        list.add(FavouriteModel.fromMap(map.data()));
      }

    }
    catch (error){
      Fluttertoast.showToast(msg: error.toString());
    }
    return list;
  }


}
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_app_task/models/favourite_model.dart';
import 'package:news_app_task/repo/user_information_repo.dart';

import '../models/user_model.dart';

class UserInformationController {
  static final _con = UserInformationController._();
  late UserRepo _repo;

  UserInformationController._() {
    _repo = UserRepo(
        fireStore: FirebaseFirestore.instance, auth: FirebaseAuth.instance);
  }

  factory UserInformationController() {
    return _con;
  }

  saveUserInfoToFireStore(
      {
      required context,
      required name,
      required occupation,
      required url,
      required File? image})
  {
    _repo.saveUserInfoToFireStore(
        context: context,
        name: name,
        url: url,
        occupation: occupation,
        image: image);
  }

  Stream<UserModel> getUserModel() {
   return _repo.getUserModel();
  }


  verifyUserAccount(context, String phoneNumber) {
    _repo.verifyUserAccount(context, phoneNumber);
  }

  addToFavourites({
    required String title,
    required String publishedAt,
    required String urlToImage,
    required String source,
    required String description,
})  {
     _repo.addToFavourites(title: title, publishedAt: publishedAt, urlToImage: urlToImage, source: source, description: description);
  }


  Future<List<FavouriteModel>> getFavourites() async {
    return await _repo.getFavourites();
  }

}

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:news_app_task/controller/user_information_controller.dart';

import '../screens/home.dart';
import '../screens/otp_screen.dart';

class AuthRepository {
  final FirebaseAuth auth;

  AuthRepository({required this.auth});

  //Phone Number Authentication
  verifyPhoneNo({
    required context,
    required String phoneNumber,
    String? name,
    String? occupation,
    File? image,
  }) {
    debugPrint(phoneNumber);
    try {
      auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (credential) async {
          await auth.signInWithCredential(credential);
        },
        verificationFailed: (firebaseAuthException) {
          throw Exception(firebaseAuthException);
        },
        codeSent: (verificationId, resentToken) {
          debugPrint('code sent');
          Fluttertoast.showToast(msg: 'Message has been sent.');
          Navigator.pushNamed(
            context,
            OtpScreen.routeName,
            arguments: {
              'verificationId': verificationId,
              'name': name,
              'occupation': occupation,
              'image': image,
            },
          );
        },
        codeAutoRetrievalTimeout: (codeAutoRetrievalTimeOut) {},
      );
      return true;
    } on FirebaseAuthException catch (error) {
      Fluttertoast.showToast(msg: error.toString());
      return true;
    }
  }

  //Otp Verification
  verifyOtp(
      {required verificationId,
        required smsCode,
        required context,
        String? name,
        String? url,
        String? occupation,
        File? image}) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: smsCode);
      await auth.signInWithCredential(credential);
      debugPrint('successful');

      if(name != '' && occupation != '' && image != null){
      UserInformationController().saveUserInfoToFireStore(
          context: context,
          name: name,
          occupation: occupation,
          url: url,
          image: image);
      }

      Navigator.pushNamedAndRemoveUntil(
          context, Home.routeName, (route) => false);
    } on FirebaseAuthException catch (error) {
      Fluttertoast.showToast(msg: error.toString());
    }
  } // VERIFY OTP


}

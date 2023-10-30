import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_app_task/repo/auth_repo.dart';

class AuthController {
  static final instance = AuthController._instance();
  late AuthRepository _authRepo;

  AuthController._instance() {
    _authRepo = AuthRepository(
        auth: FirebaseAuth.instance);
  }

  factory AuthController() {
    return instance;
  }

  //Verify Phone Number
  Future<bool> verifyPhone({
    required context,
    required String phoneNumber,
    String? name,
    String? occupation,
    File? image,
  }) async {
    await _authRepo.verifyPhoneNo(
        context: context,
        phoneNumber: phoneNumber,
        name: name,
        occupation: occupation,
        image: image);
    return true;
  }

  //Verify Sms Code
  verifyOtp(
      {
        required verificationId,
        required smsCode,
        required context,
        String? name,
        String? occupation,
        File? image}) {
          _authRepo.verifyOtp(
          verificationId: verificationId,
          smsCode: smsCode,
          context: context,
          name: name,
          occupation: occupation,
          image: image);
  }
}

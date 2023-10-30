import 'dart:io';

import 'package:flutter/material.dart';
import 'package:news_app_task/controller/auth_controller.dart';

import '../widgets/text_widget.dart';

class OtpScreen extends StatefulWidget {
  static const routeName = '/Otp-screen';
   final String verificationId;
   String? name;
   String? occupation;
   File? image;
   OtpScreen({
    super.key,
    required this.verificationId,
    this.image,
    this.name,
    this.occupation,
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  verifyOtp(context, String smsCode) {
    AuthController().verifyOtp(
        verificationId: widget.verificationId,
        smsCode: smsCode,
        context: context,
        name: widget.name,
        occupation: widget.occupation,
        image: widget.image);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: const TextWidget(
            text: 'Phone Verification',
            textColor: Colors.black,
            fontSize: 19,
            fontWeight: FontWeight.w500,
            textAlign: TextAlign.start),
        automaticallyImplyLeading: true,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            const TextWidget(
                text: 'Enter Sms Code',
                textColor: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.normal,
                textAlign: TextAlign.center),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: size.width * 0.5,
              child: TextField(
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  hintText: '- - - - - -',
                  hintStyle:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
                onChanged: (smsCode) {
                  if (smsCode.length == 6) {
                    verifyOtp(context, smsCode);

                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app_task/screens/signin_screen.dart';

import 'home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    checkUserStatus();
  }

  checkUserStatus(){
    Timer(
        const Duration(seconds: 3),
            ()  {
          print(FirebaseAuth.instance.currentUser);
              if(FirebaseAuth.instance.currentUser == null ){
                Navigator.pushNamedAndRemoveUntil(context, SignInScreen.routeName, (route) => false);
              }
              else{
                Navigator.pushNamedAndRemoveUntil(context, Home.routeName, (route) => false);
              }
        });

  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          //Image
          Image.asset(
            'images/splash.jpg',
            height: size.height* .42,
          fit: BoxFit.cover,),

          SizedBox(height: size.height*0.03,),

          Text('Top News', style: GoogleFonts.anton(letterSpacing: .7, color: Colors.blue.shade300, fontSize: 20),),

          SizedBox(height: size.height*0.03,),

          const SpinKitChasingDots(
            color: Colors.blue,
          ),



        ],
      ),
    );
  }
}

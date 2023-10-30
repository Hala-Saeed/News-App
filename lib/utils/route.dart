import 'package:flutter/material.dart';
import 'package:news_app_task/screens/details_screen.dart';
import 'package:news_app_task/screens/favourites_screen.dart';
import 'package:news_app_task/screens/login_screen.dart';
import 'package:news_app_task/screens/profile_screen.dart';
import 'package:news_app_task/screens/home.dart';
import 'package:news_app_task/screens/signin_screen.dart';

import '../screens/otp_screen.dart';
import 'error_display.dart';

class RouteClass {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Home.routeName:
        return MaterialPageRoute(builder: (context) => const Home());
      case LoginScreen.routeName:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      case OtpScreen.routeName:
        final map = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (context) => OtpScreen(
                verificationId: map['verificationId'],
                image: map['image'],
                name: map['name'],
                occupation: map['occupation']));
      case DetailsScreen.routeName:
        final map = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (context) => DetailsScreen(
                title: map['title'],
                description: map['description'],
                urlToImage: map['urlToImage'],
                publishedAt: map['publishedAt'],
                source: map['source'],));
      case ProfileScreen.routeName:
        return MaterialPageRoute(builder: (context) => const ProfileScreen());
      case FavouritesScreen.routeName:
        return MaterialPageRoute(builder: (context) => const FavouritesScreen());
      case SignInScreen.routeName:
        return MaterialPageRoute(builder: (context) => const SignInScreen());

      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: ErrorDisplay(error: 'This route does not exist'),
          ),
        );
    }
  }
}

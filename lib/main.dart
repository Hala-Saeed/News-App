import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:news_app_task/firebase_options.dart';
import 'package:news_app_task/screens/signin_screen.dart';
import 'package:news_app_task/screens/splash_screen.dart';
import 'package:news_app_task/utils/route.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget
{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
      title: 'Task',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color: Colors.white,
          titleTextStyle: TextStyle(color: Colors.black)
        )),
      // darkTheme: ThemeData.dark(),
      // themeMode: ThemeMode.dark,
      onGenerateRoute: (RouteSettings settings) => RouteClass.generateRoute(settings),
      home: const SplashScreen(),
    );
  }
}

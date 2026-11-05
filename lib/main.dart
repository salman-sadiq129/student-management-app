import 'package:flutter/material.dart';
import 'package:flutter_application_1/AboutPage.dart';
import 'package:flutter_application_1/AddUserPage.dart';
import 'package:flutter_application_1/FavoritesPage.dart';
import 'package:flutter_application_1/FilesPage.dart';
import 'package:flutter_application_1/PersonInfoPage.dart';
import 'package:flutter_application_1/ReviewPostPage.dart';
import 'package:flutter_application_1/SettingsPage.dart';
import 'package:flutter_application_1/home_page.dart';
import 'package:flutter_application_1/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      routes: <String, WidgetBuilder>{
        '/person': (context) => const PersonInfoPage(
              userId: '',
              userRole: '',
              password: '',
            ),
        '/files': (context) => const FilesPage(),
        '/favorites': (context) => const FavoritesPage(),
        '/settings': (context) => const SettingsPage(),
        '/about': (context) => const AboutPage(),
        '/reviewPost': (context) => const ReviewPostPage(),
        '/addUser': (context) => const AddUserPage(
              isAdmin: true,
              userId: true,
              userRole: true,
            ),
        '/home': (context) => const AppHomePage(
              isAdmin: true,
              userId: true,
              userRole: true,
            ), // Added route for home page
      },
    );
  }
}

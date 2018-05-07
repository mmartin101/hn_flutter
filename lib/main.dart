import 'dart:async';

import 'package:flutter/material.dart';
import 'ui/app_theme.dart';
import 'ui/home_page.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  final FirebaseApp app = await FirebaseApp.configure(
      name: 'HN Flutter',
      options: const FirebaseOptions(
          googleAppID: '<create your own>',
          apiKey: '<create your own>',
          databaseURL: 'https://hacker-news.firebaseio.com'));
  runApp(new MyApp(firebaseApp: app));
}

class MyApp extends StatelessWidget {
  final FirebaseApp firebaseApp;
  MyApp({this.firebaseApp});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'HN Flutter App',
      theme: appTheme(),
      home: new HNHomePage(title: 'HN Flutter', firebaseApp: firebaseApp),
    );
  }
}

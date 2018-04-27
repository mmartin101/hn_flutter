import 'package:flutter/material.dart';
import 'ui/app_theme.dart';
import 'ui/home_page.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'HN Flutter App',
      theme: appTheme(),
      home: new HNHomePage(title: 'HN Flutter'),
    );
  }
}

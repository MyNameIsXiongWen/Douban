import 'package:flutter/material.dart';
// import 'package:hhh/splash.dart';
// import 'package:hhh/home.dart';
import 'package:hhh/view/login_view.dart';

void main() => runApp(new MaterialApp(
  title: 'Boss直聘',
  theme: new ThemeData(
    primaryIconTheme: const IconThemeData(color: Colors.white),
    primaryColor: Colors.white,
    brightness: Brightness.light,
    accentColor: Colors.cyan[300],
    appBarTheme: const AppBarTheme(
        brightness: Brightness.light,
        elevation: 0,
        textTheme: TextTheme(title: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
            color: Colors.black)
        )
    )
  ),
  home: new LoginPage(),
));

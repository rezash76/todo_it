import 'package:flutter/material.dart';

class MyTheme {
  static final light = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.orangeAccent,
    useMaterial3: true,
  );

  static final dark = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.blueGrey,
    useMaterial3: true,
  );
}

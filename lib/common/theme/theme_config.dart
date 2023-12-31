import 'package:flutter/material.dart';
import 'package:todo_it/common/language_manager.dart';

class ThemeConfig {
  static String faPrimaryFontFamily = AppFont.vazir.name;
  static String enPrimaryFontFamily = AppFont.productSans.name;
  final Brightness brightness;
  final Color primaryColor;
  final Color secondaryColor;
  final Color background;
  final Color surface;
  final Color onSurface;

  ThemeConfig.light()
      : brightness = Brightness.light,
        primaryColor = const Color.fromARGB(255, 14, 3, 54),
        secondaryColor = Colors.white,
        background = const Color.fromARGB(255, 236, 240, 250),
        surface = const Color.fromARGB(255, 230, 226, 232),
        onSurface = const Color.fromARGB(255, 14, 3, 54);

  ThemeConfig.dark()
      : brightness = Brightness.dark,
        primaryColor = Colors.white70,
        secondaryColor = const Color.fromARGB(255, 39, 39, 44),
        background = const Color.fromARGB(255, 29, 29, 32),
        surface = const Color.fromARGB(255, 18, 7, 35),
        onSurface = const Color.fromARGB(234, 244, 240, 240);

  ThemeData getTheme(String langCode) {
    return ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme(
          brightness: brightness,
          primary: primaryColor,
          onPrimary: primaryColor,
          secondary: secondaryColor,
          onSecondary: primaryColor,
          error: Colors.red,
          onError: Colors.red,
          background: background,
          onBackground: const Color.fromARGB(255, 255, 238, 0),
          surface: surface,
          onSurface: onSurface,
        ),
        appBarTheme: const AppBarTheme(
          color: Color.fromARGB(255, 5, 189, 122),
          iconTheme: IconThemeData(
            color: Color.fromARGB(255, 14, 3, 54),
          ),
        ),
        switchTheme: SwitchThemeData(
          thumbColor: MaterialStateProperty.all<Color>(Colors.white),
          trackColor: MaterialStateProperty.all<Color>(Colors.black87),
        ),
        textTheme: langCode == LanguageManager.shared.ENGLISH
            ? enPrimaryTextTheme
            : faPrimaryTextTheme);
  }

  TextTheme get enPrimaryTextTheme => TextTheme(
        titleLarge: TextStyle(
          fontFamily: enPrimaryFontFamily,
          color: primaryColor,
        ),
        titleMedium: TextStyle(
          fontFamily: enPrimaryFontFamily,
          color: primaryColor,
        ),
        titleSmall: TextStyle(
          fontFamily: enPrimaryFontFamily,
          color: primaryColor,
        ),
        labelLarge: TextStyle(
          fontFamily: enPrimaryFontFamily,
          color: secondaryColor,
        ),
        headlineLarge: TextStyle(
          fontFamily: enPrimaryFontFamily,
          color: Colors.white,
        ),
      );

  TextTheme get faPrimaryTextTheme => TextTheme(
        titleLarge: TextStyle(
          fontFamily: faPrimaryFontFamily,
          color: primaryColor,
        ),
        titleMedium: TextStyle(
          fontFamily: faPrimaryFontFamily,
          color: primaryColor,
        ),
        titleSmall: TextStyle(
          fontFamily: faPrimaryFontFamily,
          color: primaryColor,
        ),
        labelLarge: TextStyle(
          fontFamily: faPrimaryFontFamily,
          color: secondaryColor,
        ),
        headlineLarge: TextStyle(
          fontFamily: faPrimaryFontFamily,
          color: Colors.white,
        ),
      );
}

enum AppFont { productSans, vazir }

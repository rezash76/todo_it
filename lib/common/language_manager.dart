import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_it/l10n/app_localizations.dart';

class LanguageManager {
  static final shared = LanguageManager._();
  LanguageManager._();

  final String LAGUAGE_CODE = 'languageCode';
  final String ENGLISH = 'en';
  final String FARSI = 'fa';

  Future<Locale> setLocale(String languageCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(LAGUAGE_CODE, languageCode);
    return _locale(languageCode);
  }

  Future<Locale> getLocale() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String languageCode = prefs.getString(LAGUAGE_CODE) ?? FARSI;
    return _locale(languageCode);
  }

  Locale _locale(String languageCode) {
    if (languageCode == FARSI) {
      return Locale(FARSI, 'IR');
    } else {
      return Locale(ENGLISH, 'US');
    }
  }

  AppLocalizations translation(BuildContext context) {
    return AppLocalizations.of(context)!;
  }
}

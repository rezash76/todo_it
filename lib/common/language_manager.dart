import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LanguageManager {
  static final shared = LanguageManager();

  final String LAGUAGE_CODE = 'languageCode';

  final String ENGLISH = 'en';
  final String FARSI = 'fa';

  Future<Locale> setLocale(String languageCode) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setString(LAGUAGE_CODE, languageCode);
    return _locale(languageCode);
  }

  Future<Locale> getLocale() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String languageCode = _prefs.getString(LAGUAGE_CODE) ?? ENGLISH;
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

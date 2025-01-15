
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Demo_Localization.dart';

const String languageCode = 'languageCode';

Widget getProgress() {
  return const Center(child: CircularProgressIndicator());
}

Widget getNoItem(BuildContext context) {
  return Center(child: Text(getTranslated(context, 'noItem')!));
}

Future<Locale> setLocale(String languageCode1) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs.setString(languageCode, languageCode1);
  return _locale(languageCode1);
}

// Get the saved locale from SharedPreferences
Future<Locale> getLocale() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String languageCode1 = _prefs.getString(languageCode) ?? "en"; // Default to English
  return _locale(languageCode1);
}

// Map language codes to Locale objects
Locale _locale(String languageCode) {
  switch (languageCode) {
    case "en":
      return const Locale("en", 'US');
    case "ar":
      return const Locale("ar", 'KW'); // Corrected to 'NP' for Nepal
    default:
      return const Locale("en", 'US');
  }
}

// Retrieve the translated string based on the key
String? getTranslated(BuildContext context, String key) {
  final translation = DemoLocalization.of(context)?.translate(key);
  return translation ?? 'Setting'; // Handle missing translations
}




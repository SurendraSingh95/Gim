import 'dart:convert';
import 'package:flutter/services.dart';

class LanguageManager {
  // Singleton instance
  static final LanguageManager _instance = LanguageManager._internal();

  factory LanguageManager() {
    return _instance;
  }

  LanguageManager._internal();

  Map<String, String> _localizedStrings = {};

  // Method to load localization files dynamically
  Future<void> loadLanguage(String languageCode) async {
    String jsonString = await rootBundle.loadString('assets/lang/$languageCode.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localizedStrings = jsonMap.map((key, value) => MapEntry(key, value.toString()));
  }

  // Method to get the translated value
  String translate(String key) {
    return _localizedStrings[key] ?? key;
  }
}

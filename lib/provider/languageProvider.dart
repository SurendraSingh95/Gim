import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:translator/translator.dart';

class LanguageProvider extends ChangeNotifier {
  final GoogleTranslator _translator = GoogleTranslator();
  String _selectedLanguage = 'en'; // Default language is English
  late final IOClient? client;

  LanguageProvider() : client = IOClient(HttpClient()..connectionTimeout = const Duration(seconds: 10));

  String get selectedLanguage => _selectedLanguage;

  Future<String?> languageFromPrefs() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? language = prefs.getString("selectedLanguage");
    return language;
  }


  Future <void> setLanguage(String languageCode) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();

    _selectedLanguage = languageCode;
    notifyListeners();
  }
  Future<String> translate(String text) async {
    try {
      if (_selectedLanguage == 'en') {
        String? language = await languageFromPrefs();
        _selectedLanguage = language ?? _selectedLanguage;
      }

      Translation translation = await _translator.translate(text, to: _selectedLanguage);
      return translation.text;

    } catch (e) {
      // Handling the exception and printing an error message
      print("Error occurred during translation: $e");
      return "Translation error";
    }
  }




  //  Future<String> translate(String text) async {
  //   if(_selectedLanguage == 'en'){
  //    String? language =  await languageFromPrefs();
  //    _selectedLanguage = language??_selectedLanguage;
  //     Translation translation =
  //     await _translator.translate(text, to: _selectedLanguage);
  //     return translation.text;
  //   }else {
  //     Translation translation =
  //         await _translator.translate(text, to: _selectedLanguage);
  //     return translation.text;
  //   }
  // }



}
 
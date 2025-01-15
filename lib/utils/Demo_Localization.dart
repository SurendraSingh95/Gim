/*
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DemoLocalization {DemoLocalization(this.locale);

  final Locale locale;
  static DemoLocalization? of(BuildContext context) {
    return Localizations.of<DemoLocalization>(context, DemoLocalization);
  }


  static late Map<String, String> _localizedValues;

  Future<void> load() async {
    String jsonStringValues =
    await rootBundle.loadString('lib/language/${locale.languageCode}.json');
    Map<String, dynamic> mappedJson = json.decode(jsonStringValues);
    _localizedValues =
        mappedJson.map((key, value) => MapEntry(key, value.toString()));

  }
  String? translate(String key) {return _localizedValues[key];
  }

  static const LocalizationsDelegate<DemoLocalization> delegate =
  _DemoLocalizationsDelegate();
}

class _DemoLocalizationsDelegate
    extends LocalizationsDelegate<DemoLocalization> {
  const _DemoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en','ne' ]
        .contains(locale.languageCode);
  }

  @override
  Future<DemoLocalization> load(Locale locale) async {
    DemoLocalization localization = new DemoLocalization(locale);
    await localization.load();
    return localization;
  }

  @override
  bool shouldReload(LocalizationsDelegate<DemoLocalization> old) => false;
}
*/
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// DemoLocalization class to manage translation for different languages


// Define your translations by extending GetX Translations class


class DemoLocalization {
  DemoLocalization(this.locale);

  final Locale locale;

  // Static method to fetch the localized values for a given context
  static DemoLocalization? of(BuildContext context) {
    return Localizations.of<DemoLocalization>(context, DemoLocalization);
  }

  static late Map<String, String> _localizedValues;

  // Load localization files (JSON) for a specific language
  Future<void> load() async {
    String jsonStringValues = await rootBundle.loadString('lib/language/${locale.languageCode}.json');
    Map<String, dynamic> mappedJson = json.decode(jsonStringValues);
    _localizedValues = mappedJson.map((key, value) => MapEntry(key, value.toString()));
  }

  // Translate the key to the corresponding value from the loaded JSON
  String? translate(String key) {
    return _localizedValues[key];
  }

  // The delegate for the custom localization class
  static const LocalizationsDelegate<DemoLocalization> delegate = _DemoLocalizationsDelegate();
}

// Delegate class to load the language files and manage language support
class _DemoLocalizationsDelegate extends LocalizationsDelegate<DemoLocalization> {
  const _DemoLocalizationsDelegate();

  // Checks if the language is supported
  @override
  bool isSupported(Locale locale) {
    return ['en', 'ar'].contains(locale.languageCode);
  }

  // Loads the appropriate localization file for the language
  @override
  Future<DemoLocalization> load(Locale locale) async {
    DemoLocalization localization = DemoLocalization(locale);
    await localization.load();
    return localization;
  }

  // This method ensures that localization should not reload unnecessarily
  @override
  bool shouldReload(LocalizationsDelegate<DemoLocalization> old) => false;
}




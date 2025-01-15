import 'package:flutter/material.dart';
import 'TranslationService.dart';

class TranslationPage extends StatefulWidget {
  @override
  _TranslationPageState createState() => _TranslationPageState();
}

class _TranslationPageState extends State<TranslationPage> {
  final String apiKey = 'YOUR_API_KEY'; // Replace with your actual API key
  final TranslationService _translationService;
  String _translatedText = '';
  String _selectedLanguage = 'en'; // Default language
  final List<String> _languages = ['en', 'ar']; // Supported languages

  _TranslationPageState() : _translationService = TranslationService("apiKey");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Language Translator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<String>(
              value: _selectedLanguage,
              items: _languages.map((String languageCode) {
                return DropdownMenuItem<String>(
                  value: languageCode,
                  child: Text(languageCode.toUpperCase()),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedLanguage = newValue!;
                });
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Enter text to translate'),
              onSubmitted: (text) async {
                String translated = await _translationService.translate(text, _selectedLanguage);
                setState(() {
                  _translatedText = translated;
                });
              },
            ),
            SizedBox(height: 20),
            Text('Translated Text: $_translatedText'),
          ],
        ),
      ),
    );
  }
}




import 'package:fitness/colors.dart';
import 'package:fitness/custom/CstAppbarWithtextimage.dart';
import 'package:fitness/custom/CustomButton.dart';
import 'package:fitness/custom/CustomText.dart';
import 'package:fitness/custom/Fonts.dart';
import 'package:fitness/utils/Demo_Localization.dart';
import 'package:fitness/utils/shared_preferences.dart';
import 'package:fitness/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences_android/shared_preferences_android.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int? _selectedLanguageIndex;
  final List<String> _languageCodes = ['ar','en'];
  late List<String> _languages; // Declare this as a late variable

  @override
  void initState() {
    super.initState();
    _loadSelectedLanguage();
  }

  // Load selected language from the current locale
  void _loadSelectedLanguage() {
    String languageCode = Get.locale?.languageCode ?? 'ar';
    setState(() {
      _selectedLanguageIndex = _languageCodes.indexOf(languageCode);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Get.theme.brightness == Brightness.dark;

    _languages = [
      "Arabic" ,"English",
    ];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 30),
            CstAppbarWithtextimage(
              title: DemoLocalization.of(context)!.translate('Change_Language').toString(),
              icon: Icons.arrow_back_ios,
              fontFamily: Fonts.arial,
              onImageTap: () {
                Get.back();
              },
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _languages.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(8.0),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _selectedLanguageIndex = index;
                            String selectedLanguageCode = _languageCodes[_selectedLanguageIndex!];
                            _changeLanguage(selectedLanguageCode);
                            SharedPref.setLanguageToPrefs(selectedLanguageCode);
                          });
                        },
                        borderRadius: BorderRadius.circular(8.0),
                        child: Container(
                          padding:  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                          decoration: BoxDecoration(
                            color: isDarkMode ?  FitnessColor.colorsociallogintext:_selectedLanguageIndex == index ? Colors.blue.withOpacity(0.1) : Colors.transparent,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                color: isDarkMode ?Colors.grey: Colors.grey.withOpacity(0.1),
                                blurRadius: 2.0,
                                spreadRadius: 1.0,
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Icon(
                                _selectedLanguageIndex == index
                                    ? Icons.radio_button_checked
                                    : Icons.radio_button_unchecked,
                                color:  isDarkMode ?FitnessColor.white : _selectedLanguageIndex == index
                                    ? FitnessColor.primary
                                    : Colors.grey,
                              ),
                              const SizedBox(width: 12),

                              CustomText(text: _languages[index], fontSize: 5,fontFamily: Fonts.arial,)

                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomButton(
                text: DemoLocalization.of(context)!.translate('Submit').toString(),
                onPressed: () {
                  Get.back();

                  Utils.mySnackBar(
                    title: DemoLocalization.of(context)!.translate('Language').toString(),
                    msg: DemoLocalization.of(context)!.translate('LanguageSuccess').toString(),
                  );
                },
                fontFamily: "",
                color: FitnessColor.primary,
                height: 50,
                borderRadius: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to change the app's language
  void _changeLanguage(String languageCode) {
    Locale newLocale = Locale(languageCode, languageCode == 'ar' ? 'US' : 'KW');
    Get.updateLocale(newLocale);
  }
}


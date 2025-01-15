import 'package:fitness/Controllers/HomeController/change_themes_controller.dart';
import 'package:fitness/colors.dart';
import 'package:fitness/custom/CstAppbarWithtextimage.dart';
import 'package:fitness/custom/CustomText.dart';
import 'package:fitness/custom/Fonts.dart';
import 'package:fitness/utils/Demo_Localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangeThemesScreen extends StatelessWidget {
  final ThemeController themeController = Get.find();

   ChangeThemesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? FitnessColor.primary : FitnessColor.white,

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    Get.back();
                  },
                ),
                const SizedBox(width: 10),
                CustomText(
                  text: DemoLocalization.of(context)!
                      .translate('CHOOSE_THEME')
                      .toString(),
                  fontSize: 4.5,
                  color: FitnessColor.primary,
                  fontFamily: Fonts.arial,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
            const SizedBox(height: 30),
            CustomText(
              text: DemoLocalization.of(context)!
                  .translate('CHOOSE_THEME')
                  .toString(),
              fontSize: 4.5,
              color: FitnessColor.primary,
              fontFamily: Fonts.arial,
              fontWeight: FontWeight.bold,
            ),

            const SizedBox(height: 20),
            Obx(
                  () => Card(
                    color: isDarkMode ?  FitnessColor.colorsociallogintext : FitnessColor.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(text:  themeController.isDarkMode.value
                          ?  DemoLocalization.of(context)!.translate('DARK_MODE').toString()
                          : DemoLocalization.of(context)!.translate('LIGHT_MODE').toString(),fontSize: 5),
                      Switch(
                        value: themeController.isDarkMode.value,
                        onChanged: (value) {
                          themeController.toggleTheme();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

    );
  }
}

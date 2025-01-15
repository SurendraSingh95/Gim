import 'package:fitness/PurChaseProgram/StartNowSecond.dart';
import 'package:fitness/Screens/question_answer_screen.dart';
import 'package:fitness/auth/LoginScreen.dart';
import 'package:fitness/auth/settings_page.dart';
import 'package:flutter/material.dart';
import '../colors.dart';
import '../custom/CustomButton.dart';
import '../custom/CustomText.dart';
import '../custom/Fonts.dart';
import '../utils/Demo_Localization.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {


  getLanguageCode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    languageCode = prefs.getString("languageCode");

  }
   String? languageCode;
  @override
  Widget build(BuildContext context) {

    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? FitnessColor.primary:FitnessColor.white,

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomButton(
                    width: languageCode == null || languageCode!.isEmpty ? 70 : (languageCode == "ar" ? 70 : 140),
                    height: 30,
                    text: DemoLocalization.of(context)!.translate('Change_Language').toString(),
                    onPressed: () {
                      Get.to(() => const SettingsPage())?.then((value) async {
                        await getLanguageCode();
                        setState(() {});
                      });
                    },
                    fontFamily: Fonts.arial,
                  )


                ],
              ),

              const SizedBox(height: 50),
              Container(
                height: 140,
                // width: 120,
                child: Image.asset(
                  "assets/images/logo.png",
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),

              CustomText1(text: DemoLocalization.of(context)!.translate('TakeYour').toString(),//"Take your running to the next level",
                  fontSize: 6,
                  textAlign: TextAlign.center,
                  color: FitnessColor.colorTextPrimary,
                  fontWeight: FontWeight.normal,
                  fontFamily: Fonts.arial //Fonts.arial,
                  ),
              const SizedBox(height: 5),
              CustomText1(text:DemoLocalization.of(context)!.translate('Onceyou').toString(),
                     // "Once you complete a run with FTB, you can see your mileage, stats, and achievements here.",
                  fontSize: 3.5,
                  textAlign: TextAlign.center,
                  color: FitnessColor.colorTextThird,
                  fontWeight: FontWeight.normal,
                  fontFamily: Fonts.arial),
              const SizedBox(height: 20),
              CustomText1(
                textAlign: TextAlign.center,
                text: DemoLocalization.of(context)!.translate('Lets').toString(),//"Let's log some miles!",
                fontSize: 3.5,
                color: FitnessColor.colorTextThird,
                fontWeight: FontWeight.normal,

                fontFamily: Fonts.arial,),
              const SizedBox(height: 20),
              // Spacer(),
              CustomButton(
                text: DemoLocalization.of(context)!.translate('RecordRun').toString(),//'Record Run',
                fontFamily: Fonts.arial,
                fontSize: 22,
                color: FitnessColor.colorTextThird,
                onPressed: () {
                  Get.to(() => const StartNowSecond());
                  //  Get.to(() => const QuestionAnswerScreen());
                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (context) =>  OnboardingScreen()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

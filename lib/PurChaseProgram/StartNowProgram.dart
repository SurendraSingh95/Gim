import 'dart:io';

import 'package:fitness/Screens/question_answer_screen.dart';
import 'package:fitness/auth/LoginScreen.dart';
import 'package:fitness/auth/settings_page.dart';
import 'package:fitness/utils/Demo_Localization.dart';
import 'package:flutter/material.dart';
import '../colors.dart';
import '../custom/CustomButton.dart';
import '../custom/CustomText.dart';
import '../custom/Fonts.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StartNowProgram extends StatefulWidget {
  const StartNowProgram({super.key});

  @override
  State<StartNowProgram> createState() => _StartNowProgramState();
}

class _StartNowProgramState extends State<StartNowProgram> {
  @override


  @override
  void initState() {
    getLanguageCode();
    super.initState();
  }
  getLanguageCode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    languageCode = prefs.getString("languageCode");

    setState(() {
    });

  }
  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Row(
          children: [
            Icon(
              Icons.exit_to_app,
              color: Colors.redAccent,
            ),
            SizedBox(width: 10),
            Text(
              'Exit App',
              style: TextStyle(
                color: Colors.redAccent,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
        content: const Text(
          'Are you sure you want to exit the app?',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 16,
          ),
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.grey[200],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () => Navigator.of(context).pop(false),
            // Dismiss dialog
            child: Text(
              'Cancel',
              style: TextStyle(
                color: Colors.grey[800],
              ),
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.redAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () => exit(0),
            child: const Text(
              'Exit',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    )) ??
        false;
  }
  String? languageCode;
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final screenSize = MediaQuery.of(context).size;
    return  PopScope(
      //  canPop: false,
      // onPopInvoked: (val) async {
      //   _onWillPop();
      // },
      child: Scaffold(
        backgroundColor: isDarkMode ? FitnessColor.primary:FitnessColor.white,

        body:SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomButton(
                          width:languageCode == "en" ? 70 : 100,
                          height: 35,
                          text:DemoLocalization.of(context)!.translate('LOG_IN').toString(), onPressed: (){
                        getLanguageCode();
                            setState(() {

                            });
                            Get.to(()=>const LoginScreen());
                      }, fontFamily: Fonts.arial),
                      CustomButton(
                        width: languageCode == "en" ? 150 : 70,
                        height: 35,
                        text: DemoLocalization.of(context)!.translate('Change_Language').toString(),
                        onPressed: () {
                          Get.to(() => const SettingsPage())?.then((value) async {
                            getLanguageCode();
                               setState(() {
                               });
                          });
                        },
                        fontFamily: Fonts.arial,
                      )

                    ],
                  ),
                ),
                 SizedBox(height:MediaQuery.of(context).size.height*0.05),
                CustomText1(
                  text:DemoLocalization.of(context)!.translate('Get_your_personal').toString(),
                  fontSize: 7.0,
                  textAlign: TextAlign.center,
                  color: FitnessColor.colorTextFour,
                  fontWeight: FontWeight.w400,
                  fontFamily: Fonts.arial,
                ),

                const SizedBox(height: 12),
                CustomText1(
                  text:DemoLocalization.of(context)!.translate('it just takes a minute.').toString(),
                  fontSize: 4.5,
                  color: FitnessColor.colorTextThird,
                  fontWeight: FontWeight.normal,
                  fontFamily: Fonts.arial,
                ),

                Center(
                  child: Image.asset('assets/images/frame_get_start.png',width: MediaQuery.of(context).size.width/1.5,height: MediaQuery.of(context).size.height/2),
                ),
                //  const SizedBox(height: 18),
                SizedBox(height: screenSize.height/16),
                Center(
                  child: CustomButton(
                    text:DemoLocalization.of(context)!.translate('STARTNOW').toString().toUpperCase(),
                    fontFamily:Fonts.arial,
                    fontSize: 22,
                    letterSpacing: 2.0,
                    color: FitnessColor.colorTextThird,
                    onPressed:(){
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context) => const QuestionAnswerScreen()));

                    },
                  ),
                ),
                const SizedBox(height: 5),
              ],
            ),
          ),
        ) ,
      ),
    );
  }
}



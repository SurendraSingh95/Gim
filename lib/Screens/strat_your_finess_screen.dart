import 'dart:io';

import 'package:fitness/PurChaseProgram/StartNowProgram.dart';
import 'package:fitness/auth/LoginScreen.dart';
import 'package:fitness/colors.dart';
import 'package:fitness/custom/CustomButton.dart';
import 'package:fitness/custom/CustomText.dart';
import 'package:fitness/utils/Demo_Localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../custom/Fonts.dart';
import 'package:get/get.dart';

class StartYourFitnessScreen extends StatefulWidget {
  const StartYourFitnessScreen({Key? key}) : super(key: key);

  @override
  State<StartYourFitnessScreen> createState() => _StartYourFitnessScreenState();
}

class _StartYourFitnessScreenState extends State<StartYourFitnessScreen> {
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
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (val) async {
        _onWillPop();
      },
      child: Scaffold(
        backgroundColor: FitnessColor.white,
        bottomSheet:  CustomButton(
          height: 50,
          width:200,
          text: DemoLocalization.of(context)!.translate('Next').toString(), onPressed:(){
             Get.to(()=>const StartNowProgram());
            }, fontFamily:Fonts.arial,


          fontSize: 15,
        ),
        body: Column(

          children: [
            const SizedBox(height: 25,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(
                    width:languageCode == 'en' ? 70 : 100,
                      height: 35,
                      text:DemoLocalization.of(context)!.translate('LOG_IN').toString(), onPressed: (){
                    Get.to(()=>const LoginScreen());
                  }, fontFamily: Fonts.arial),
                  Image.asset("assets/images/logo.png",height: 45, width: 45,),

                ],
              ),
            ),

            const SizedBox(height: 50,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomText1(
                text:DemoLocalization.of(context)!.translate('Start_your_fitness').toString().toUpperCase(),
                fontSize: 8.0,
                textAlign: TextAlign.center,
                color: FitnessColor.colorTextFour,
                fontWeight: FontWeight.bold,
                fontFamily: Fonts.arial,
              ),
            ),
            const SizedBox(height: 20,),

            CustomButton(
              height: 50,
              width:200,
                text: DemoLocalization.of(context)!.translate('PURCHASE_PROGRAM').toString(), onPressed:(){
            }, fontFamily:Fonts.arial,


            fontSize: 15,
            ),
            const SizedBox(height: 20,),

            Image.asset("assets/images/start_logo.png",),



          ],
        ),
      ),
    );
  }
}


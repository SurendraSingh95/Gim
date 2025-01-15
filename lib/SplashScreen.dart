import 'dart:async';


import 'package:fitness/Screens/strat_your_finess_screen.dart';
import 'package:fitness/colors.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Screens/home_screen.dart';
import 'auth/LoginScreen.dart';
import 'bottomdrawer/ActivityScreen.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? userId;


  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
     // Get.to(()=> const ActivityScreen());
     // Get.to(()=> const StartYourFitnessScreen());
      Get.to(()=> const StartYourFitnessScreen());
      //getLogin();
    });
  }

  getLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString("userId");
    if(userId == null || userId == ''){
       Get.to(()=> const StartYourFitnessScreen());
     // Get.to(()=> const LoginScreen());

     // Navigator.push(context, MaterialPageRoute(builder: (context)=> const LoginScreen()));
    }else{
      Get.to(()=>const HomeScreen());
        //Navigator.push(context, MaterialPageRoute(builder: (context)=> const MyHomePage(title: 'Home')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FitnessColor.colorfillBOx,
        body: Center(
        child: Image.asset('assets/images/logo.png',width: MediaQuery.of(context).size.width/1.5,height: MediaQuery.of(context).size.height/2),
    ));
  }

}

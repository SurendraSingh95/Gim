import 'package:fitness/Screens/select_trainer_screen.dart';
import 'package:flutter/material.dart';
import '../colors.dart';
import '../custom/CstAppbarWithtextimage.dart';
import '../custom/CustomButton.dart';

import '../custom/Fonts.dart';
import '../utils/Demo_Localization.dart';
import 'package:get/get.dart';
class StartNowSecond extends StatefulWidget {
  const StartNowSecond({super.key});

  @override
  State<StartNowSecond> createState() => _StartNowSecondState();
}



class _StartNowSecondState extends State<StartNowSecond> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;


    return  Scaffold(
      body:SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 0.0 ,top: 16),
                child: CstAppbarWithtextimage(
                  title: DemoLocalization.of(context)!.translate('BecomeAMember').toString(),
                  icon: Icons.arrow_back_ios,
                  fontFamily: Fonts.arial,
                    onImageTap: (){
                     Get.back();
                    }
                ),
              ),

               SizedBox(height:MediaQuery.of(context).size.height*0.05),

              Center(
                child: Image.asset('assets/images/start2.png',width: MediaQuery.of(context).size.width/1.5,height: MediaQuery.of(context).size.height/2),
              ),
              //  const SizedBox(height: 18),
              SizedBox(height: screenSize.height/16),
              Center(
                child: CustomButton(
                  text: DemoLocalization.of(context)!.translate('STARTNOW').toString().toUpperCase(),//'START NOW'.toUpperCase(),
                  fontFamily:Fonts.arial,
                  fontSize: 22,
                  letterSpacing: 2.0,
                  color: FitnessColor.colorTextThird,
                  onPressed:(){
                    Get.to(()=>const SelectTrainerScreen());

                  },
                ),
              ),
              const SizedBox(height: 5),
            ],
          ),
        ),
      ) ,
    );
  }
}



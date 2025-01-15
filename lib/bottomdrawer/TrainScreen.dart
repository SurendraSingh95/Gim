import 'package:fitness/auth/sign_out_screen.dart';
import 'package:flutter/material.dart';
import '../colors.dart';
import '../custom/CstAppbarWithtextimage.dart';
import '../custom/CustomButton.dart';
import '../custom/CustomText.dart';
import '../custom/Fonts.dart';
import 'package:page_transition/page_transition.dart';
import '../question/QuestionStart.dart';
import '../utils/Demo_Localization.dart';

class TrainScreen extends StatefulWidget {
  const TrainScreen({super.key});

  @override
  State<TrainScreen> createState() => _TrainScreenState();
}

class _TrainScreenState extends State<TrainScreen> {
  List RandomImages = [
    'https://images.unsplash.com/photo-1597223557154-721c1cecc4b0?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8aHVtYW4lMjBmYWNlfGVufDB8fDB8fA%3D%3D&w=1000&q=80',
    'https://img.freepik.com/free-photo/portrait-white-man-isolated_53876-40306.jpg',
    'https://images.unsplash.com/photo-1542909168-82c3e7fdca5c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8ZmFjZXxlbnwwfHwwfHw%3D&w=1000&q=80',
    'https://i0.wp.com/post.medicalnewstoday.com/wp-content/uploads/sites/3/2020/03/GettyImages-1092658864_hero-1024x575.jpg?w=1155&h=1528'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16, top: 16),
                child:
                //CustomWidgetImage(title: 'Support', imageAsset: 'assets/images/logo.png',fontFamily: Fonts.arial, onTextTap: () {})
                CstAppbarWithtextimage(
                  title: DemoLocalization.of(context)!.translate('Train').toString(),//'Train',
                  icon: Icons.arrow_back_ios,
                  fontFamily: Fonts.arial,
                  imageAsset: "assets/images/logo.png",
                  onImageTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: const SignOutScreen(),
                          inheritTheme: true,
                          ctx: context),
                    );
                    //Navigator.push(context,createRoute(),);
                  },
                ),
              ),
              SizedBox(height: 20),
              // Navigator.push(context, _createRoute());
             // Padding(
                // padding: const EdgeInsets.only(left: 16.0, right: 16, top: 16),
            /*    CstAppbarWithtextimage(
                  title: 'Train',
                  icon: Icons.arrow_back_ios,
                  fontFamily: Fonts.arial,
                    onImageTap: (){

                    }
                ),
           //   ),
              SizedBox(height: 30),*/
              Container(
                height: 140,
               // width: 120,
                child: Image.asset(
                  "assets/images/logo.png",
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 20),

              CustomText(
                  text: "Hey, UserName",
                  fontSize: 6,
                  textAlign: TextAlign.center,
                  color: FitnessColor.colorTextPrimary,
                  fontWeight: FontWeight.normal,
                  fontFamily: Fonts.arial //Fonts.arial,
                  ),
              SizedBox(height: 5),
              CustomText(
                  text: DemoLocalization.of(context)!.translate('TakeYour').toString(),//"Take your running to the next level",
                  fontSize: 6,
                  textAlign: TextAlign.center,
                  color: FitnessColor.colorTextPrimary,
                  fontWeight: FontWeight.normal,
                  fontFamily: Fonts.arial //Fonts.arial,
                  ),
              SizedBox(height: 20),
              CustomText(
                textAlign: TextAlign.center,
                text:DemoLocalization.of(context)!.translate('GetStartedby').toString(),//"Get started by creating your first personalized training plan",
                fontSize: 3.5,
                color: FitnessColor.colorTextThird,
                fontWeight: FontWeight.normal,
                fontFamily: Fonts.arial,
              ),
              SizedBox(height: 20),
              CustomButton(
                text: DemoLocalization.of(context)!.translate('GetStarted').toString(),//'Get Started',
                fontFamily: Fonts.arial,
                fontSize: 22,
                color: FitnessColor.colorTextThird,
                onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder:(context) => QuestionStart()));
                },
              ),
              SizedBox(height: 20),
            Container(
              // parent row
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < RandomImages.length; i++)
                    Align(
                      widthFactor: 0.2,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(RandomImages[i]),
                      ),
                    )
                ],
              ),
            ),

              SizedBox(height: 10),
              CustomText(
                textAlign: TextAlign.center,
                text: DemoLocalization.of(context)!.translate('Jointh').toString(),//"Join thousands of FTB \ using plans now",
                fontSize: 3.5,
                color: FitnessColor.colorTextThird,
                fontWeight: FontWeight.normal,
                fontFamily: Fonts.arial,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*
import 'package:fitness/onbordingpage/OnboardingPageFour.dart';
import 'package:fitness/onbordingpage/OnboardingPageSecond.dart';
import 'package:fitness/onbordingpage/OnboardingPageThird.dart';
import 'package:flutter/material.dart';
import '../colors.dart';
import '../custom/CustomText.dart';
import '../custom/CustomWidget.dart';
import '../custom/Fonts.dart';
import '../utils/Demo_Localization.dart';
import 'OnboardingPage.dart';
import 'OnboardingPageEight.dart';
import 'OnboardingPageEleven.dart';
import 'OnboardingPageFive.dart';
import 'OnboardingPageFourteen.dart';
import 'OnboardingPageNine.dart';
import 'OnboardingPageSeven.dart';
import 'OnboardingPageSix.dart';
import 'OnboardingPageTen.dart';
import 'OnboardingPageThirteen.dart';
import 'OnboardingPageTwelve.dart';


class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController _pageController = PageController(initialPage: 0);

  int _currentPage = 0;
  final List<Map<String, String>> fitnessGoals = [
    {
      'title': 'Lose Weight',
      'image': 'assets/images/fimg1.png', // replace with actual image path
    },
    {
      'title': 'Get Fitter And Tone Muscle',
      'image': 'assets/images/fimg2.png', // replace with actual image path
    },
    {
      'title': 'Increase Muscle Atrength And Size',
      'image': 'assets/images/fimg3.png', // replace with actual image path
    },
    // Add more items as needed
  ];
  List<Widget> _buildPages() {
    return [
      OnboardingPage(),
      OnboardingPageSecond(),
      OnboardingPageThird(),
      OnboardingPageFour(),
      OnboardingPageFive(),
      OnboardingPageSix(),
      OnboardingPageSeven(),
      OnboardingPageEight(),
      OnboardingPageNine(),
      OnboardingPageTen(),
      OnboardingPageEleven(),
      OnboardingPageTwelve(),
      OnboardingPageThirteen(),
      OnboardingPageFourteen(),

    ];
  }

  Widget _buildPage({required String title,

    required String image,
    required VoidCallback buttonAction,required bool isFullWidth,    required bool isRectangle,

  }) {
    return
      Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                const CustomTextWidget(title: "",fontFamily: Fonts.arial,icon: Icons.arrow_back_ios,imageAsset: ""),
                const SizedBox(height: 20),
                CustomText(
                  text:DemoLocalization.of(context)!.translate('WhatisyourFitnessgoal').toString(), //"What's your Fitness goal?",
                  fontSize: 7.0,
                  color: FitnessColor.colorTextFour,
                  fontWeight: FontWeight.bold,
                  fontFamily: Fonts.arial,
                  textAlign: TextAlign.start,
                ),
                ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: fitnessGoals.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {

                    return Card(
                      color: Colors.black,
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      elevation: 4,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.15, // Adjust the height as needed
                        child: InkWell(
                          onTap: () {
                            // Handle card tap
                          },
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    fitnessGoals[index][title].toString(),
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontFamily: Fonts.arial,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),

                            ]
                          ),
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return
      Scaffold(
        backgroundColor: isDarkMode ? FitnessColor.primary:FitnessColor.white,

        body: PageView(
          controller: _pageController,
          onPageChanged: (int page) {
            setState(() {
              _currentPage = page;
            });
          },
          children: _buildPages(),
        ),
      );
  }
}
*/




/*import 'package:fitness/Controllers/Question%20Controller/question_controller.dart';
import 'package:fitness/Model/get_question_model.dart';
import 'package:fitness/colors.dart';
import 'package:fitness/custom/CustomText.dart';
import 'package:fitness/custom/Fonts.dart';
import 'package:fitness/custom/my_shimmer.dart';
import 'package:fitness/utils/Demo_Localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuestionAnswerScreen extends StatefulWidget {
  const QuestionAnswerScreen({super.key});

  @override
  _QuestionAnswerScreenState createState() => _QuestionAnswerScreenState();
}

class _QuestionAnswerScreenState extends State<QuestionAnswerScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  final QuestionController questionController = Get.put(QuestionController());
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    questionController.getQuestionApi();

  }

  /// Build Page Content for Each Question
  Widget _buildPageContent(QuestionList question) {
    final Size screenSize = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Question text
          Center(
            child: CustomText(text:question.questionText ?? '' , fontSize: 5,fontFamily: Fonts.arial,),
          ),
          const SizedBox(height: 20),

          // Display answers as cards
          ...question.answers.map((answer) {
            return Card(
              color: FitnessColor.white,
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              elevation: 4,
              child: SizedBox(
                height: screenSize.height * 0.15, // Adjust the height as needed
                child: InkWell(
                  onTap: () {
                    // Handle card tap
                  },
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: CustomText(text:answer.value ?? 'No Value' , fontSize: 5,fontFamily: Fonts.arial,color: FitnessColor.white,)
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: Container(
                          width: screenSize.height * 0.15, // Make the image container square
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10.0),
                              bottomRight: Radius.circular(10.0),
                            ),
                            image: DecorationImage(
                              image: AssetImage('assets/images/fimg2.png'),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );

          }).toList(),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? FitnessColor.primary:FitnessColor.white,
    appBar: AppBar(
      backgroundColor: isDarkMode ? FitnessColor.primary:FitnessColor.white,

      centerTitle: true,
        leading: InkWell(
          onTap: (){
            Get.back();
          },
            child: const Icon(Icons.arrow_back_ios_new_sharp)),
      title: CustomText(text: "Questions/Answers", fontSize: 5,fontFamily: Fonts.arial,),

    ),
      body: Obx(() {
        if (questionController.isLoading.value) {
          return  Center(child: myShimmer());
        }

        if (questionController.questionList.isEmpty) {
          return Center(
              child: CustomText1(text: DemoLocalization.of(context)!.translate('No_data_found').toString(), fontSize: 4,fontFamily: Fonts.arial,)
          );
        }

        return PageView.builder(
          controller: _pageController,
          itemCount: questionController.questionList.length,
          onPageChanged: (int page) {
            setState(() {
              currentPage = page;
            });
          },
          itemBuilder: (context, index) {
            return _buildPageContent(questionController.questionList[index]);
          },
        );
      }),
    );
  }
}*/




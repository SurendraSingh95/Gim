import 'package:fitness/Controllers/Question%20Controller/question_controller.dart';
import 'package:fitness/Model/get_question_model.dart';
import 'package:fitness/PurChaseProgram/StartNowSecond.dart';
import 'package:fitness/Screens/select_trainer_screen.dart';
import 'package:fitness/Utils/utils.dart';
import 'package:fitness/colors.dart';
import 'package:fitness/custom/CustomButton.dart';
import 'package:fitness/custom/CustomText.dart';
import 'package:fitness/custom/Fonts.dart';
import 'package:fitness/custom/my_shimmer.dart';
import 'package:fitness/score/ScoreScreen.dart';
import 'package:fitness/utils/Demo_Localization.dart';
import 'package:fitness/utils/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuestionAnswerScreen extends StatefulWidget {
  const QuestionAnswerScreen({super.key});

  @override
  _QuestionAnswerScreenState createState() => _QuestionAnswerScreenState();
}

/// normal code
// class _QuestionAnswerScreenState extends State<QuestionAnswerScreen> {
//   final PageController _pageController = PageController(initialPage: 0);
//   final QuestionController questionController = Get.put(QuestionController());
//   int currentPage = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     questionController.getQuestionApi();
//   }
//
//
//   List<dynamic> selectedValues = [];
//
//   /// Build Page Content for Each Question
//   Widget _buildPageContent(QuestionList question) {
//     final Size screenSize = MediaQuery.of(context).size;
//
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Question text
//           Center(
//             child: CustomText(
//               text: question.questionText ?? '',
//               fontSize: 6,
//               fontFamily: Fonts.arial,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const SizedBox(height: 20),
//
//
//           ...question.answers.asMap().entries.map((entry) {
//             dynamic index = entry.key;
//             Answer answer = entry.value;
//
//             return Card(
//               color: FitnessColor.white,
//               margin: const EdgeInsets.symmetric(vertical: 10.0),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20.0),
//                 side: BorderSide(
//                   width: 2,
//                   color: selectedValues.contains(index)
//                       ? Colors.black
//                       : Colors.grey,
//                 ),
//               ),
//               elevation: 4,
//               child: SizedBox(
//                 height: screenSize.height * 0.15,
//                 child: InkWell(
//                   onTap: () {
//                     setState(() {
//                      selectedValues.add(answer.key ?? '');
//                     });
//                     print("Selected Values: ${selectedValues.join(', ')}");
//                   },
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: Padding(
//                           padding: const EdgeInsets.all(16.0),
//                           child: CustomText(
//                             text: answer.value!.answer ?? 'No Value',
//                             fontSize: 5,
//                             fontFamily: Fonts.arial,
//                             color: FitnessColor.white,
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(right: 12.0),
//                         child: Container(
//                           width: screenSize.height * 0.15,
//                           decoration: BoxDecoration(
//                             borderRadius: const BorderRadius.only(
//                               topRight: Radius.circular(10.0),
//                               bottomRight: Radius.circular(10.0),
//                             ),
//                             image: DecorationImage(
//                               image: (answer.value.image != null && answer.value.image!.isNotEmpty)
//                                   ? NetworkImage("https://tfbfitness.com/${answer.value.image}")
//                                   : const AssetImage('assets/images/no_image.png')
//                               as ImageProvider,
//                               fit: BoxFit.fill,
//                             ),
//                           ),
//                         ),
//                       )
//
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           }).toList()
//         ],
//       ),
//     );
//   }
//
//   Widget _buildBottomButtons() {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           if (currentPage > 0)
//             CustomButton(
//               height: 30,
//               width: 50,
//               text: "Back",
//               onPressed: () {
//                 setState(() {
//                   currentPage--;
//                   _pageController.previousPage(
//                     duration: const Duration(milliseconds: 300),
//                     curve: Curves.ease,
//                   );
//                 });
//               },
//               fontFamily: Fonts.arial,
//             ),
//
//           if (currentPage < questionController.questionList.length - 1)
//             CustomButton(
//               height: 30,
//               width: 50,
//               text: "Next",
//               onPressed: () {
//                 setState(() {
//                   currentPage++;
//                   _pageController.nextPage(
//                     duration: const Duration(milliseconds: 300),
//                     curve: Curves.ease,
//                   );
//                 });
//               },
//               fontFamily: Fonts.arial,
//             ),
//
//           if (currentPage == questionController.questionList.length - 1)
//             CustomButton(
//               height: 30,
//               width: 60,
//               text: "Finish",
//               onPressed: () {
//                 Get.to(() => const StartNowSecond());
//               },
//               fontFamily: Fonts.arial,
//             ),
//         ],
//       ),
//     );
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
//
//     return RefreshIndicator(
//       onRefresh: ()async{
//         setState(() {
//           questionController.getQuestionApi();
//         });
//       },
//       child: Scaffold(
//         backgroundColor: isDarkMode ? FitnessColor.primary : FitnessColor.white,
//         appBar: AppBar(
//           backgroundColor: isDarkMode ? FitnessColor.primary : FitnessColor.white,
//           centerTitle: true,
//           leading: InkWell(
//               onTap: () {
//                 Get.back();
//               },
//               child: const Icon(Icons.arrow_back_ios_new_sharp)),
//           title: CustomText(
//             text:DemoLocalization.of(context)!.translate('Question/Answer').toString(),
//             fontSize: 5,
//             fontFamily: Fonts.arial,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         body: Obx(() {
//           if (questionController.isLoading.value) {
//             return Center(child: myShimmer());
//           }
//
//           if (questionController.questionList.isEmpty) {
//             return Center(
//               child: CustomText1(
//                 text: DemoLocalization.of(context)!.translate('No_data_found').toString(),
//                 fontSize: 4,
//                 fontFamily: Fonts.arial,
//               ),
//             );
//           }
//
//           return PageView.builder(
//             controller: _pageController,
//             itemCount: questionController.questionList.length,
//             onPageChanged: (int page) {
//               setState(() {
//                 currentPage = page;
//               });
//             },
//             itemBuilder: (context, index) {
//               return _buildPageContent(questionController.questionList[index]);
//             },
//           );
//         }),
//
//         // Bottom buttons
//         bottomNavigationBar: _buildBottomButtons(),
//       ),
//     );
//   }
// }F

/// add progress line
class _QuestionAnswerScreenState extends State<QuestionAnswerScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  final QuestionController questionController = Get.put(QuestionController());
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    await questionController.getQuestionApi();
    if (questionController.questionList.isNotEmpty) {
      for (var q in questionController.questionList) {
        selectedValues['${q.id}'] = -1;
      }
    }
  }

  Map<String, int> selectedValues = {};

  /// Build Page Content for Each Question
  // Widget _buildPageContent(QuestionList question) {
  //   bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
  //
  //   final Size screenSize = MediaQuery.of(context).size;
  //
  //   return Padding(
  //     padding: const EdgeInsets.all(16.0),
  //     child: ListView(
  //       //crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         // Question text
  //         Card(
  //           color: FitnessColor.colorsociallogintext,
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(10.0),
  //             side: const  BorderSide(
  //               width: 2,
  //               color:  FitnessColor.colorsociallogintext,
  //             ),
  //           ),
  //           elevation: 4,
  //           child:Padding(
  //             padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
  //             child: CustomText2(text: question.cateName ?? "", fontSize: 5,fontFamily: Fonts.arial,),
  //           ),
  //         ),
  //         const SizedBox(height: 10,),
  //         Padding(
  //           padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 0),
  //           child: CustomText(text: question.questionText ?? "", fontSize: 4.5,fontFamily: Fonts.arial,color: FitnessColor.white),
  //         ),
  //
  //         ...question.answers.asMap().entries.map((entry) {
  //
  //           Answer answer = entry.value;
  //           return Card(
  //             color: FitnessColor.primary,
  //             margin: const EdgeInsets.symmetric(vertical: 8.0),
  //             shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(15.0),
  //               side: BorderSide(
  //                 width: 2,
  //                 color: selectedValues['${question.id}'] == answer.key
  //                     ? Colors.red
  //                     : FitnessColor.colorsociallogintext,
  //               ),
  //             ),
  //             elevation: 4,
  //             child: SizedBox(
  //               height: screenSize.height * 0.17,
  //               child: InkWell(
  //                 onTap: () {
  //
  //                    if(answer.key != null) {
  //
  //                       setState(() {
  //                         selectedValues['${question.id}'] = answer.key!;
  //                       });
  //
  //                   }
  //
  //                   print("Selected Values: ${selectedValues.values.join(',')}");
  //                   print("Selected Values: $entry}");
  //                 },
  //                 child: Row(
  //                   // mainAxisAlignment: MainAxisAlignment.end,
  //                   children: [
  //                     Expanded(
  //                       child: Padding(
  //                         padding: const EdgeInsets.symmetric(horizontal: 10),
  //                         child: CustomText2(
  //                           text: answer.value!.answer ??'' ,
  //                           fontSize: 4,
  //                           fontFamily: Fonts.arial,
  //                           color:FitnessColor.white,
  //                         ),
  //                       ),
  //                     ),
  //
  //                     Padding(
  //                       padding:  const EdgeInsets.all(10),
  //                       child: Card(
  //                         elevation: 2,
  //                         child: Container(
  //                           width: screenSize.width * 0.35,
  //                           height: screenSize.height * 0.35,
  //
  //                           decoration: BoxDecoration(
  //                            // color: FitnessColor.white,
  //                             border: Border.all(color: FitnessColor.white),
  //                             borderRadius: const BorderRadius.all(Radius.circular(10)),
  //                             image: DecorationImage(
  //                               image: (
  //                                   answer.value.image != null &&
  //                                   answer.value.image!.isNotEmpty)
  //                                   ? NetworkImage("https://tfbfitness.com/${answer.value.image}")
  //                                   :  const AssetImage('assets/images/no_image.png')
  //                               as ImageProvider,
  //                               fit: BoxFit.fill,
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           );
  //         }).toList(),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildPageContent(QuestionList question) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final Size screenSize = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          // Question text
          Card(
            color: FitnessColor.colorsociallogintext,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: const BorderSide(
                width: 2,
                color: FitnessColor.colorsociallogintext,
              ),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: CustomText2(
                  text: question.cateName ?? "",
                  fontSize: 5,
                  fontFamily: Fonts.arial),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
            child: CustomText(
                text: question.questionText ?? "",
                fontSize: 5,
                fontFamily: Fonts.arial,
                color: FitnessColor.white),
          ),
          ...question.answers.asMap().entries.map((entry) {
            Answer answer = entry.value;
            return Card(
              color: FitnessColor.primary,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
                side: BorderSide(
                  width: 2,
                  color: selectedValues['${question.id}'] == answer.key
                      ? Colors.red
                      : FitnessColor.colorsociallogintext,
                ),
              ),
              elevation: 4,
              child: SizedBox(
                  height:
                      answer.value.image == null || answer.value.image.isEmpty
                          ? screenSize.height * 0.08
                          : screenSize.height * 0.15,
                  child: InkWell(
                    onTap: () {
                      if (answer.key != null) {
                        setState(() {
                          selectedValues['${question.id}'] = answer.key!;
                          selectedValues['${question.id}'] = answer.key!;
                        });
                      }
                      print(
                          "Selected Values: ${selectedValues.values.join(',')}");
                      print(
                          "Selected Values for question ${question.id}: ${selectedValues['${question.id}']}");
                    },
                    child: Row(
                      children: [
                        if (answer.value!.icon != null)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Image.network(
                              "https://tfbfitness.com/${answer.value!.icon}",
                              height: 35,
                              width: 35,
                              fit: BoxFit.contain,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                } else {
                                  return const CupertinoActivityIndicator(
                                    color: FitnessColor.white,
                                  );
                                }
                              },
                            ),
                          ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: CustomText2(
                              text: answer.value!.answer ?? '',
                              fontSize: 4.5,
                              fontFamily: Fonts.arial,
                              color: FitnessColor.white,
                            ),
                          ),
                        ),
                        if (answer.value!.image != null)
                          SizedBox(
                            width: screenSize.width * 0.30,
                            height: screenSize.height * 0.35,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Padding(
                                padding: const EdgeInsets.only(right: 0),
                                child: Image.network(
                                  "https://tfbfitness.com/${answer.value!.image}",
                                  fit: BoxFit.cover,
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    } else {
                                      return const CupertinoActivityIndicator(
                                        color: FitnessColor.white,
                                      );
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  )),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildBottomButtons() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (currentPage > 0)
            CustomButton(
              height: 40,
              width: 55,
              text: DemoLocalization.of(context)!.translate('Back').toString(),
              onPressed: () {
                setState(() {
                  currentPage--;
                  _pageController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.ease,
                  );
                });
              },
              fontFamily: Fonts.arial,
            ),
          if (currentPage < questionController.questionList.length - 1)
            CustomButton(
              height: 40,
              width: 55,
              text: DemoLocalization.of(context)!.translate('Next').toString(),
              onPressed: () {
                if (selectedValues[
                        '${questionController.questionList[currentPage].id}'] !=
                    -1) {
                  setState(() {
                    currentPage++;
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.ease,
                    );
                  });
                } else {
                  Utils.mySnackBar(
                      title: 'Not Answered!', msg: 'Please select a answer');
                }
              },
              fontFamily: Fonts.arial,
            ),
          if (currentPage == questionController.questionList.length - 1)
            CustomButton(
              height: 40,
              width: 60,
              text:
                  DemoLocalization.of(context)!.translate('Finish').toString(),
              onPressed: () {
                if (selectedValues['${questionController.questionList[currentPage].id}'] != -1) {
                  // Get.to(() => const StartNowSecond());
                 // Get.to(() => const ExactScoreTableUI());
                  SharedPref.setQuestionPrefs("25");
                  Get.to(() => const SelectTrainerScreen(questionId: "25"));

                  //Get.to(() =>  HomeScreen(questionId: selectedValues.values.join(','),));
                }else{
                  Utils.mySnackBar(
                      title: 'Not Answered!', msg: 'Please select a answer');
                }
              },
              fontFamily: Fonts.arial,
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return RefreshIndicator(
      onRefresh: () async {
        setState(() {
          questionController.getQuestionApi();
        });
      },
      child: Scaffold(
        backgroundColor: isDarkMode ? FitnessColor.primary : FitnessColor.white,
        appBar: AppBar(
          backgroundColor:
              isDarkMode ? FitnessColor.primary : FitnessColor.white,
          centerTitle: true,
          leading: InkWell(
              onTap: () {
                Get.back();
              },
              child: const Icon(Icons.arrow_back_ios_new_sharp)),
          title: CustomText1(
            text: DemoLocalization.of(context)!
                .translate('Question/Answer')
                .toString(),
            fontSize: 5,
            fontFamily: Fonts.arial,
            fontWeight: FontWeight.bold,
          ),
        ),
        body: Obx(() {
          if (questionController.isLoading.value) {
            return Center(child: myShimmer());
          }

          if (questionController.questionList.isEmpty) {
            return Center(
              child: CustomText1(
                text: DemoLocalization.of(context)!
                    .translate('No_data_found')
                    .toString(),
                fontSize: 4,
                fontFamily: Fonts.arial,
              ),
            );
          }

          return Column(
            children: [
              // Page Progress Indicator
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 22, vertical: 15),
                child: LinearProgressIndicator(
                  value: (currentPage + 1) /
                      questionController.questionList.length,
                  backgroundColor: isDarkMode ? Colors.grey : Colors.grey[300],
                  color: isDarkMode ? FitnessColor.white : FitnessColor.primary,
                ),
              ),

              // Page Number Indicator
              CustomText1(
                text:
                    '${currentPage + 1} / ${questionController.questionList.length}',
                fontSize: 4,
                fontFamily: Fonts.arial,
                fontWeight: FontWeight.bold,
              ),

              // PageView Builder
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: questionController.questionList.length,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (int page) {
                    setState(() {
                      currentPage = page;
                    });
                  },
                  itemBuilder: (context, index) {
                    return _buildPageContent(
                        questionController.questionList[index]);
                  },
                ),
              ),
            ],
          );
        }),

        // Bottom buttons
        bottomNavigationBar: _buildBottomButtons(),
      ),
    );
  }
}

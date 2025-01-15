import 'package:flutter/material.dart';
import '../colors.dart';
import '../custom/CustomText.dart';
import '../custom/CustomWidget.dart';
import '../custom/Fonts.dart';
import '../utils/Demo_Localization.dart';

class OnboardingPageFour extends StatelessWidget {
  final List<Map<String, String>> fitnessGoals = [
    {
      'title': 'Beginner',
      'subtitle': 'Im new to fitness', // replace with actual image path
    },
    {
      'title': 'Intermediate',
      'subtitle': 'I work out from time to time', // replace with actual image path
    },
    {
      'title': 'Advanced',
      'subtitle': 'I exercise regulary', // replace with actual image path
    },
  ];

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 25),
              CustomTextWidget(title: "",fontFamily: Fonts.arial,icon: Icons.arrow_back_ios,imageAsset: ""),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: CustomText(
                  text: DemoLocalization.of(context)!.translate('Whatisyourfitnesslevel').toString(),//"What is your fitness level?",
                  fontSize: 7.0,
                  color: FitnessColor.colorTextFour,
                  fontWeight: FontWeight.bold,
                  fontFamily: Fonts.arial,
                  textAlign: TextAlign.start,
                ),
              ),
              ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: fitnessGoals.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Card(
                      color: Colors.black,
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      elevation: 4,
                      child: InkWell(
                      onTap: () {
                    // Handle card tap
                  },
                  child: Container(
                  height: screenSize.height * 0.15, // Adjust the height as needed
                  child: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Text(
                  fitnessGoals[index]['title']!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                  fontSize: 26,
                  color: Colors.white,
                  fontFamily: 'Montserrat', // Replace with your actual font family
                  fontWeight: FontWeight.normal,
                  ),
                  ),
                  // SizedBox(height: 8), // Add some space between title and subtitle
                  Text(
                  fitnessGoals[index]['subtitle']!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontFamily: 'Montserrat', // Replace with your actual font family
                  fontWeight: FontWeight.normal,
                  ),
                  ),
               ],
                  ),
                  ),
                  ),));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
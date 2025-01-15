import 'package:fitness/auth/LoginScreen.dart';
import 'package:flutter/material.dart';
import '../colors.dart';
import '../custom/CustomText.dart';
import '../custom/CustomWidget.dart';
import '../custom/Fonts.dart';
import '../utils/Demo_Localization.dart';

class OnboardingPageTwelve extends StatelessWidget {
  final List<Map<String, String>> fitnessGoals = [
    {
      'title': 'My dinner is composed of mainly meat with some vegetables or other carbohydrates.',
      'image': 'assets/images/f12img1.png', // replace with actual image path
    },
    {
      'title': 'My dinner is composed mainly of vegetables or other carbohydrates and a omparatively small serving of meat.',
      'image': 'assets/images/f12img2.png', // replace with actual image path
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
              const CustomTextWidget(title: "",fontFamily: Fonts.arial,icon: Icons.arrow_back_ios,imageAsset: ""),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: CustomText(
                  text: DemoLocalization.of(context)!.translate('Isleepbestif').toString(),//"I sleep best if ?",
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
                    child: Container(
                      // height: screenSize.height * 0.24, // Adjust the height as needed
                      child: InkWell(
                        onTap: () {},
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  fitnessGoals[index]['title']!,
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontFamily: Fonts.arial,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 12.0),
                              child: Container(
                                width: 80,//screenSize.width * 0.14, // Make the image container square
                                height:80,// screenSize.height * 0.14, // Make the image container square
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                    image: AssetImage(fitnessGoals[index]['image']!),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ],
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
}
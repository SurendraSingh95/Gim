import 'package:flutter/material.dart';
import '../colors.dart';
import '../custom/CustomText.dart';
import '../custom/CustomWidget.dart';
import '../custom/Fonts.dart';
import '../utils/Demo_Localization.dart';

class OnboardingPageEight extends StatelessWidget {
  final List<Map<String, String>> fitnessGoals = [
    {
      'title': 'Insufficient sleep (less than 5 hours)',
      'image': 'assets/images/f8img1.png', // replace with actual image path
    },
    {
      'title': 'I have a brief rest (5-6 hours)',
      'image': 'assets/images/f8img2.png', // replace with actual image path
    },
    {
      'title': 'I have a healthy sleep duration (7-8 hours)',
      'image': 'assets/images/f8img3.png', // replace with actual image path
    },
    {
      'title': 'I sleep over 8 hr',
      'image': 'assets/images/f8img4.png', // replace with actual image path
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
              const SizedBox(height: 20),
              CustomTextWidget(title: "",fontFamily: Fonts.arial,icon: Icons.arrow_back_ios,imageAsset: ""),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: CustomText(
                  text: DemoLocalization.of(context)!.translate('Whatisyouraveragesleeptime').toString(),//"What is your average sleep time?",
                  fontSize: 7.0,
                  color: FitnessColor.colorTextFour,
                  fontWeight: FontWeight.bold,
                  fontFamily: Fonts.arial,
                  textAlign: TextAlign.start,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: CustomText(
                  text: DemoLocalization.of(context)!.translate('Wewouldliketoknowifyouwantedtoimproveyoursleep').toString(),//"We would like to know if you wanted to improve your sleep.",
                  fontSize: 5.0,
                  color: FitnessColor.colorTextFour,
                  fontWeight: FontWeight.normal,
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
                      height: screenSize.height * 0.15, // Adjust the height as needed
                      child: InkWell(
                        onTap: () {
                          // Handle card tap
                        },
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 16.0,right: 16),
                              child: Container(
                                // width: screenSize.width * 0.25, // Set fixed width
                                // height: screenSize.height * 0.25, // Set fixed height
                                width : 40,
                                height: 40,
                                //  width: screenSize.width * 0.25, // Make the image container square
                                decoration: BoxDecoration(
                                  // borderRadius: BorderRadius.circular(10.0),
                                  //    borderRadius: BorderRadius.only(
                                  //   // topRight: Radius.circular(10.0),
                                  //   // bottomRight: Radius.circular(10.0),
                                  //
                                  // ),
                                  image: DecorationImage(
                                    image: AssetImage(fitnessGoals[index]['image']!
                                    ),

                                    fit: BoxFit.cover,


                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
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
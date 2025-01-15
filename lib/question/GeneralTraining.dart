import 'package:flutter/material.dart';
import '../colors.dart';
import '../custom/CustomText.dart';
import '../custom/Fonts.dart';
import 'package:expandable_text/expandable_text.dart';

import '../utils/Demo_Localization.dart';

class GeneralTraining extends StatefulWidget {
  @override
  _GeneralTrainingState createState() => _GeneralTrainingState();
}

class _GeneralTrainingState extends State<GeneralTraining> {
  final fitnessGoals = [
    {
      'title': 'Beginner',
      'description': 'You can complete a 5km or 3mi run without stopping, in under 60 minutes\n'
          'if you cant complete a 5km or 3mi run in under 60 mins, no problem! '
          'Please go back and select the Run a First 5k goal first to build your base fitness',
    },
    {
      'title': 'Intermediate',
      'description': 'you regularly run at least 5km or 3mi,but don\'t structure your training or put thought into a plan',
    },
    {
      'title': 'Advanced',
      'description': 'you regularly run at least 10km or 6mi,and do some structured training e.g. intervals',
    },
    {
      'title': 'Elite',
      'description': 'you regularly run half-marathons or further and are experienced with structured training e.g. intervals',
    },
  ];

  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Center(child: Text('')),
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body:Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: CustomText(
                      text: DemoLocalization.of(context)!.translate('Howwould').toString(),//"How would you rate your running ability?",
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
                      text:DemoLocalization.of(context)!.translate('Nickthe').toString(),//"Nick the level that you think suits you best (you can change this later)",
                      fontSize: 3,
                      textAlign: TextAlign.start,
                      color: FitnessColor.colorTextPrimary,
                      fontWeight: FontWeight.normal,
                      fontFamily: Fonts.arial,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: ListView.builder(
                      padding: EdgeInsets.all(8.0),
                      itemCount: fitnessGoals.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedIndex = selectedIndex == index ? null : index;
                              });
                            },
                            child: Card(
                              semanticContainer: true,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              color: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0), // Circular border
                                side: BorderSide(
                                  color: selectedIndex == index ? Colors.green : Colors.grey,
                                  width: 2.0,
                                ),
                              ),
                              elevation: 4,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[

                                    Text(
                                      fitnessGoals[index]['title']!,
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontFamily: Fonts.arial,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      /*    style: TextStyle(
                                    fontSize: 18,
                                    color: *//*selectedIndex == index ? Colors.blue :*//* Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),*/
                                    ),
                                    if (selectedIndex == index) ...[
                                      SizedBox(height: 10.0),
                                      ExpandableText(
                                        fitnessGoals[index]['description']!,
                                        expandText: '',
                                        collapseText: '',
                                        maxLines: 8,
                                        linkColor: FitnessColor.colorBg1,
                                        style: TextStyle(
                                            fontSize: 10,
                                            color: FitnessColor.colorBg1,
                                            fontWeight:FontWeight.bold,
                                            fontFamily:Fonts.arial
                                        ),

                                      ),
                                    ]
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 10),

                ],
              ),
            ),
          ),
          Visibility(
            visible: selectedIndex != null,
            child: Positioned(
              bottom: 16,
              right: 8,
              left: 8,
              child: Padding(
                padding: EdgeInsets.all(0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Handle continue action
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: FitnessColor.colorfillText, width: 1),
                          borderRadius: BorderRadius.all(
                              Radius.circular(10.0)), // Border radius
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            CustomText(
                              text: "Continue",
                              fontSize: 4,
                              color: FitnessColor.colorTextPrimary,
                              fontWeight: FontWeight.bold,
                              fontFamily: Fonts.arial,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      )

    );
  }
}

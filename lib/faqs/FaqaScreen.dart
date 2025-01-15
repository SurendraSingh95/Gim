import 'package:flutter/material.dart';
import '../colors.dart';
import '../custom/CustomText.dart';
import '../custom/Fonts.dart';

class FAQSScreen extends StatefulWidget {
  const FAQSScreen({super.key});

  @override
  State<FAQSScreen> createState() => _FAQSScreenState();
}

class _FAQSScreenState extends State<FAQSScreen> {

  List RandomImages = [
    'https://images.unsplash.com/photo-1597223557154-721c1cecc4b0?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8aHVtYW4lMjBmYWNlfGVufDB8fDB8fA%3D%3D&w=1000&q=80',
    'https://img.freepik.com/free-photo/portrait-white-man-isolated_53876-40306.jpg',
    'https://images.unsplash.com/photo-1542909168-82c3e7fdca5c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8ZmFjZXxlbnwwfHwwfHw%3D&w=1000&q=80',
    //   'https://i0.wp.com/post.medicalnewstoday.com/wp-content/uploads/sites/3/2020/03/GettyImages-1092658864_hero-1024x575.jpg?w=1155&h=1528'
  ];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar :AppBar(
         title: Text("Help"),
      ),
      // backgroundColor: Colors.grey,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
               /* ListView(
                  children:  [
                    ListTile(
                      // leading: Icon(Icons.car_rental),
                       title:CustomText(
                          text: "Customer support",
                          fontSize: 4,
                          color: FitnessColor.colorTextPrimary,
                          fontWeight: FontWeight.bold,
                          fontFamily: Fonts.arial //Fonts.arial,
                      ),
                      trailing: Icon(Icons.arrow_forward_ios,color: Colors.grey),
                    ),

                  ],
                ),*/

               /*Row(
                 children: [
                   CustomText(
                       text: "Chat with us",
                       fontSize: 3,
                       color: FitnessColor.colorTextPrimary,
                       fontWeight: FontWeight.normal,
                       fontFamily: Fonts.arial //Fonts.arial,
                   ),


                 ],
               )*/
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                  text: "FAQS",
                                  fontSize: 4,
                                  color: FitnessColor.colorTextPrimary,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: Fonts.arial //Fonts.arial,
                              ),
                              CustomText(
                                  text:
                                  "Our most frequently asked questions about \nFTB and gettting the most out of your running",
                                  fontSize: 3,
                                  color: FitnessColor.colorTextPrimary,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: Fonts.arial //Fonts.arial,
                              ),
                            ],
                          ),
                          Spacer(),
                        /*  Padding(
                              padding: const EdgeInsets.only(bottom: 0.0),
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: FitnessColor.colormonthbgcolor,
                              )),*/
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              CustomText(
                                  text:
                                  "29 articles \nBy Dom and 8 others",
                                  fontSize: 3,
                                  color: FitnessColor.colorTextPrimary,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: Fonts.arial //Fonts.arial,
                              ),
                            ],
                          ),
                          Spacer(),
                          Padding(
                              padding: const EdgeInsets.only(bottom: 0.0),
                              child: Container(
                                // parent row
                                height: 30,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    for (int i = 0; i < RandomImages.length; i++)
                                      Align(
                                        widthFactor: 0.3,
                                        child: CircleAvatar(
                                          radius: 50,
                                          backgroundImage:
                                          NetworkImage(RandomImages[i]),
                                        ),
                                      )
                                  ],
                                ),
                              ),/*Icon(
                                Icons.arrow_forward_ios,
                                color: FitnessColor.colormonthbgcolor,
                              )*/),
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                             CustomText(
                                  text:
                                  "Need to pause your plan?",
                                  fontSize: 3,
                                  color: FitnessColor.colorTextPrimary,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: Fonts.arial //Fonts.arial,
                              ),
                            ],
                          ),
                          Spacer(),
                          Padding(
                              padding: const EdgeInsets.only(bottom: 0.0),
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: FitnessColor.colormonthbgcolor,
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(),
              ],
            ),
          ),
        ));
  }
}

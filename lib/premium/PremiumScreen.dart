import 'package:fitness/webview/WebViewScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../colors.dart';
import '../custom/CstAppbarWithtextimage.dart';
import '../custom/CustomText.dart';
import '../custom/Fonts.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';

import '../post/PostScreen.dart';
import '../utils/Demo_Localization.dart';

class PremiumScreen extends StatefulWidget {
  const PremiumScreen({super.key});

  @override
  State<PremiumScreen> createState() => _PremiumScreenState();
}

class _PremiumScreenState extends State<PremiumScreen> {
  final List<Map<String, dynamic>> items = [
    {
      'image': 'assets/images/f1row1.png',
      'title': 'General',
    },
    {
      'image': 'assets/images/checkoutimg.png',
      'title': 'Share your run',
      'price': '\$6.99',
    },
    {
      'image': 'assets/images/f1row1.png',
      'title': 'Manage Spaces',
      'price': '\$6.99',
    },
    {
      'image': 'assets/images/checkoutimg.png',
      'title': 'Explore All',
      'price': '\$6.99',
    },
  ];
  final List<Map<String, dynamic>> itemslist = [
    {
      'userimage': 'assets/images/f1row1.png',
      'name': 'Rahul',
      'status': 'Share your run',
      'time': '23m',
      'title': 'Olympic Marathon 2024',
      'description':
          'First up on Saturday in the mens marathon, legendary rivals Eliud Kipchoge and Kenenisa Bekele are back in Paris for the 2024 Olympics'
              'First up on Saturday in the mens marathon, legendary rivals Eliud Kipchoge and Kenenisa Bekele are back in Paris for the 2024 Olympics',
      'image': 'assets/images/f1row1.png',
      'like': '2 Likes',
      'comments': '0 Comments',
    },
    {
      'userimage': 'assets/images/f1row1.png',
      'name': 'User Name',
      'status': 'General',
      'time': '23m',
      'title': 'General',
      'description': 'General',
      'image': 'assets/images/f1row1.png',
      'like': '1 Likes',
      'comments': '0 Comments',
    },
    {
      'userimage': 'assets/images/f1row1.png',
      'name': 'General',
      'status': 'General',
      'time': '23m',
      'title': 'General',
      'description': 'General',
      'image': 'assets/images/f1row1.png',
      'like': '0 Likes',
      'comments': '0 Comments',
    },
  ];
  List RandomImages = [
    'https://images.unsplash.com/photo-1597223557154-721c1cecc4b0?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8aHVtYW4lMjBmYWNlfGVufDB8fDB8fA%3D%3D&w=1000&q=80',
    'https://img.freepik.com/free-photo/portrait-white-man-isolated_53876-40306.jpg',
    'https://images.unsplash.com/photo-1542909168-82c3e7fdca5c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8ZmFjZXxlbnwwfHwwfHw%3D&w=1000&q=80',
    //   'https://i0.wp.com/post.medicalnewstoday.com/wp-content/uploads/sites/3/2020/03/GettyImages-1092658864_hero-1024x575.jpg?w=1155&h=1528'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.grey,
        body: Stack(
      children: [
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(height: 20),
                // Navigator.push(context, _createRoute());
                // Padding(
                // padding: const EdgeInsets.only(left: 16.0, right: 16, top: 16),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, right: 16, top: 16),
                  child: CstAppbarWithtextimage(
                      title: DemoLocalization.of(context)!.translate('JoinFTBPremium').toString(),//'Join FTB Premium',
                      icon: Icons.arrow_back_ios,
                      fontFamily: Fonts.arial,
                      onImageTap: () {}),
                ),
                SizedBox(height: 20),

                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage:
                        AssetImage('assets/images/profileedit.png'),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomText(
                        textAlign: TextAlign.center,
                        text: DemoLocalization.of(context)!.translate('JoinFTBPremium').toString(),//"Join FTB Premium",
                        fontSize: 6,
                        color: FitnessColor.colorTextPrimary,
                        fontWeight: FontWeight.bold,
                        fontFamily: Fonts.arial //Fonts.arial,
                        ),
                  ],
                ),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                        textAlign: TextAlign.center,
                        text:DemoLocalization.of(context)!.translate('redeem').toString(),
                            //"Ram, redeem your free week and unlock \nyour full plan",
                        fontSize: 4,
                        color: FitnessColor.colorTextPrimary,
                        fontWeight: FontWeight.normal,
                        fontFamily: Fonts.arial //Fonts.arial,
                        ),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.check_box),
                    SizedBox(
                      width: 5,
                    ),
                    CustomText(
                        text:DemoLocalization.of(context)!.translate('Ourmostfrequently').toString(),
                           // "Our most frequently asked questions about \nFTB and gettting the most out of your",
                        fontSize: 3,
                        color: FitnessColor.colorTextPrimary,
                        fontWeight: FontWeight.normal,
                        fontFamily: Fonts.arial //Fonts.arial,
                        ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.check_box),
                    SizedBox(
                      width: 5,
                    ),
                    CustomText(
                        text:DemoLocalization.of(context)!.translate('Ourmostfrequently').toString(),
                          //  "Our most frequently asked questions about \nFTB and gettting the most out of your",
                        fontSize: 3,
                        color: FitnessColor.colorTextPrimary,
                        fontWeight: FontWeight.normal,
                        fontFamily: Fonts.arial //Fonts.arial,
                        ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.check_box),
                    SizedBox(
                      width: 5,
                    ),
                    CustomText(
                        text:DemoLocalization.of(context)!.translate('Ourmostfrequently').toString(),
                        //    "Our most frequently asked questions about \nFTB and gettting the most out of your",
                        fontSize: 3,
                        color: FitnessColor.colorTextPrimary,
                        fontWeight: FontWeight.normal,
                        fontFamily: Fonts.arial //Fonts.arial,
                        ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomText(
                        text: DemoLocalization.of(context)!.translate('Alternativesubscriptions').toString().toUpperCase(),//"Alternative subscriptions.".toUpperCase(),
                        fontSize: 3,
                        color: FitnessColor.colorTextPrimary,
                        fontWeight: FontWeight.normal,
                        fontFamily: Fonts.arial //Fonts.arial,
                        ),
                  ],
                ),

                Center(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(
                        color: Colors.red,
                        width: 1.0,
                      ),
                    ),
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {},
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                        text: DemoLocalization.of(context)!.translate('Annual1week').toString(),//"Annual (1 week free)",
                                        fontSize: 4,
                                        color: FitnessColor.colorTextPrimary,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: Fonts.arial //Fonts.arial,
                                        ),
                                    CustomText(
                                        text:  DemoLocalization.of(context)!.translate('Rs').toString(),//"Rs. 10,800.00/year",
                                        fontSize: 3,
                                        color: FitnessColor.colorTextPrimary,
                                        fontWeight: FontWeight.normal,
                                        fontFamily:
                                            Fonts.arial //Fonts.arial,
                                        ),
                                  ],
                                ),
                                Spacer(),
                                Column(
                                  children: [
                                    Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 10.0, left: 60),
                                        child: Container(
                                          height: 20,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5),
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            border: Border.all(
                                                color: Colors.red, width: 1),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(
                                                    5.0)), // Border radius
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              CustomText(
                                                text: DemoLocalization.of(context)!.translate('SavePer').toString(),//"Save 55%",
                                                fontSize: 3,
                                                color: FitnessColor.colorBg1,
                                                fontWeight: FontWeight.normal,
                                                fontFamily: Fonts.arial,
                                              ),
                                            ],
                                          ),
                                        )),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 0.0),
                                      child: CustomText(
                                          text: DemoLocalization.of(context)!.translate('Rsweek').toString(),//"Rs. 207.12/week",
                                          fontSize: 3,
                                          color: FitnessColor.colorTextPrimary,
                                          fontWeight: FontWeight.normal,
                                          fontFamily:
                                              Fonts.arial //Fonts.arial,
                                          ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                Center(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      /* side: BorderSide(
                        // color: Colors.red,
                        width: 1.0,
                      ),*/
                    ),
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {},
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                        text: DemoLocalization.of(context)!.translate('Monthly').toString(),//"Monthly (1 week free)",
                                        fontSize: 4,
                                        color: FitnessColor.colorTextPrimary,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: Fonts.arial //Fonts.arial,
                                        ),
                                    CustomText(
                                        text: DemoLocalization.of(context)!.translate('RsMonth').toString(),//"Rs. 1,999.00/month",
                                        fontSize: 3,
                                        color: FitnessColor.colorTextPrimary,
                                        fontWeight: FontWeight.normal,
                                        fontFamily:
                                            Fonts.arial //Fonts.arial,
                                        ),
                                  ],
                                ),
                                Spacer(),
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 0.0),
                                      child: CustomText(
                                          text: DemoLocalization.of(context)!.translate('RsWeeken').toString(),//"Rs. 460.04/week",
                                          fontSize: 3,
                                          color: FitnessColor.colorTextPrimary,
                                          fontWeight: FontWeight.normal,
                                          fontFamily:
                                              Fonts.arial //Fonts.arial,
                                          ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomText(
                        text: DemoLocalization.of(context)!.translate('AllpricesshowninINR').toString(),//"All prices shown in INR",
                        fontSize: 3,
                        color: FitnessColor.colorTextPrimary,
                        fontWeight: FontWeight.normal,
                        fontFamily: Fonts.arial //Fonts.arial,
                        ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomText(
                        textAlign: TextAlign.center,
                        text: DemoLocalization.of(context)!.translate('Howyourfreetrialworks').toString(),//"How your free trial works",
                        fontSize: 6,
                        color: FitnessColor.colorTextPrimary,
                        fontWeight: FontWeight.bold,
                        fontFamily: Fonts.arial //Fonts.arial,
                        ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                        text: DemoLocalization.of(context)!.translate('Createyourplan').toString(),//"Create your plan",
                        fontSize: 4,
                        color: FitnessColor.colortextgreen,
                        fontWeight: FontWeight.normal,
                        fontFamily: Fonts.arial //Fonts.arial,
                        ),
                    CustomText(
                        text: DemoLocalization.of(context)!.translate('Yousuccessfullycreatedyourplan').toString(),//"You successfully created your plan",
                        fontSize: 3,
                        color: FitnessColor.colorTextPrimary,
                        fontWeight: FontWeight.normal,
                        fontFamily: Fonts.arial //Fonts.arial,
                        ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                        text: DemoLocalization.of(context)!.translate('Today').toString(),//"Today",
                        fontSize: 4,
                        color: FitnessColor.colorTextPrimary,
                        fontWeight: FontWeight.normal,
                        fontFamily: Fonts.arial //Fonts.arial,
                        ),
                    CustomText(
                        text: DemoLocalization.of(context)!.translate('Instant').toString(),//"Instant access to FTB Premium",
                        fontSize: 3,
                        color: FitnessColor.colorTextPrimary,
                        fontWeight: FontWeight.normal,
                        fontFamily: Fonts.arial //Fonts.arial,
                        ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                        text: DemoLocalization.of(context)!.translate('Day5').toString(),//"Day 5",
                        fontSize: 4,
                        color: FitnessColor.colorTextPrimary,
                        fontWeight: FontWeight.normal,
                        fontFamily: Fonts.arial //Fonts.arial,
                        ),
                    CustomText(
                        text:DemoLocalization.of(context)!.translate('Wewillnotify').toString(),
                            //"We'll notify you before your free trail ends. Cancel 24 hours before your trial ends if you don't want to be charged",
                        fontSize: 3,
                        color: FitnessColor.colorTextPrimary,
                        fontWeight: FontWeight.normal,
                        fontFamily: Fonts.arial //Fonts.arial,
                        ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                        text: DemoLocalization.of(context)!.translate('Day7').toString(),//"Day 7",
                        fontSize: 4,
                        color: FitnessColor.colorTextPrimary,
                        fontWeight: FontWeight.normal,
                        fontFamily: Fonts.arial //Fonts.arial,
                        ),
                    CustomText(
                        text:DemoLocalization.of(context)!.translate('Yoursubscription').toString(),
                          //  "Your subscription will start unless you've turned off auto-renew, cancel anytime",
                        fontSize: 3,
                        color: FitnessColor.colorTextPrimary,
                        fontWeight: FontWeight.normal,
                        fontFamily: Fonts.arial //Fonts.arial,
                        ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        RatingBar.readOnly(
                          filledIcon: Icons.star,
                          emptyIcon: Icons.star_border,
                          initialRating: 5,
                          maxRating: 5,
                        )
                      ],
                    ),
                    CustomText(
                        text:DemoLocalization.of(context)!.translate('Over1000').toString(),// "Over 1000 5-star reviews worldwide",
                        fontSize: 3,
                        color: FitnessColor.colorTextPrimary,
                        fontWeight: FontWeight.normal,
                        fontFamily: Fonts.arial //Fonts.arial,
                        ),
                  ],
                ),

                Container(
                  height: 120,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                      itemCount: 4,
                      // physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      // padding: EdgeInsets.zero,
                      // Remove extra padding
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Card(
                            margin: EdgeInsets.symmetric(vertical: 0.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: BorderSide(
                                  color: FitnessColor.coloroutlineborder
                                      .withOpacity(0.25),
                                  width: 0.0,
                                )),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                      text: "Best app so far...",
                                      fontSize: 4,
                                      color: FitnessColor.colorTextPrimary,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: Fonts.arial //Fonts.arial,
                                      ),
                                  Row(
                                    children: [
                                      RatingBar.readOnly(
                                        filledIcon: Icons.star,
                                        emptyIcon: Icons.star_border,
                                        initialRating: 5,
                                        maxRating: 5,
                                      ),
                                      CustomText(
                                          text: "Laurakate",
                                          fontSize: 3,
                                          color: FitnessColor.colorTextPrimary,
                                          fontWeight: FontWeight.normal,
                                          fontFamily:
                                              Fonts.arial //Fonts.arial,
                                          ),
                                    ],
                                  ),
                                  CustomText(
                                      text:
                                          "I've tried so many different running apps.",
                                      // "\nThey have either been good for a bit then have a\nsudden incline in work outs from week\n to week or not challenging enough.This is \napp is perfect bc it matches your current level.",
                                      fontSize: 3,
                                      color: FitnessColor.colorTextPrimary,
                                      fontWeight: FontWeight.normal,
                                      fontFamily:
                                          Fonts.arial //Fonts.arial,
                                      ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),

                Container(
                  height: 140,
                  width: MediaQuery.of(context).size.width,
                  // width: 120,
                  child: Image.asset(
                    "assets/images/logo.png",
                    fit: BoxFit.cover,
                  ),
                ),

                SizedBox(
                  height: 5,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomText(
                        text: DemoLocalization.of(context)!.translate('Anyquestions').toString(),//"Any questions?",
                        fontSize: 4,
                        color: FitnessColor.colorTextPrimary,
                        fontWeight: FontWeight.bold,
                        fontFamily: Fonts.arial //Fonts.arial,
                        ),
                    CustomText(
                        text: DemoLocalization.of(context)!.translate('Chatteam').toString(),//"Chat to our friendly team",
                        fontSize: 3,
                        color: FitnessColor.colorTextPrimary,
                        fontWeight: FontWeight.normal,
                        fontFamily: Fonts.arial //Fonts.arial,
                        ),
                  ],
                ),

                SizedBox(
                  height: 10,
                ),

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
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 30,
                  width: 120,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    // border: Border.all(color: Colors.red, width: 1),
                    borderRadius:
                        BorderRadius.all(Radius.circular(5.0)), // Border radius
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CustomText(
                        text: DemoLocalization.of(context)!.translate('Chatwithus').toString().toUpperCase(),//"Chat with us".toUpperCase(),
                        fontSize: 3,
                        color: FitnessColor.colorinsidebox,
                        fontWeight: FontWeight.normal,
                        fontFamily: Fonts.arial,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                    /*    Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => WebViewExample()));*/
                      },
                      child: CustomText(
                          text: DemoLocalization.of(context)!.translate('Termsandconditions').toString().toUpperCase(),//"Terms and conditions".toUpperCase(),
                          fontSize: 3,
                          color: FitnessColor.colorTextPrimary,
                          fontWeight: FontWeight.bold,
                          fontFamily: Fonts.arial //Fonts.arial,
                          ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                       /* Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => WebViewExample()));*/
                      },
                      child: CustomText(
                          text: DemoLocalization.of(context)!.translate('PrivacyPolicy').toString().toUpperCase(),//"Privacy Policy".toUpperCase(),
                          fontSize: 3,
                          color: FitnessColor.colorTextPrimary,
                          fontWeight: FontWeight.bold,
                          fontFamily: Fonts.arial //Fonts.arial,
                          ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomText(
                        text: DemoLocalization.of(context)!.translate('RestorePurchases').toString().toUpperCase(),//"Restore Purchases".toUpperCase(),
                        fontSize: 3,
                        color: FitnessColor.colorTextPrimary,
                        fontWeight: FontWeight.bold,
                        fontFamily: Fonts.arial //Fonts.arial,
                        ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomText(
                        text: DemoLocalization.of(context)!.translate('Careers').toString().toUpperCase(),//"Careers".toUpperCase(),
                        fontSize: 3,
                        color: FitnessColor.colorTextPrimary,
                        fontWeight: FontWeight.bold,
                        fontFamily: Fonts.arial //Fonts.arial,
                        ),
                    SizedBox(
                      height: 180,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 16,
          right: 16,
          left: 16,
          child: Padding(
            padding: EdgeInsets.all(0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: FitnessColor.colorbutton,
                    // border: Border.all(color: Colors.red, width: 1),
                    borderRadius: BorderRadius.all(
                        Radius.circular(10.0)), // Border radius
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      // Icon(Icons.favorite_border, color: Colors.red),
                      // SizedBox(width: 5),
                      CustomText(
                        text: DemoLocalization.of(context)!.translate('Subscribe').toString(),//"Subscribe",
                        fontSize: 4,
                        color: FitnessColor.colorinsidebox,
                        fontWeight: FontWeight.bold,
                        fontFamily: Fonts.arial,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                GestureDetector(
                  onTap: () {
                  /*  showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(25.0)),
                      ),
                      builder: (BuildContext context) {
                        return PostReferralCodeDialog();
                      },
                    );*/
                  },
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    // padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                    decoration: BoxDecoration(
                      color: FitnessColor.colorBg1,
                      border: Border.all(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.all(
                          Radius.circular(10.0)), // Border radius
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        // Icon(Icons.favorite_border, color: Colors.red),
                        // SizedBox(width: 5),
                        CustomText(
                          text: DemoLocalization.of(context)!.translate('Enterreferralcode').toString(),//"Enter referral code",
                          fontSize: 4,
                          color: FitnessColor.colorTextPrimary,
                          fontWeight: FontWeight.bold,
                          fontFamily: Fonts.arial,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    ));
  }
}

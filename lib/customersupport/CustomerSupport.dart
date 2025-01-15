import 'package:fitness/faqs/FaqaScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../colors.dart';
import '../custom/CustomText.dart';
import '../custom/Fonts.dart';
import 'package:page_transition/page_transition.dart';
import '../utils/Demo_Localization.dart';

class CustomerSupport extends StatefulWidget {
  const CustomerSupport({super.key});

  @override
  State<CustomerSupport> createState() => _CustomerSupportState();
}

class _CustomerSupportState extends State<CustomerSupport> {
  List RandomImages = [
    'https://images.unsplash.com/photo-1597223557154-721c1cecc4b0?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8aHVtYW4lMjBmYWNlfGVufDB8fDB8fA%3D%3D&w=1000&q=80',
    'https://img.freepik.com/free-photo/portrait-white-man-isolated_53876-40306.jpg',
    'https://images.unsplash.com/photo-1542909168-82c3e7fdca5c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8ZmFjZXxlbnwwfHwwfHw%3D&w=1000&q=80',
    //   'https://i0.wp.com/post.medicalnewstoday.com/wp-content/uploads/sites/3/2020/03/GettyImages-1092658864_hero-1024x575.jpg?w=1155&h=1528'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: <Widget>[
              // Expanded(flex: 2, child:Image.asset("assets/images/checkoutimg.png",fit: BoxFit.cover,)),
              Expanded(
                flex: 2,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(color: Colors.black),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(color: Colors.white),
                ),
              ),
            ],
          ),

          Column(
            children: [
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16, top: 16),
                child:Row(children: [
                  CustomText(
                      text: DemoLocalization.of(context)!.translate('FTB').toString(),//"FTB",
                      fontSize: 8,
                      color: FitnessColor.colorMainButton,
                      fontWeight: FontWeight.bold,
                      fontFamily: Fonts.arial //Fonts.arial,
                  ),
                  Spacer(),
                  Container(
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (int i = 0; i < RandomImages.length; i++)
                          Align(
                            widthFactor: 0.2,
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage:
                              NetworkImage(RandomImages[i]),
                            ),
                          )
                      ],
                    ),
                  ),
                  SizedBox(width: 20,),
                  Icon(Icons.cancel_sharp,color: Colors.white,)
                ],)
              ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    CustomText(
                        text: DemoLocalization.of(context)!.translate('HeyRam').toString(),//"Hey,Ram \nWe're here to help!",
                        fontSize: 8,
                        color: FitnessColor.colorEdit,
                        fontWeight: FontWeight.bold,
                        fontFamily: Fonts.arial //Fonts.arial,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),

              Center(
                child: GestureDetector(
                  onTap: (){

                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),

                    ),
                    elevation: 3,
                    child: Padding(
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
                                      text: DemoLocalization.of(context)!.translate('Messages').toString(),//"Messages",
                                      fontSize: 4,
                                      color: FitnessColor.colorTextPrimary,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: Fonts.arial //Fonts.arial,
                                  ),
                                ],
                              ),
                              Spacer(),
                              Padding(
                                  padding: const EdgeInsets.only(bottom: 0.0),
                                  child: Icon(
                                    Icons.message,
                                    color: FitnessColor.colormonthbgcolor,
                                  )),
                            ],
                          ),
                          Divider(),
                          GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  child: FAQSScreen(),
                                  inheritTheme: true,
                                  ctx: context),
                            );
                          } ,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                        text: DemoLocalization.of(context)!.translate('Help').toString(),//"Help",
                                        fontSize: 4,
                                        color: FitnessColor.colorTextPrimary,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: Fonts.arial //Fonts.arial,
                                    ),

                                  ],
                                ),
                                Spacer(),
                                Padding(
                                    padding: const EdgeInsets.only(bottom: 0.0),
                                    child: Icon(
                                      Icons.help,
                                      color: FitnessColor.colormonthbgcolor,
                                    )),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: GestureDetector(
                  onTap: (){
                    //    Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context) => FAQSScreen()));
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      // side: BorderSide(
                      //   color: Colors.grey,
                      //   width: 1.0,
                      // ),
                    ),
                    elevation: 3,
                    child: Padding(
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
                                      text: DemoLocalization.of(context)!.translate('Sendusamessage').toString(),//"Send us a message",
                                      fontSize: 4,
                                      color: FitnessColor.colorTextPrimary,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: Fonts.arial //Fonts.arial,
                                  ),
                                  CustomText(
                                      text:DemoLocalization.of(context)!.translate('Wetypically').toString(),
                                    //  "We typically reply within 12 hours",
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
                                    Icons.send,
                                    color: FitnessColor.colormonthbgcolor,
                                  )),
                            ],
                          ),



                        ],
                      ),
                    ),
                  ),
                ),
              ),


              Center(
                child: GestureDetector(
                  onTap: (){
                    //    Navigator.of(context).
                    //     pushReplacement(MaterialPageRoute(builder:(context) => FAQSScreen()));
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      // side: BorderSide(
                      //   color: Colors.grey,
                      //   width: 1.0,
                      // ),
                    ),
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Container(
                              height: 50,
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.grey, width: 0.2),
                                borderRadius:
                                BorderRadius.all(Radius.circular(10.0)), // Border radius
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[


                                  CustomText(
                                      text: DemoLocalization.of(context)!.translate('Searchforhelp').toString(),//"Search for help",
                                      fontSize: 4,
                                      color: FitnessColor.colorTextPrimary,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: Fonts.arial //Fonts.arial,
                                  ),
                                  Spacer(),
                                  // SizedBox(width: 5),
                                  Icon(Icons.search, color: Colors.grey),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  GestureDetector(
                                    onTap: () {
                                   /*   Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context) => WebViewExample()));
                                   */ },
                                    child: CustomText(
                                        text:DemoLocalization.of(context)!.translate('Whatare').toString(),
                                      //  "What are pace target recommendations \nand how to they work?",
                                        fontSize: 3,
                                        color: FitnessColor.colorTextPrimary,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: Fonts.arial //Fonts.arial,
                                    ),
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
                          SizedBox(height: 10,),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  CustomText(
                                      text:DemoLocalization.of(context)!.translate('How').toString(),
                                     // "How is my target race time predicted?",
                                      fontSize: 3,
                                      color: FitnessColor.colorTextPrimary,
                                      fontWeight: FontWeight.bold,
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
                          SizedBox(height: 10,),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  CustomText(
                                      text:DemoLocalization.of(context)!.translate('Whatismy').toString(),
                                    //  "What is my Ftb Score and how is it calculated?",
                                      fontSize: 3,
                                      color: FitnessColor.colorTextPrimary,
                                      fontWeight: FontWeight.bold,
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
                          SizedBox(height: 10,),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  CustomText(
                                      text:DemoLocalization.of(context)!.translate('Introduction').toString(),
                                     // "Introduction to strength training for runners",
                                      fontSize: 3,
                                      color: FitnessColor.colorTextPrimary,
                                      fontWeight: FontWeight.bold,
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
                  ),
                ),
              ),
            ],
          )
        ]

      ),


    );
  }
}

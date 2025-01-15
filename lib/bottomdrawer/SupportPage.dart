import 'package:fitness/auth/sign_out_screen.dart';
import 'package:fitness/customersupport/CustomerSupport.dart';
import 'package:flutter/material.dart';
import '../colors.dart';
import '../custom/CstAppbarWithtextimage.dart';
import '../custom/CustomText.dart';
import '../custom/Fonts.dart';
import '../faqs/FaqaScreen.dart';
import '../premium/PremiumScreen.dart';
import 'package:page_transition/page_transition.dart';
import '../utils/Demo_Localization.dart';

class SupportPage extends StatefulWidget {
  const SupportPage({super.key});

  @override
  State<SupportPage> createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
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
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16, top: 16),
              child:  // CustomWidgetImage(title: 'Support', imageAsset: 'assets/images/logo.png',fontFamily: Fonts.arial, onTextTap: () {})

                  CstAppbarWithtextimage(
                title: DemoLocalization.of(context)!.translate('Support').toString(),//'Support',
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

                  // Navigator.push(context,createRoute(),);
                },
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: const BorderSide(
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
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const CustomerSupport()));

                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // SizedBox(height: 60),
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
                                        backgroundImage:
                                            NetworkImage(RandomImages[i]),
                                      ),
                                    )
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                    text: DemoLocalization.of(context)!.translate('Customersupport').toString(),//"Customer support",
                                    fontSize: 4,
                                    color: FitnessColor.colorTextPrimary,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: Fonts.arial //Fonts.arial,
                                    ),
                                CustomText(
                                    text: DemoLocalization.of(context)!.translate('Chatwithus').toString(),//"Chat with us",
                                    fontSize: 3,
                                    color: FitnessColor.colorTextPrimary,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: Fonts.arial //Fonts.arial,
                                    ),
                              ],
                            ),
                            const Spacer(),
                            const Padding(
                                padding: EdgeInsets.only(bottom: 16.0),
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: FitnessColor.colormonthbgcolor,
                                )),
                          ],
                        ),
                      ),
                      const Divider(),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const PremiumScreen()));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomText(
                                text: DemoLocalization.of(context)!.translate('Get').toString(),//"Get",
                                fontSize: 3,
                                color: FitnessColor.colorTextPrimary,
                                fontWeight: FontWeight.normal,
                                fontFamily: Fonts.arial //Fonts.arial,
                                ),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              height: 24,
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              decoration: const BoxDecoration(
                                color: Colors.black,
                                // border: Border.all(color: Colors.red, width: 1),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(40.0)), // Border radius
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  const Icon(Icons.favorite_border,
                                      color: FitnessColor.colorBg1),
                                  const SizedBox(width: 5),
                                  CustomText(
                                    text:DemoLocalization.of(context)!.translate('Premium').toString().toUpperCase(),// "Premium".toUpperCase(),
                                    fontSize: 3,
                                    color: FitnessColor.colorBg1,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: Fonts.arial,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            CustomText(
                                text: DemoLocalization.of(context)!.translate('forcoachingsupport').toString(),//"for coaching support",
                                fontSize: 3,
                                color: FitnessColor.colorTextPrimary,
                                fontWeight: FontWeight.normal,
                                fontFamily: Fonts.arial //Fonts.arial,
                                ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 40,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey, width: 0.2),
                      borderRadius: const BorderRadius.all(
                          Radius.circular(10.0)), // Border radius
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Icon(Icons.favorite_border, color: Colors.grey),
                        const SizedBox(width: 5),
                        CustomText(
                            text: DemoLocalization.of(context)!.translate('Requestfeature').toString(),//"Request feature",
                            fontSize: 3,
                            color: FitnessColor.colorTextPrimary,
                            fontWeight: FontWeight.normal,
                            fontFamily: Fonts.arial //Fonts.arial,
                            ),
                      ],
                    ),
                  ),
                  Container(
                    height: 40,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey, width: 0.2),
                      borderRadius: const BorderRadius.all(
                          Radius.circular(10.0)), // Border radius
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Icon(Icons.thumb_up, color: Colors.grey),
                        const SizedBox(width: 5),
                        CustomText(
                            text: DemoLocalization.of(context)!.translate('Reportaproblem').toString(),//"Report a problem",
                            fontSize: 3,
                            color: FitnessColor.colorTextPrimary,
                            fontWeight: FontWeight.normal,
                            fontFamily: Fonts.arial //Fonts.arial,
                            ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Divider(),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                CustomText(
                    textAlign: TextAlign.start,
                    text: DemoLocalization.of(context)!.translate('Viewallofourhelparticles').toString(),//"View all of our help articles",
                    fontSize: 6,
                    color: FitnessColor.colorTextPrimary,
                    fontWeight: FontWeight.bold,
                    fontFamily: Fonts.arial //Fonts.arial,
                    ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: Container(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey, width: 0.2),
                  borderRadius:
                      const BorderRadius.all(Radius.circular(10.0)), // Border radius
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    const Icon(Icons.search, color: Colors.grey),
                    const SizedBox(width: 5),
                    CustomText(
                        text: DemoLocalization.of(context)!.translate('Search').toString(),//"Search",
                        fontSize: 4,
                        color: FitnessColor.colorTextPrimary,
                        fontWeight: FontWeight.normal,
                        fontFamily: Fonts.arial //Fonts.arial,
                        ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: GestureDetector(
                onTap: (){
                  Navigator.of(context).
                  pushReplacement(MaterialPageRoute(builder:(context) => const FAQSScreen()));
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: const BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                  elevation: 1,
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
                                    text: DemoLocalization.of(context)!.translate('FAQS').toString(),//"FAQS",
                                    fontSize: 4,
                                    color: FitnessColor.colorTextPrimary,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: Fonts.arial //Fonts.arial,
                                    ),
                                CustomText(
                                    text:DemoLocalization.of(context)!.translate('Ourmost').toString(),
                                      //  "Our most frequently asked questions about \nFTB and gettting the most out of your running",
                                    fontSize: 3,
                                    color: FitnessColor.colorTextPrimary,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: Fonts.arial //Fonts.arial,
                                    ),
                              ],
                            ),
                            const Spacer(),
                            const Padding(
                                padding: EdgeInsets.only(bottom: 0.0),
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
            const SizedBox(
              height: 10,
            ),
            Center(
              child: GestureDetector(
                onTap: (){
                  Navigator.of(context).
                  pushReplacement(MaterialPageRoute(builder:(context) => const FAQSScreen()));
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: const BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                  elevation: 1,
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
                                    text: DemoLocalization.of(context)!.translate('Trainingforagoal').toString(),//"Training for a goal",
                                    fontSize: 4,
                                    color: FitnessColor.colorTextPrimary,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: Fonts.arial //Fonts.arial,
                                    ),
                                CustomText(
                                    text:DemoLocalization.of(context)!.translate('Checkout').toString(),
                                     //   "Check out our handy guides covering everything \nfrom 5Ks through to ultramarathons",
                                    fontSize: 3,
                                    color: FitnessColor.colorTextPrimary,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: Fonts.arial //Fonts.arial,
                                    ),
                              ],
                            ),
                            const Spacer(),
                            const Padding(
                                padding: EdgeInsets.only(bottom: 0.0),
                                child: Icon(Icons.arrow_forward_ios,
                                    color: FitnessColor.colormonthbgcolor)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: GestureDetector(
                onTap: (){
                  Navigator.of(context).
                  pushReplacement(MaterialPageRoute(builder:(context) => const FAQSScreen()));
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: const BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                  elevation: 1,
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
                                    text: DemoLocalization.of(context)!.translate('Injurymanagement').toString(),//"Injury management",
                                    fontSize: 4,
                                    color: FitnessColor.colorTextPrimary,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: Fonts.arial //Fonts.arial,
                                    ),
                                CustomText(
                                    text:DemoLocalization.of(context)!.translate('Checkout').toString(),
                                        //"Check out our handy guides covering everything \nfrom 5Ks through to ultramarathons",
                                    fontSize: 3,
                                    color: FitnessColor.colorTextPrimary,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: Fonts.arial //Fonts.arial,
                                    ),
                              ],
                            ),
                            const Spacer(),
                            const Padding(
                                padding: EdgeInsets.only(bottom: 0.0),
                                child: Icon(Icons.arrow_forward_ios,
                                    color: FitnessColor.colormonthbgcolor)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: GestureDetector(
                onTap: (){
                  Navigator.of(context).
                  pushReplacement(MaterialPageRoute(builder:(context) => const FAQSScreen()));
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: const BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                  elevation: 1,
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
                                    text:  DemoLocalization.of(context)!.translate('MobilityPilates').toString(),//"Mobility/Pilates",
                                    fontSize: 4,
                                    color: FitnessColor.colorTextPrimary,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: Fonts.arial //Fonts.arial,
                                    ),
                                CustomText(
                                    text:DemoLocalization.of(context)!.translate('Checkout').toString(),
                                       // "Check out our handy guides covering everything \nfrom 5Ks through to ultramarathons",
                                    fontSize: 3,
                                    color: FitnessColor.colorTextPrimary,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: Fonts.arial //Fonts.arial,
                                    ),
                              ],
                            ),
                            const Spacer(),
                            const Padding(
                                padding: EdgeInsets.only(bottom: 0.0),
                                child: Icon(Icons.arrow_forward_ios,
                                    color: FitnessColor.colormonthbgcolor)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: GestureDetector(
                onTap: (){
                  Navigator.of(context).
                  pushReplacement(MaterialPageRoute(builder:(context) => const FAQSScreen()));
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: const BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                  elevation: 1,
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
                                    text: DemoLocalization.of(context)!.translate('Runningskills').toString(),//"Running skills",
                                    fontSize: 4,
                                    color: FitnessColor.colorTextPrimary,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: Fonts.arial //Fonts.arial,
                                    ),
                                CustomText(
                                    text:DemoLocalization.of(context)!.translate('Checkout').toString(),
                                       // "Check out our handy guides covering everything \nfrom 5Ks through to ultramarathons",
                                    fontSize: 3,
                                    color: FitnessColor.colorTextPrimary,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: Fonts.arial //Fonts.arial,
                                    ),
                              ],
                            ),
                            const Spacer(),
                            const Padding(
                                padding: EdgeInsets.only(bottom: 0.0),
                                child: Icon(Icons.arrow_forward_ios,
                                    color: FitnessColor.colormonthbgcolor)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: GestureDetector(
                onTap: (){
                  Navigator.of(context).
                  pushReplacement(MaterialPageRoute(builder:(context) => const FAQSScreen()));
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: const BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                  elevation: 1,
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
                                    text: DemoLocalization.of(context)!.translate('Nutrition').toString(),//"Nutrition",
                                    fontSize: 4,
                                    color: FitnessColor.colorTextPrimary,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: Fonts.arial //Fonts.arial,
                                    ),
                                CustomText(
                                    text:DemoLocalization.of(context)!.translate('Checkout').toString(),
                                     //   "Check out our handy guides covering everything \nfrom 5Ks through to ultramarathons",
                                    fontSize: 3,
                                    color: FitnessColor.colorTextPrimary,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: Fonts.arial //Fonts.arial,
                                    ),
                              ],
                            ),
                            const Spacer(),
                            const Padding(
                                padding: EdgeInsets.only(bottom: 0.0),
                                child: Icon(Icons.arrow_forward_ios,
                                    color: FitnessColor.colormonthbgcolor)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: GestureDetector(
                onTap: (){
                  Navigator.of(context).
                  pushReplacement(MaterialPageRoute(builder:(context) => const FAQSScreen()));
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: const BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                  elevation: 1,
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
                                    text: DemoLocalization.of(context)!.translate('Strengthmovements').toString(),//"Strength movements",
                                    fontSize: 4,
                                    color: FitnessColor.colorTextPrimary,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: Fonts.arial //Fonts.arial,
                                    ),
                                CustomText(
                                    text:DemoLocalization.of(context)!.translate('Checkout').toString(),
                                   //     "Check out our handy guides covering everything \nfrom 5Ks through to ultramarathons",
                                    fontSize: 3,
                                    color: FitnessColor.colorTextPrimary,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: Fonts.arial //Fonts.arial,
                                    ),
                              ],
                            ),
                            const Spacer(),
                            const Padding(
                                padding: EdgeInsets.only(bottom: 0.0),
                                child: Icon(Icons.arrow_forward_ios,
                                    color: FitnessColor.colormonthbgcolor)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: GestureDetector(
                onTap: (){
                  Navigator.of(context).
                  pushReplacement(MaterialPageRoute(builder:(context) => const FAQSScreen()));
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: const BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                  elevation: 1,
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
                                    text: DemoLocalization.of(context)!.translate('Toptips').toString(),//"Top-tips",
                                    fontSize: 4,
                                    color: FitnessColor.colorTextPrimary,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: Fonts.arial //Fonts.arial,
                                    ),
                                CustomText(
                                    text:DemoLocalization.of(context)!.translate('Checkout').toString(),
                                     //   "Check out our handy guides covering everything \nfrom 5Ks through to ultramarathons",
                                    fontSize: 3,
                                    color: FitnessColor.colorTextPrimary,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: Fonts.arial //Fonts.arial,
                                    ),
                              ],
                            ),
                            const Spacer(),
                            const Padding(
                                padding: EdgeInsets.only(bottom: 0.0),
                                child: Icon(Icons.arrow_forward_ios,
                                    color: FitnessColor.colormonthbgcolor)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: GestureDetector(
                onTap: (){
                  Navigator.of(context).
                  pushReplacement(MaterialPageRoute(builder:(context) => const FAQSScreen()));
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: const BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                  elevation: 1,
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
                                    text:  DemoLocalization.of(context)!.translate('TriathlonTraining').toString(),//"Triathlon Training",
                                    fontSize: 4,
                                    color: FitnessColor.colorTextPrimary,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: Fonts.arial //Fonts.arial,
                                    ),
                                CustomText(
                                    text:DemoLocalization.of(context)!.translate('Checkout').toString(),
                                       // "Check out our handy guides covering everything \nfrom 5Ks through to ultramarathons",
                                    fontSize: 3,
                                    color: FitnessColor.colorTextPrimary,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: Fonts.arial //Fonts.arial,
                                    ),
                              ],
                            ),
                            const Spacer(),
                            const Padding(
                                padding: EdgeInsets.only(bottom: 0.0),
                                child: Icon(Icons.arrow_forward_ios,
                                    color: FitnessColor.colormonthbgcolor)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: GestureDetector(
                onTap: (){
                  Navigator.of(context).
                  pushReplacement(MaterialPageRoute(builder:(context) => const FAQSScreen()));
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: const BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                  elevation: 1,
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
                                    text: DemoLocalization.of(context)!.translate('Runnaapp').toString(),//"Runna app",
                                    fontSize: 4,
                                    color: FitnessColor.colorTextPrimary,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: Fonts.arial //Fonts.arial,
                                    ),
                                CustomText(
                                    text:DemoLocalization.of(context)!.translate('Checkout').toString(),
                                      //  "Check out our handy guides covering everything \nfrom 5Ks through to ultramarathons",
                                    fontSize: 3,
                                    color: FitnessColor.colorTextPrimary,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: Fonts.arial //Fonts.arial,
                                    ),
                              ],
                            ),
                            const Spacer(),
                            const Padding(
                                padding: EdgeInsets.only(bottom: 0.0),
                                child: Icon(Icons.arrow_forward_ios,
                                    color: FitnessColor.colormonthbgcolor)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: GestureDetector(
                onTap: (){
                  Navigator.of(context).
                  pushReplacement(MaterialPageRoute(builder:(context) => const FAQSScreen()));
                },
                child: Card(
                  // color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: const BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                  elevation: 1,
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
                                    text: DemoLocalization.of(context)!.translate('Justforfun').toString(),//"Just for fun",
                                    fontSize: 4,
                                    color: FitnessColor.colorTextPrimary,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: Fonts.arial //Fonts.arial,
                                    ),
                                CustomText(
                                    text:DemoLocalization.of(context)!.translate('Checkout').toString(),
                                    //"Check out our handy guides covering everything \nfrom 5Ks through to ultramarathons",
                                    fontSize: 3,
                                    color: FitnessColor.colorTextPrimary,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: Fonts.arial //Fonts.arial,
                                    ),
                              ],
                            ),
                            const Spacer(),
                            const Padding(
                                padding: EdgeInsets.only(bottom: 0.0),
                                child: Icon(Icons.arrow_forward_ios,
                                    color: FitnessColor.colormonthbgcolor)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 70,
            ),
          ],
        ),
      ),
    ));
  }

  // Route<Object?> createRoute() {}

  Route createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const SignOutScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0); // Start from top
        const end = Offset.zero; // End at center
        const curve = Curves.ease;
        const delay =
            Duration(milliseconds: 600); // Delay before the transition starts

        // Creating the tween for the slide transition
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        // Applying the delay to the animation
        var delayedAnimation = CurvedAnimation(
          parent: animation,
          curve: Interval(
            delay.inMilliseconds / 2000,
            // Convert delay to seconds for Interval
            1.0,
            curve: curve,
          ),
        );
        return SlideTransition(
          position: delayedAnimation.drive(tween),

          // position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}

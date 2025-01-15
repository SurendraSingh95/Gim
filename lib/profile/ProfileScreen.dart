import 'dart:io';

import 'package:fitness/Screens/profile_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../colors.dart';
import '../custom/CstAppbarWithtextimage.dart';
import '../custom/CustomButton.dart';
import '../custom/CustomText.dart';
import '../custom/Fonts.dart';
import '../utils/Demo_Localization.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  final List<Map<String, dynamic>> items = [
    {
      'title': '1 month videos',
      'image': 'assets/images/profileimg1.png',
      'subtitle': 'Full Shot man Stretching Arm',
      'details': 'View more details',
      'level': 'Beginner',
      'time': '30 min'
    },
    {
      'title': '3 month videos',
      'image': 'assets/images/profileimg2.png',
      'subtitle': 'Half Shot man Running',
      'details': 'View more details',
      'level': 'Intermediate',
      'time': '30 min'
    },
    {
      'title': '6 month videos',
      'image': 'assets/images/profileimg3.png',
      'subtitle': 'Full Shot man Stretching Arm',
      'details': 'View more details',
      'level': 'Advanced',
      'time': '30 min'
    },
  ];

  final List<Map<String, dynamic>> itSubcriptionPlan = [
    {
      'month': '1 month',
      'year': 'Yearly',
      'price': '\$6.99',
    },
    {
      'month': '3 month',
      'year': 'Yearly',
      'price': '\$29.99',
    },
    {
      'month': '6 month',
      'year': 'Life-Time',
      'price': '\$49.99',
    },
  ];

  int selectedIndex = -1;

  String? userName,userEmail;
  String? userId;


  // String? userEmailget;

  void fetchUserEmail() {
    User? user = FirebaseAuth.instance.currentUser; // Get the current user
    if (user != null) {
      userEmail = user.email; // Fetch and store the email
    }
  }

  @override
  void initState() {
    super.initState();
    getSharePreferences();
  }



  getSharePreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString("userid");
      userName = prefs.getString("username");
      userEmail = prefs.getString("useremail");

      // print("Type=================userId get ${userId}");
    //  print("Type=================userId userName ${userName}");
    //  print("Type=================userId userEmail ${userEmail}");
    });
  }
  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Row(
          children: [
            Icon(
              Icons.exit_to_app,
              color: Colors.redAccent,
            ),
            SizedBox(width: 10),
            Text(
              'Exit App',
              style: TextStyle(
                color: Colors.redAccent,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
        content: const Text(
          'Are you sure you want to exit the app?',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 16,
          ),
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.grey[200],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () => Navigator.of(context).pop(false), // Dismiss dialog
            child: Text(
              'Cancel',
              style: TextStyle(
                color: Colors.grey[800],
              ),
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.redAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () => exit(0),
            child: const Text(
              'Exit',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    )) ??
        false;
  }
  @override
  Widget build(BuildContext context) {


    return PopScope(
      canPop:false,
      onPopInvoked: (val) async{
        _onWillPop();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  CstAppbarWithtextimage (
                    title: DemoLocalization.of(context)!.translate('Profile').toString(),//'Profile',
                    icon: Icons.arrow_back_ios,
                    imageAsset: 'assets/images/editbtn.png',
                    // Uncomment this line to show the image
                    fontFamily: Fonts.roboto,
                      onImageTap: (){

                      }
                  ),
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage:
                          AssetImage('assets/images/profilecircle.png'),
                    ),
                  ),
                  CustomText(
                      text: DemoLocalization.of(context)!.translate('Rahul').toString(),//"Rahul",
                      fontSize: 6,
                      color: FitnessColor.colorTextPrimary,
                      fontWeight: FontWeight.bold,
                      fontFamily: Fonts.roboto //Fonts.roboto,
                      ),
                  ListView.builder(
                    itemCount: 3,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return Container(
                        // height: screenSize.height * 0.15,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                                text: item['title'],
                                fontSize: 5,
                                color: FitnessColor.colorTextPrimary,
                                fontWeight: FontWeight.bold,
                                fontFamily: Fonts.anton //Fonts.roboto,
                                ),
                            Image.asset(item['image'],width: MediaQuery.of(context).size.width,fit: BoxFit.fill,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                    text: item['subtitle'],
                                    fontSize: 3.5,
                                    color: FitnessColor.colorTextPrimary,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: Fonts.montserrat //Fonts.roboto,
                                    ),
                                CustomText(
                                    text: item['details'],
                                    fontSize: 3,
                                    color: FitnessColor.colorTextPrimary,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: Fonts.anton //Fonts.roboto,
                                    ),
                              ],
                            ),
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                    text: item['level'],
                                    fontSize: 3,
                                    color: FitnessColor.colorTextPrimary,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: Fonts.montserrat //Fonts.roboto,
                                    ),
                                CustomText(
                                    text: "   |   ",
                                    fontSize: 3,
                                    color: FitnessColor.colorTextPrimary,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: Fonts.montserrat //Fonts.roboto,
                                    ),
                                Container(
                                  child: const Icon(
                                    Icons.watch_later_outlined,
                                    size: 14,
                                  ),
                                ),
                                const SizedBox(
                                  width: 3,
                                ),
                                CustomText(
                                    text: item['time'],
                                    fontSize: 3,
                                    color: FitnessColor.colorTextPrimary,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: Fonts.montserrat //Fonts.roboto,
                                    ),
                              ],
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            const Divider(),
                            const SizedBox(
                              width: 3,
                            ),
                          ],
                        ),
                      );
                      // );
                    },
                  ),
                  CustomText(
                      text: DemoLocalization.of(context)!.translate('SubscriptionPlan').toString(),//"Subscription Plan",
                      fontSize: 8,
                      color: FitnessColor.colorTextFour,
                      fontWeight: FontWeight.bold,
                      fontFamily: Fonts.anton //Fonts.roboto,
                      ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CustomText(
                        text:DemoLocalization.of(context)!.translate('Itistext').toString(),// "It is a long established fact that a reader will be distracted by the readable",
                        fontSize: 4,
                        color: FitnessColor.colorTextPrimary,
                        fontWeight: FontWeight.normal,
                        textAlign: TextAlign.center,
                        fontFamily: Fonts.montserrat //Fonts.roboto,
                        ),
                  ),

                  Container(
                    // color: Colors.red,
                    // width: 200,
                    height: 160,
                    child: ListView.builder(
                      itemCount: 3,
                      //  physics: NeverScrollableScrollPhysics(),
                      // shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final itSubcription = itSubcriptionPlan[index];
                        final bool isSelected = index == selectedIndex;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                            });
                          },
                          child: Center(
                            child: Container(
                              // color: Colors.red,
                              // width: 110,
                              width: MediaQuery.of(context).size.width/3.25,
                              height: 150,
                              child: Padding(
                                padding:  const EdgeInsets.all(4.0),
                                child: Card(

                                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                                  color: isSelected ? FitnessColor.primaryLite.withOpacity(0.01) : FitnessColor.colorinsidebox,

                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      side: BorderSide(
                                        color: isSelected ? FitnessColor.coloroutlineborder : Colors.transparent,
                                        width: 2.0,
                                      )),

                                  elevation: 4,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: 36,
                                        // color: Colors.grey,
                                        decoration: BoxDecoration(
                                          color: isSelected ? FitnessColor.coloroutlineborder : FitnessColor.colormonthbgcolor.withOpacity(0.30),

                                          // color: FitnessColor.coloroutlineborder,
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(10.0),
                                            topRight: Radius.circular(10.0),
                                          ),
                                        ),
                                        child: Center(
                                          child:Text(
                                            itSubcription['month'].toUpperCase(),

                                            style: TextStyle(
                                              fontSize: 12,
                                              color: isSelected ? FitnessColor.colorinsidebox : FitnessColor.colorfillText,
                                              fontFamily: Fonts.anton,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),

                                      const SizedBox(height: 16,),
                                      Column(
                                        children: [
                                          Text(
                                            itSubcription['year'],
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: isSelected ? FitnessColor.colortextselectbox : FitnessColor.colorTextPrimary,

                                              //color: FitnessColor.primaryLite,
                                              fontFamily: Fonts.montserrat,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                          Text(
                                            itSubcription['price'],
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontFamily: Fonts.montserrat,
                                              color: FitnessColor.colorTextThird,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),

                                          if (isSelected)
                                            const Icon(
                                              Icons.check_circle,
                                              color: FitnessColor.colorTextThird,
                                            ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                        // );
                      },
                    ),
                  ),
                  Center(
                    child: CustomButton(
                      text: DemoLocalization.of(context)!.translate('MakePayment').toString(),//'Make Payment',
                      fontFamily: Fonts.roboto,
                      fontSize: 22,
                      color: FitnessColor.colorTextThird,
                      onPressed: () {
                        // Navigator.of(context).pushReplacement(MaterialPageRoute(
                        //     builder: (context) => const HomeDetailsScreen ()));
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CustomText(
                        text:DemoLocalization.of(context)!.translate('webringtext').toString(),//  "We bring the most deserving ones to flattery with just a hate payment of \$199 those who are softened and corrupted by present pleasures",
                        fontSize: 3,
                        color: FitnessColor.coloroutlineborder,
                        fontWeight: FontWeight.normal,
                        textAlign: TextAlign.center,
                        fontFamily: Fonts.montserrat //Fonts.roboto,
                        ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}

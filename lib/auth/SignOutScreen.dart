import 'package:fitness/auth/LoginScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../colors.dart';
import '../custom/CstAppbarWithtextimage.dart';
import '../custom/CustomText.dart';
import '../custom/Fonts.dart';
import '../utils/Demo_Localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignOutScreen extends StatefulWidget {
  const SignOutScreen({super.key});

  @override
  State<SignOutScreen> createState() => _SignOutScreenState();
}

class _SignOutScreenState extends State<SignOutScreen> {
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

  String? userName,userEmail;
  String? userId;
  @override
  void initState() {
    super.initState();
    // _checkInternetConnection();
    getSharePreferences();
  }

  getSharePreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString("userid");
    });
  }


  void fetchUserEmail() {
    User? user = FirebaseAuth.instance.currentUser; // Get the current user
    if (user != null) {
      userEmail = user.email; // Fetch and store the email
    }
  }

  @override
  Widget build(BuildContext context) {
    fetchUserEmail();

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
                     Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16, top: 16),
                      child: CstAppbarWithtextimage(
                          title: '',
                          icon: Icons.arrow_back_ios,
                          fontFamily: Fonts.anton,
                          onImageTap: (){
                          }
                      ),
                    ),
                    SizedBox(height: 20),

                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage('assets/images/profileedit.png'),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomText(
                            textAlign: TextAlign.center,
                            text: userEmail.toString(),//"Ram",
                            fontSize: 6,
                            color: FitnessColor.colorTextPrimary,
                            fontWeight: FontWeight.bold,
                            fontFamily: Fonts.roboto //Fonts.roboto,
                        ),
                      ],
                    ),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                            textAlign: TextAlign.center,
                            text:DemoLocalization.of(context)!.translate('JoinedAug').toString(),//"Joined Aug 2024",
                            fontSize: 4,
                            color: FitnessColor.colorTextPrimary,
                            fontWeight: FontWeight.normal,
                            fontFamily: Fonts.roboto //Fonts.roboto,
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),
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
                            text: DemoLocalization.of(context)!.translate('Editprofile').toString().toUpperCase(),//"Edit profile".toUpperCase(),
                            fontSize: 3,
                            color: FitnessColor.colorinsidebox,
                            fontWeight: FontWeight.normal,
                            fontFamily: Fonts.roboto,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
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
                                            fontFamily: Fonts.roboto //Fonts.roboto,
                                        ),
                                        CustomText(
                                            text: DemoLocalization.of(context)!.translate('Rs').toString(),//"Rs. 10,800.00/year",
                                            fontSize: 3,
                                            color: FitnessColor.colorTextPrimary,
                                            fontWeight: FontWeight.normal,
                                            fontFamily:
                                            Fonts.montserrat //Fonts.roboto,
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
                                              padding:
                                              EdgeInsets.symmetric(horizontal: 5),
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
                                                    fontFamily: Fonts.montserrat,
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
                                              Fonts.montserrat //Fonts.roboto,
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
                                            text: DemoLocalization.of(context)!.translate('Rsweek').toString(),//"Monthly (1 week free)",
                                            fontSize: 4,
                                            color: FitnessColor.colorTextPrimary,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: Fonts.roboto //Fonts.roboto,
                                        ),
                                        CustomText(
                                            text: DemoLocalization.of(context)!.translate('RsMonth').toString(),//"Rs. 1,999.00/month",
                                            fontSize: 3,
                                            color: FitnessColor.colorTextPrimary,
                                            fontWeight: FontWeight.normal,
                                            fontFamily:
                                            Fonts.montserrat //Fonts.roboto,
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
                                              Fonts.montserrat //Fonts.roboto,
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
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Container(
                        height: 50,
                        padding: EdgeInsets.symmetric(
                            horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey, width: 0.2),
                          borderRadius: BorderRadius.all(
                              Radius.circular(
                                  10.0)), // Border radius
                        ),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.start,
                          children: <Widget>[

                            CustomText(
                                text: DemoLocalization.of(context)!.translate('ReferralCode').toString(),//"Referral Code",
                                fontSize: 4,
                                color: FitnessColor
                                    .colorTextPrimary,
                                fontWeight: FontWeight.normal,
                                fontFamily: Fonts
                                    .montserrat //Fonts.roboto,
                            ),
                            // SizedBox(width: 5),
                            Spacer(),
                            Icon(Icons.arrow_forward_ios,
                                color: Colors.grey),

                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Container(
                        height: 50,
                        padding: EdgeInsets.symmetric(
                            horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey, width: 0.2),
                          borderRadius: BorderRadius.all(
                              Radius.circular(
                                  10.0)), // Border radius
                        ),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.start,
                          children: <Widget>[
                            Icon(Icons.confirmation_num_outlined,
                                color: Colors.grey),
                            SizedBox(width: 5,),
                            CustomText(
                                text: DemoLocalization.of(context)!.translate('ConnectedApps').toString(),//"Connected Apps & Watches",
                                fontSize: 4,
                                color: FitnessColor
                                    .colorTextPrimary,
                                fontWeight: FontWeight.normal,
                                fontFamily: Fonts
                                    .montserrat //Fonts.roboto,
                            ),
                            // SizedBox(width: 5),
                            Spacer(),
                            Icon(Icons.arrow_forward_ios,
                                color: Colors.grey),

                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Container(
                        height: 50,
                        padding: EdgeInsets.symmetric(
                            horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey, width: 0.2),
                          borderRadius: BorderRadius.all(
                              Radius.circular(
                                  10.0)), // Border radius
                        ),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.start,
                          children: <Widget>[
                            Icon(Icons.confirmation_num_outlined,
                                color: Colors.grey),
                            SizedBox(width: 5,),
                            CustomText(
                                text: DemoLocalization.of(context)!.translate('MyShoes').toString(),//"My Shoes",
                                fontSize: 4,
                                color: FitnessColor
                                    .colorTextPrimary,
                                fontWeight: FontWeight.normal,
                                fontFamily: Fonts
                                    .montserrat //Fonts.roboto,
                            ),
                            // SizedBox(width: 5),
                            Spacer(),
                            Icon(Icons.arrow_forward_ios,
                                color: Colors.grey),

                          ],
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Container(
                        height: 50,
                        padding: EdgeInsets.symmetric(
                            horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey, width: 0.2),
                          borderRadius: BorderRadius.all(
                              Radius.circular(
                                  10.0)), // Border radius
                        ),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.start,
                          children: <Widget>[
                            Icon(Icons.confirmation_num_outlined,
                                color: Colors.grey),
                            SizedBox(width: 5,),
                            CustomText(
                                text: DemoLocalization.of(context)!.translate('WorkoutSettings').toString(),//"Workout Settings",
                                fontSize: 4,
                                color: FitnessColor
                                    .colorTextPrimary,
                                fontWeight: FontWeight.normal,
                                fontFamily: Fonts
                                    .montserrat //Fonts.roboto,
                            ),
                            // SizedBox(width: 5),
                            Spacer(),
                            Icon(Icons.arrow_forward_ios,
                                color: Colors.grey),

                          ],
                        ),
                      ),
                    ),


                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Container(
                        height: 50,
                        padding: EdgeInsets.symmetric(
                            horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey, width: 0.2),
                          borderRadius: BorderRadius.all(
                              Radius.circular(
                                  10.0)), // Border radius
                        ),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.start,
                          children: <Widget>[
                            Icon(Icons.confirmation_num_outlined,
                                color: Colors.grey),
                            SizedBox(width: 5,),
                            CustomText(
                                text: DemoLocalization.of(context)!.translate('PhoneRecordingSettings').toString(),//"Phone Recording Settings",
                                fontSize: 4,
                                color: FitnessColor
                                    .colorTextPrimary,
                                fontWeight: FontWeight.normal,
                                fontFamily: Fonts
                                    .montserrat //Fonts.roboto,
                            ),
                            // SizedBox(width: 5),
                            Spacer(),
                            Icon(Icons.arrow_forward_ios,
                                color: Colors.grey),

                          ],
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Container(
                        height: 50,
                        padding: EdgeInsets.symmetric(
                            horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey, width: 0.2),
                          borderRadius: BorderRadius.all(
                              Radius.circular(
                                  10.0)), // Border radius
                        ),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.start,
                          children: <Widget>[
                            Icon(Icons.confirmation_num_outlined,
                                color: Colors.grey),
                            SizedBox(width: 5,),
                            CustomText(
                                text: DemoLocalization.of(context)!.translate('UnitsofMeasure').toString(),//"Units of Measure",
                                fontSize: 4,
                                color: FitnessColor
                                    .colorTextPrimary,
                                fontWeight: FontWeight.normal,
                                fontFamily: Fonts
                                    .montserrat //Fonts.roboto,
                            ),
                            // SizedBox(width: 5),
                            Spacer(),
                            Icon(Icons.arrow_forward_ios,
                                color: Colors.grey),

                          ],
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Container(
                        height: 50,
                        padding: EdgeInsets.symmetric(
                            horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey, width: 0.2),
                          borderRadius: BorderRadius.all(
                              Radius.circular(
                                  10.0)), // Border radius
                        ),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.start,
                          children: <Widget>[
                            Icon(Icons.confirmation_num_outlined,
                                color: Colors.grey),
                            SizedBox(width: 5,),
                            CustomText(
                                text: DemoLocalization.of(context)!.translate('NotificationSettings').toString(),//"Notification Settings",
                                fontSize: 4,
                                color: FitnessColor
                                    .colorTextPrimary,
                                fontWeight: FontWeight.normal,
                                fontFamily: Fonts
                                    .montserrat //Fonts.roboto,
                            ),
                            // SizedBox(width: 5),
                            Spacer(),
                            Icon(Icons.arrow_forward_ios,
                                color: Colors.grey),

                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 20,),
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        // border: Border.all(color: Colors.red, width: 1),
                        borderRadius:
                        BorderRadius.all(Radius.circular(10.0)), // Border radius
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.confirmation_num_outlined,
                              color: FitnessColor.colorinsidebox),
                          SizedBox(width: 5,),
                          GestureDetector(
                            onTap: (){
                              showLogoutDialog(context);
                          },
                            child: CustomText(
                              text: DemoLocalization.of(context)!.translate('Signout').toString(),//"Sign out",
                              fontSize: 4,
                              color: FitnessColor.colorinsidebox,
                              fontWeight: FontWeight.bold,
                              fontFamily: Fonts.roboto,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,

                      children: [
                        CustomText(
                            text:DemoLocalization.of(context)!.translate('Termsandconditions').toString().toUpperCase(), //"Terms and conditions".toUpperCase(),
                            fontSize: 3,
                            color: FitnessColor.colorTextPrimary,
                            fontWeight: FontWeight.bold,
                            fontFamily: Fonts.roboto //Fonts.roboto,
                        ),
                        SizedBox(height: 20,),
                        CustomText(
                            text: DemoLocalization.of(context)!.translate('PrivacyPolicy').toString().toUpperCase(),//"Privacy Policy".toUpperCase(),
                            fontSize: 3,
                            color: FitnessColor.colorTextPrimary,
                            fontWeight: FontWeight.bold,
                            fontFamily: Fonts.roboto //Fonts.roboto,
                        ),
                        SizedBox(height: 20,),
                        CustomText(
                            text: DemoLocalization.of(context)!.translate('RestorePurchases').toString().toUpperCase(),//"Restore Purchases".toUpperCase(),
                            fontSize: 3,
                            color: FitnessColor.colorTextPrimary,
                            fontWeight: FontWeight.bold,
                            fontFamily: Fonts.roboto //Fonts.roboto,
                        ),
                        SizedBox(height: 20,),
                        CustomText(
                            text: DemoLocalization.of(context)!.translate('Careers').toString().toUpperCase(),//"Careers".toUpperCase(),
                            fontSize: 3,
                            color: FitnessColor.colorTextPrimary,
                            fontWeight: FontWeight.bold,
                            fontFamily: Fonts.roboto //Fonts.roboto,
                        ),
                        SizedBox(height: 20,)
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout'),
          content: Text('Do you want to log out?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('No'),
            ),
            ElevatedButton(
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setString('userid', "");
                Navigator.of(context).pop(); // Close the dialog
                try {

                  await FirebaseAuth.instance.signOut(); // Sign out from Firebase
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (context) =>
                              LoginScreen())); // Navigate to login screen
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Logout failed: $e')),
                  );
                }
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness/Controllers/HomeController/home_controller.dart';
import 'package:fitness/Screens/Settings/change_thems.dart';
import 'package:fitness/Screens/Settings/privacy_policy_screen.dart';
import 'package:fitness/Screens/Settings/terms_condtion_screen.dart';
import 'package:fitness/Screens/get_my_plan_screen.dart';
import 'package:fitness/auth/LoginScreen.dart';
import 'package:fitness/auth/change_password_screen.dart';
import 'package:fitness/auth/settings_page.dart';
import 'package:fitness/custom/CustomButton.dart';
import 'package:fitness/custom/profile_button.dart';
import 'package:fitness/profile/edit_profile.dart';
import 'package:fitness/utils/shared_preferences.dart';
import 'package:fitness/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../colors.dart';
import '../custom/CstAppbarWithtextimage.dart';
import '../custom/CustomText.dart';
import '../custom/Fonts.dart';
import '../utils/Demo_Localization.dart';

class SignOutScreen extends StatefulWidget {
  const SignOutScreen({super.key});

  @override
  State<SignOutScreen> createState() => _SignOutScreenState();
}

class _SignOutScreenState extends State<SignOutScreen> {
  HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    homeController.getProfileApi();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
        backgroundColor: isDarkMode ? FitnessColor.primary : FitnessColor.white,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 10.0, right: 16, top: 16),
                      child: CstAppbarWithtextimage(
                          title: DemoLocalization.of(context)!
                              .translate('Profile')
                              .toString(),
                          icon: Icons.arrow_back_ios,
                          fontFamily: Fonts.arial,
                          onImageTap: () {
                            homeController.getProfileApi();
                            Get.back();
                          }),
                    ),
                    const SizedBox(height: 10),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        // CircleAvatar for the profile image
                        Obx(() {
                          return Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: homeController.profileData.isEmpty
                                  ? const CupertinoActivityIndicator()
                                  : homeController.profileData.first
                                                  .profileImage ==
                                              null ||
                                          homeController.profileData.first
                                                  .profileImage ==
                                              ""
                                      ? Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            side: BorderSide(
                                              color:
                                                  Colors.black.withOpacity(0.2),
                                              width: 1,
                                            ),
                                          ),
                                          child: const CircleAvatar(
                                            radius: 55,
                                            backgroundImage: AssetImage(
                                                "assets/images/no Image.png"), // Default icon if no profile image
                                          ),
                                        )
                                      : Card(
                                          //color: FitnessColor.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            side: BorderSide(
                                              color:
                                                  Colors.black.withOpacity(0.2),
                                              width: 1,
                                            ),
                                          ),
                                          child: CircleAvatar(
                                            backgroundColor: FitnessColor.white,
                                            radius: 55,
                                            backgroundImage: NetworkImage(
                                                "https://tfbfitness.com/${homeController.profileData.first.profileImage}"),
                                          ),
                                        ));
                        }),
                        Positioned(
                          bottom: -20,
                          top: 30,
                          right: 10,
                          child: GestureDetector(
                            onTap: () {
                              Get.to(() => EditProfileScreen(
                                    profileImage: homeController
                                        .profileData.first.profileImage,
                                  ));
                            },
                            child: const CircleAvatar(
                              radius: 15,
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.edit,
                                size: 15,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            CustomText(
                                textAlign: TextAlign.center,
                                text:
                                    homeController.profileData.first.name ?? "",
                                fontSize: 5,
                                color: FitnessColor.colorTextPrimary,
                                fontWeight: FontWeight.bold,
                                fontFamily: Fonts.arial //Fonts.arial,
                                ),
                            CustomText(
                                textAlign: TextAlign.center,
                                text: homeController.profileData.first.email ??
                                    "",
                                fontSize: 4.2,
                                color: FitnessColor.colorTextPrimary,
                                fontWeight: FontWeight.bold,
                                fontFamily: Fonts.arial //Fonts.arial,
                                ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          textAlign: TextAlign.center,
                          text:  DemoLocalization.of(context)!
                                  .translate('JoinedAug')
                                  .toString() +
                              ' ${DateFormat('dd-MMM-yyyy').format(DateTime.parse(homeController.profileData.first.createdAt.toString()))}',
                          fontSize: 4,
                          color: FitnessColor.colorTextPrimary,
                          fontWeight: FontWeight.normal,
                          fontFamily: Fonts.arial,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Card(
                      color: isDarkMode
                          ?  FitnessColor.colorView.withOpacity(0.0) : FitnessColor.white,
                      // Dynamic card background color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(
                          color: isDarkMode
                              ? FitnessColor.white.withOpacity(0.4)
                              : FitnessColor.colorsociallogintext.withOpacity(0.5), // Dynamic border color
                          width: 1.0,
                        ),
                      ),
                      elevation: 0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        text: DemoLocalization.of(context)!
                                            .translate('Annual1week')
                                            .toString(),
                                        fontSize: 4,
                                        color: isDarkMode
                                            ? FitnessColor.white
                                            : FitnessColor.primary,
                                        // Dynamic text color
                                        fontWeight: FontWeight.bold,
                                        fontFamily: Fonts.arial,
                                      ),
                                      const SizedBox(height: 5),
                                      CustomText(
                                        text: DemoLocalization.of(context)!
                                            .translate('Rs')
                                            .toString(),
                                        fontSize: 3,
                                        color: isDarkMode
                                            ? FitnessColor.white
                                            : FitnessColor.primary,
                                        // Dynamic text color
                                        fontWeight: FontWeight.bold,
                                        fontFamily: Fonts.arial,
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        height: 20,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          border: Border.all(
                                              color: Colors.red, width: 1),
                                          borderRadius:
                                              const BorderRadius.all(
                                            Radius.circular(
                                                5.0), // Border radius
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            CustomText(
                                              text: DemoLocalization.of(
                                                      context)!
                                                  .translate('SavePer')
                                                  .toString(),
                                              fontSize: 3,
                                              color: isDarkMode
                                                  ? FitnessColor.white
                                                  : FitnessColor.primary,
                                              // Dynamic text color
                                              fontWeight: FontWeight.normal,
                                              fontFamily: Fonts.arial,
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      CustomText(
                                        text: DemoLocalization.of(context)!
                                            .translate('Rsweek')
                                            .toString(),
                                        fontSize: 3,
                                        color: isDarkMode
                                            ? FitnessColor.white
                                            : FitnessColor.primary,
                                        // Dynamic text color
                                        fontWeight: FontWeight.normal,
                                        fontFamily: Fonts.arial,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Card(
                      color: isDarkMode?
                        FitnessColor.colorView.withOpacity(0.0) : FitnessColor.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(
                          color: isDarkMode
                              ? FitnessColor.white.withOpacity(0.4)
                              : FitnessColor.colorsociallogintext.withOpacity(0.5),
                          width: 1.0,
                        ),
                      ),
                      elevation: 0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                          text: DemoLocalization.of(context)!
                                              .translate('Rsweek')
                                              .toString(),
                                          //"Monthly (1 week free)",
                                          fontSize: 4,
                                          color:
                                              FitnessColor.colorTextPrimary,
                                          fontWeight: FontWeight.bold,
                                          fontFamily:
                                              Fonts.arial //Fonts.arial,
                                          ),
                                      CustomText(
                                          text: DemoLocalization.of(context)!
                                              .translate('RsMonth')
                                              .toString(),
                                          //"Rs. 1,999.00/month",
                                          fontSize: 3,
                                          color:
                                              FitnessColor.colorTextPrimary,
                                          fontWeight: FontWeight.normal,
                                          fontFamily:
                                              Fonts.arial //Fonts.arial,
                                          ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 0.0),
                                        child: CustomText(
                                            text:
                                                DemoLocalization.of(context)!
                                                    .translate('RsWeeken')
                                                    .toString(),
                                            //"Rs. 460.04/week",
                                            fontSize: 3,
                                            color:
                                                FitnessColor.colorTextPrimary,
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
                    const SizedBox(
                      height: 8,
                    ),
                    CustomContainer(
                      buttonText: DemoLocalization.of(context)!
                          .translate('Change_Language')
                          .toString(),
                      //"Referral Code",
                      iconData: Icons.arrow_forward_ios,
                      // Example icon
                      onTap: () {
                        Get.to(() => const SettingsPage());
                      },
                      height: 50,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomContainer(
                      buttonText: DemoLocalization.of(context)!
                          .translate('Change_Password')
                          .toString(),
                      //"Referral Code",
                      iconData: Icons.arrow_forward_ios,
                      // Example icon
                      onTap: () {
                        Get.to(() => const ChangePasswordScreen());
                      },
                      height: 50,

                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomContainer(
                      buttonText: DemoLocalization.of(context)!
                          .translate('MyPlan')
                          .toString(),
                      //"Referral Code",
                      iconData: Icons.arrow_forward_ios,
                      // Example icon
                      onTap: () {
                        Get.to(() => const MyPlanList());
                      },
                      height: 50,

                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomContainer(
                      buttonText: DemoLocalization.of(context)!
                          .translate('Change_Themes')
                          .toString(),
                      //"Referral Code",
                      iconData: Icons.arrow_forward_ios,
                      // Example icon
                      onTap: () {
                        Get.to(() => ChangeThemesScreen());
                      },
                      height: 50,

                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomContainer(
                      buttonText: DemoLocalization.of(context)!
                          .translate('Termsandconditions')
                          .toString(),
                      //"Referral Code",
                      iconData: Icons.arrow_forward_ios,
                      // Example icon
                      onTap: () {
                        Get.to(() => const TermsConditionScreen());
                      },
                      height: 50,

                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomContainer(
                      buttonText: DemoLocalization.of(context)!
                          .translate('PrivacyPolicy')
                          .toString(),
                      //"Referral Code",
                      iconData: Icons.arrow_forward_ios,
                      // Example icon
                      onTap: () {
                        Get.to(() => const PrivacyPolicyScreen());
                      },
                      height: 50,

                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    /* CustomContainer(
                      buttonText: DemoLocalization.of(context)!.translate('RestorePurchases').toString(),//"Referral Code",
                      iconData: Icons.arrow_forward_ios, // Example icon
                      onTap: () {
                        //Get.to(()=>const SettingsPage());
                      },
                      height: 50,
                      backgroundColor:Colors.white,
                      textColor: Colors.black87,
                      iconColor:Colors.black45,
                      borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                    ),
                    const SizedBox(height: 10,),
                    CustomContainer(
                      buttonText: DemoLocalization.of(context)!.translate('Careers').toString(),//"Referral Code",
                      iconData: Icons.arrow_forward_ios, // Example icon
                      onTap: () {
                        //Get.to(()=>const SettingsPage());
                      },
                      height: 50,
                      backgroundColor:Colors.white,
                      textColor: Colors.black87,
                      iconColor:Colors.black45,
                      borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                    ),
                    const SizedBox(height: 10,),
                    CustomContainer(
                      buttonText: DemoLocalization.of(context)!.translate('ReferralCode').toString(),//"Referral Code",
                      iconData: Icons.arrow_forward_ios, // Example icon
                      onTap: () {

                      },
                      height: 50,
                      backgroundColor:Colors.white,
                      textColor: Colors.black87,
                      iconColor:Colors.black45,
                      borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                    ),
                    const SizedBox(height: 10,),
                    CustomContainer(
                      buttonText: DemoLocalization.of(context)!.translate('ConnectedApps').toString(),//"Referral Code",
                      iconData: Icons.arrow_forward_ios, // Example icon
                      onTap: () {
                      */ /*  Get.to(()=>const SettingsPage());*/ /*
                      },
                      height: 50,
                      backgroundColor:Colors.white,
                      textColor: Colors.black87,
                      iconColor:Colors.black45,
                      borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                    ),
                    const SizedBox(height: 10,),
                    CustomContainer(
                      buttonText: DemoLocalization.of(context)!.translate('MyShoes').toString(),//"Referral Code",
                      iconData: Icons.arrow_forward_ios, // Example icon
                      onTap: () {
                        */ /*  Get.to(()=>const SettingsPage());*/ /*
                      },
                      height: 50,
                      backgroundColor:Colors.white,
                      textColor: Colors.black87,
                      iconColor:Colors.black45,
                      borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                    ),
                    const SizedBox(height: 10,),
                    CustomContainer(
                      buttonText: DemoLocalization.of(context)!.translate('WorkoutSettings').toString(),//"Referral Code",
                      iconData: Icons.arrow_forward_ios, // Example icon
                      onTap: () {
                        */ /*  Get.to(()=>const SettingsPage());*/ /*
                      },
                      height: 50,
                      backgroundColor:Colors.white,
                      textColor: Colors.black87,
                      iconColor:Colors.black45,
                      borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                    ),
                    const SizedBox(height: 10,),
                    CustomContainer(
                      buttonText: DemoLocalization.of(context)!.translate('PhoneRecordingSettings').toString(),
                      iconData: Icons.arrow_forward_ios, // Example icon
                      onTap: () {
                        */ /*  Get.to(()=>const SettingsPage());*/ /*
                      },
                      height: 50,
                      backgroundColor:Colors.white,
                      textColor: Colors.black87,
                      iconColor:Colors.black45,
                      borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                    ),
                    const SizedBox(height: 10,),
                    CustomContainer(
                      buttonText: DemoLocalization.of(context)!.translate('UnitsofMeasure').toString(),
                      iconData: Icons.arrow_forward_ios, // Example icon
                      onTap: () {
                        */ /*  Get.to(()=>const SettingsPage());*/ /*
                      },
                      height: 50,
                      backgroundColor:Colors.white,
                      textColor: Colors.black87,
                      iconColor:Colors.black45,
                      borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                    ),
                    const SizedBox(height: 10,),*/
                    CustomContainer(
                      buttonText: DemoLocalization.of(context)!
                          .translate('NotificationSettings')
                          .toString(),
                      iconData: Icons.arrow_forward_ios,
                      // Example icon
                      onTap: () {
                        /*  Get.to(()=>const SettingsPage());*/
                      },
                      height: 50,

                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomContainer(
                      buttonText: DemoLocalization.of(context)!
                          .translate('DeleteAccount')
                          .toString(),
                      iconData: Icons.arrow_forward_ios,
                      // Example icon
                      onTap: () async {
                        bool confirmDelete = await Utils.showConfirmDialog(
                            DemoLocalization.of(context)!.translate('DeleteAccount').toString(),
                            DemoLocalization.of(context)!.translate('DELETE_USER').toString(),
                            context);
                        if (confirmDelete) {
                          homeController.deleteAccountApi();
                        }
                      },
                      height: 50,

                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: CustomButton(
                        text: DemoLocalization.of(context)!
                            .translate('Logout')
                            .toString(),
                        fontFamily: Fonts.arial,
                        fontSize: 20,
                        color: FitnessColor.colorTextThird,
                        onPressed: () async {
                          bool confirmLogOut = await Utils.showConfirmDialog(
                              DemoLocalization.of(context)!
                                  .translate('Logout')
                                  .toString(),
                              DemoLocalization.of(context)!
                                  .translate('LogoutMessage')
                                  .toString(),
                              context);
                          if (confirmLogOut) {
                            SharedPref.setLogOut();
                            Get.put<HomeController>(HomeController());

                            Get.off(() => const LoginScreen());
                          }
                        },
                      ),
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
          title: const Text('Logout'),
          content: const Text('Do you want to log out?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('No'),
            ),
            ElevatedButton(
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setString('userid', "");
                Navigator.of(context).pop(); // Close the dialog
                try {
                  await FirebaseAuth.instance
                      .signOut(); // Sign out from Firebase
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) =>
                          const LoginScreen())); // Navigate to login screen
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Logout failed: $e')),
                  );
                }
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }
}

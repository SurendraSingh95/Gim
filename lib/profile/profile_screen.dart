import 'dart:io';
import 'package:fitness/Controllers/HomeController/home_controller.dart';
import 'package:fitness/Screens/home_screen.dart';
import 'package:fitness/Utils/utils.dart';
import 'package:fitness/auth/LoginScreen.dart';
import 'package:fitness/custom/my_shimmer.dart';
import 'package:fitness/utils/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../colors.dart';
import '../custom/CstAppbarWithtextimage.dart';
import '../custom/CustomButton.dart';
import '../custom/CustomText.dart';
import '../custom/CustomTextFormField.dart';
import '../custom/Fonts.dart';
import '../utils/Demo_Localization.dart';
import 'edit_profile.dart';
import 'package:fitness/Controllers/HomeController/change_themes_controller.dart';

class MainProfileScreen extends StatefulWidget {
  const MainProfileScreen({super.key});

  @override
  State<MainProfileScreen> createState() => _MainProfileScreenState();
}

class _MainProfileScreenState extends State<MainProfileScreen> {
  HomeController homeController = Get.put(HomeController());
  final ThemeController themeController = Get.find<ThemeController>();

  @override
  void initState() {
    super.initState();
    homeController.getProfileApi();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Get the current theme mode from the ThemeController
      bool isDarkMode = themeController.isDarkMode.value;

      return Scaffold(
        backgroundColor: isDarkMode ? Colors.black : Colors.white,  // Set background color based on theme
        body: SingleChildScrollView(
          child: Obx(() {
            return homeController.isLoading1.value
                ? const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 50),
                child: CupertinoActivityIndicator(),
              ),
            )
                : homeController.profileData.isEmpty
                ? CustomText(
              text: "No profile found",
              fontSize: 5,
              color: FitnessColor.primary,
              fontWeight: FontWeight.normal,
            )
                : Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  CstAppbarWithtextimage(
                    title: DemoLocalization.of(context)!
                        .translate('Profile')
                        .toString(),
                    icon: Icons.arrow_back_ios,
                    fontFamily: Fonts.arial,
                    onImageTap: () {
                      Get.back();
                    },
                  ),
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage(
                          'assets/images/profileedit.png'),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: DemoLocalization.of(context)!
                            .translate('FullName')
                            .toString(),
                        fontSize: 4,
                        color: isDarkMode
                            ? Colors.white
                            : FitnessColor.colorTextPrimary,
                        fontWeight: FontWeight.bold,
                        fontFamily: Fonts.arial,
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(height: 5),
                      CustomTextFormField(
                        hintText: DemoLocalization.of(context)!
                            .translate('Enterfullname')
                            .toString(),
                        readOnly: true,
                        controller: homeController.nameController,
                        secondaryIcon: Icons.check,
                        onChanged: (value) {},
                      ),
                      const SizedBox(height: 10),
                      CustomText(
                        text: DemoLocalization.of(context)!
                            .translate('Phone')
                            .toString(),
                        fontSize: 4,
                        color: isDarkMode
                            ? Colors.white
                            : FitnessColor.colorTextPrimary,
                        fontWeight: FontWeight.bold,
                        fontFamily: Fonts.arial,
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(height: 5),
                      CustomTextFormField(
                        hintText: DemoLocalization.of(context)!
                            .translate('Enterphonenumber')
                            .toString(),
                        controller: homeController.phoneController,
                        readOnly: true,
                        onChanged: (value) {},
                      ),
                      const SizedBox(height: 10),
                      CustomText(
                        text: DemoLocalization.of(context)!
                            .translate('Emailaddress')
                            .toString(),
                        fontSize: 4,
                        color: isDarkMode
                            ? Colors.white
                            : FitnessColor.colorTextPrimary,
                        fontWeight: FontWeight.bold,
                        fontFamily: Fonts.arial,
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(height: 5),
                      CustomTextFormField(
                        hintText: DemoLocalization.of(context)!
                            .translate('Enteryouremail')
                            .toString(),
                        readOnly: true,
                        controller: homeController.emailController,
                        onChanged: (value) {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: CustomButton(
                      text: DemoLocalization.of(context)!
                          .translate('UpdateProfile')
                          .toString(),
                      fontFamily: Fonts.arial,
                      fontSize: 22,
                      color: isDarkMode
                          ? Colors.white
                          : FitnessColor.colorTextThird,
                      onPressed: () {
                        Get.to(() => const EditProfileScreen());
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: CustomButton(
                      text: DemoLocalization.of(context)!
                          .translate('Logout')
                          .toString(),
                      fontFamily: Fonts.arial,
                      fontSize: 22,
                      color: isDarkMode
                          ? Colors.white
                          : FitnessColor.colorTextThird,
                      onPressed: () async {
                        bool confirmLogOut = await Utils
                            .showConfirmDialog(
                            DemoLocalization.of(context)!
                                .translate('Logout')
                                .toString(),
                            DemoLocalization.of(context)!
                                .translate('LogoutMessage')
                                .toString(),context);
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
            );
          }),
        ),
      );
    });
  }
}

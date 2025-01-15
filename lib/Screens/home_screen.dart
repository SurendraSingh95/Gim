import 'dart:io';

import 'package:fitness/Controllers/HomeController/home_controller.dart';
import 'package:fitness/Screens/trainer_details_screen.dart';
import 'package:fitness/Screens/trainer_multiple_video_screen.dart';
import 'package:fitness/Utils/utils.dart';
import 'package:fitness/auth/LoginScreen.dart';
import 'package:fitness/auth/sign_out_screen.dart';
import 'package:fitness/colors.dart';
import 'package:fitness/custom/CstAppbarWithtextimage.dart';
import 'package:fitness/custom/CustomButton.dart';
import 'package:fitness/custom/CustomText.dart';
import 'package:fitness/custom/Fonts.dart';
import 'package:fitness/utils/Demo_Localization.dart';
import 'package:fitness/utils/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

import '../custom/my_shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen(
      {super.key,
      this.userName,
      this.userEmail,
      this.questionId,
      this.trainerName,
      this.trainerImage,
      this.trainerId});

  final String? userName, trainerName, trainerImage, userEmail;
  final String? questionId;
  final int? trainerId;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<VideoPlayerController> _controllers;
  HomeController homeController = Get.put(HomeController());
  bool isMuted = false;
  int selectedIndex = -1;

  @override
  void initState() {
    super.initState();
    _controllers = [];
    homeController.getProfileApi();
    // homeController.getMemberShipPlan();
    homeController.trainerWisePlanApi();
    // homeController.getVideoList();
    //_initializeVideos();
  }

  String? planId, planPrice;

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
                onPressed: () => Navigator.of(context).pop(false),
                // Dismiss dialog
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

  // _initializeVideos() async {
  //   await homeController.getVideoList();
  //   setState(() {
  //     for (var item in homeController.videoList) {
  //       final videoUrl = "https://tfbfitness.com/${item.videoPath}";
  //       final controller = VideoPlayerController.networkUrl(Uri.parse(videoUrl))
  //         ..initialize().then((_) {
  //           setState(() {});
  //         }).catchError((error) {
  //           print("Error initializing video: $error");
  //         });
  //       _controllers.add(controller); // Add controller for each video
  //     }
  //   });
  // }
  String get userId => SharedPref.getUserId();

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDarkMode ? FitnessColor.primary : FitnessColor.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 30),
              CstAppbarWithtextimage(
                  title: DemoLocalization.of(context)!
                      .translate('Profile')
                      .toString(),
                   imageAsset: 'assets/images/edit-btn.png',
                  imageColor: isDarkMode ? Colors.white : FitnessColor.primary,
                  fontFamily: Fonts.arial,
                  onImageTap: () {
                    Get.to(() => const SignOutScreen());
                  }),
              const SizedBox(height: 10),
              widget.trainerName == null || widget.trainerImage == null
                  ? Obx(() {
                      return homeController.profileData.isEmpty
                          ? const SizedBox.shrink()
                          : Column(
                              children: [
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100),
                                    side: BorderSide(
                                      color: Colors.black.withOpacity(0.2),
                                      width: 1,
                                    ),
                                  ),
                                  child: CircleAvatar(
                                    backgroundColor: FitnessColor.white,
                                    radius: 58,
                                    backgroundImage: homeController.profileData.first.profileImage != null && homeController.profileData.first.profileImage.isNotEmpty
                                        ? NetworkImage("https://tfbfitness.com/${homeController.profileData.first.profileImage}")
                                        : null,
                                    child: homeController.profileData.first.profileImage == null || homeController.profileData.first.profileImage.isEmpty
                                        ? Image.asset('assets/images/no Image.png')
                                        : null,
                                  ),
                                ),

                                CustomText1(
                                  text: homeController.profileData.first.name ??
                                      "",
                                  fontSize: 5,
                                  fontFamily: Fonts.arial,
                                  fontWeight: FontWeight.bold,
                                ),
                              ],
                            );
                    })
                  : Column(
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                            side: BorderSide(
                              color: Colors.black.withOpacity(0.2),
                              width: 1,
                            ),
                          ),
                          child: CircleAvatar(
                            backgroundColor: FitnessColor.white,
                            radius: 59,
                            backgroundImage: widget.trainerImage != null && widget.trainerImage!.isNotEmpty
                                ? NetworkImage(widget.trainerImage ?? "")
                                : null,
                            child:widget.trainerImage == null || widget.trainerImage!.isEmpty
                                ? Image.asset('assets/images/no Image.png')
                                : null,
                          ),
                        ),
                        CustomText1(
                          text: widget.trainerName ?? "",
                          fontSize: 5,
                          fontFamily: Fonts.arial,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),

              CustomButton(
                  height: 30,
                  width: 120,
                  text: DemoLocalization.of(context)!
                      .translate('Trainer_details')
                      .toString(),
                  onPressed: () {
                    Get.to(() => const TrainerDetailsScreen());
                  },
                  fontFamily: Fonts.arial),
              Obx(() {
                return homeController.isLoading2.value
                    ? myShimmer()
                    : homeController.videoPlanList.isEmpty
                        ? Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Center(
                                child: CustomText1(
                                    text: DemoLocalization.of(context)!
                                        .translate('No_data_found')
                                        .toString(),
                                    fontSize: 5)),
                          )
                        : ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: homeController.videoPlanList.length,
                            itemBuilder: (context, index) {
                              final item = homeController.videoPlanList[index];
                              return Card(
                                     color: FitnessColor.white,
                                elevation: 4,
                                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Plan Type Title
                                      CustomText(
                                        text: item.planType ?? 'No Name',
                                        fontSize: 5.5,
                                        color: FitnessColor.colortextselectbox,
                                        fontFamily: Fonts.arial,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      const SizedBox(height: 8),

                                      // Image Section with Lock/Play Button
                                      SizedBox(
                                        height: 160,
                                        width: double.infinity,
                                        child: Stack(
                                          children: [
                                            // Background Image
                                            ClipRRect(
                                              borderRadius: BorderRadius.circular(10),
                                              child: Image.network(
                                                item.image ?? "",
                                                fit: BoxFit.cover,
                                                width: double.infinity,
                                                height: double.infinity,
                                                loadingBuilder: (context, child, loadingProgress) {
                                                  if (loadingProgress == null) {
                                                    return child;
                                                  } else {
                                                    return Center(
                                                      child: Padding(
                                                        padding: const EdgeInsets.only(top: 50),
                                                        child: myShimmer2(),
                                                      ),
                                                    );
                                                  }
                                                },
                                                errorBuilder: (context, error, stackTrace) {
                                                  return const Center(
                                                    child: Icon(
                                                      Icons.error,
                                                      size: 50,
                                                      color: Colors.red,
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                            // Center Lock/Play Button
                                            Center(
                                              child: IconButton(
                                                style: IconButton.styleFrom(
                                                  foregroundColor: FitnessColor.white,
                                                  backgroundColor: FitnessColor.primary.withOpacity(0.7),
                                                ),
                                                icon: Icon(
                                                  item.isPlanPurchased == false
                                                      ? Icons.lock
                                                      : Icons.play_arrow,
                                                ),
                                                onPressed: () {
                                                  if (item.isPlanPurchased == false) {
                                                    Utils.mySnackBar(
                                                      title: "Purchase Plan",
                                                      msg: "Before Purchase Plan",
                                                    );
                                                  } else {
                                                    Get.to(() => TrainerMultipleVideoScree(
                                                      planId: item.id,
                                                      monthName: item.planType,
                                                    ));
                                                  }
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 12),

                                      // Plan Name and "View More Details" Button
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          // Plan Name
                                          Flexible(
                                            child: CustomText(
                                              text: item.planName ?? 'No Data',
                                              fontSize: 4.0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          // View More Details Button
                                          InkWell(
                                            onTap: () {
                                              if (item.isPlanPurchased == false) {
                                                Utils.mySnackBar(
                                                  title: "Purchase Plan",
                                                  msg: "Before Purchase Plan",
                                                );
                                              } else {
                                                Get.to(() => TrainerMultipleVideoScree(
                                                  planId: item.id,
                                                  monthName: item.planType,
                                                ));
                                              }
                                            },
                                            child: CustomText(
                                              text: DemoLocalization.of(context)!
                                                  .translate('View_more_details')
                                                  .toString(),
                                              fontSize: 4.0,
                                              color: FitnessColor.primary,
                                              fontFamily: Fonts.arial,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );

                            },
                          );
              }),
              const SizedBox(height: 20),
              CustomText1(
                  text: DemoLocalization.of(context)!
                      .translate('SubscriptionPlan')
                      .toString(),
                  //"Subscription Plan",
                  fontSize: 8,
                  color: FitnessColor.colorTextFour,
                  fontWeight: FontWeight.bold,
                  fontFamily: Fonts.arial),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: CustomText(
                    text: DemoLocalization.of(context)!
                        .translate('Itistext')
                        .toString(),
                    fontSize: 4.6,
                    color: FitnessColor.colorTextPrimary,
                    fontWeight: FontWeight.normal,
                    textAlign: TextAlign.center,
                    fontFamily: Fonts.arial),
              ),
              Obx(() {
                return SizedBox(
                  height: 160,
                  child: homeController.isLoading2.value
                      ? myHorizontalShimmer()
                      : homeController.videoPlanList.isEmpty
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: CustomText1(
                                    text: DemoLocalization.of(context)!
                                        .translate('No_data_found')
                                        .toString(),
                                    fontSize: 5),
                              ),
                            )
                          : ListView.builder(
                              itemCount: homeController.videoPlanList.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                final planList =
                                    homeController.videoPlanList[index];
                                final bool isSelected = index == selectedIndex;
                                return GestureDetector(
                                  onTap: () {
                                    if (planList.isPlanPurchased == true) {
                                      Utils.mySnackBar(
                                          title: "Purchased Plan",
                                          msg: "Already Purchased");
                                    } else {
                                      setState(() {
                                        selectedIndex = index;
                                        planId = planList.id.toString();
                                        planPrice =
                                            planList.planAmount.toString();
                                      });
                                    }
                                  },
                                  child: Center(
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          3.25,
                                      height: 150,
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Card(
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 10.0),
                                          color: isSelected
                                              ? FitnessColor.primaryLite
                                                  .withOpacity(0.01)
                                              : FitnessColor.colorinsidebox,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            side: BorderSide(
                                              color: isSelected
                                                  ? FitnessColor
                                                      .colorsociallogintext
                                                  : Colors.transparent,
                                              width: 1.0,
                                            ),
                                          ),
                                          elevation: 4,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  color: isSelected
                                                      ? FitnessColor
                                                          .coloroutlineborder
                                                      : FitnessColor
                                                          .colormonthbgcolor
                                                          .withOpacity(0.30),
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10.0),
                                                    topRight:
                                                        Radius.circular(10.0),
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    planList.planType
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: isSelected
                                                          ? FitnessColor
                                                              .colorinsidebox
                                                          : FitnessColor
                                                              .colorfillText,
                                                      fontFamily: Fonts.arial,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              Column(
                                                children: [
                                                  Text(
                                                    planList.planName
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontSize: 11,
                                                      color: isSelected
                                                          ? FitnessColor.white
                                                          : (isDarkMode
                                                              ? FitnessColor
                                                                  .primary
                                                              : FitnessColor
                                                                  .primary),
                                                      fontFamily: Fonts.arial,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                                  ),
                                                  Text(
                                                    "\$${(double.parse(planList.planAmount ?? '0.0')).toStringAsFixed(0)}",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontFamily: Fonts.arial,
                                                      color: isSelected
                                                          ? FitnessColor.white
                                                          : (isDarkMode
                                                              ? FitnessColor
                                                                  .primary
                                                              : FitnessColor
                                                                  .primary),
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                  // if (isSelected)
                                                  //   Icon(
                                                  //     Icons.check_circle,
                                                  //     color: isSelected
                                                  //         ? FitnessColor.white
                                                  //         : (isDarkMode
                                                  //         ? FitnessColor.primary
                                                  //         : FitnessColor.primary),
                                                  //   ),
                                                  planList.isPlanPurchased ==
                                                          true
                                                      ? const Text(
                                                          "Purchased",
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              color:
                                                                  Colors.green,
                                                              fontFamily:
                                                                  Fonts.arial),
                                                        )
                                                      // CustomText1(text: "Purchased", fontSize: 4,color: Colors.green,)
                                                      : const SizedBox(),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                );
              }),
              Center(
                child: CustomButton(
                  text: DemoLocalization.of(context)!
                      .translate('MakePayment')
                      .toString(),
                  //'Make Payment',
                  fontFamily: Fonts.arial,
                  fontSize: 22,
                  color: FitnessColor.colorTextThird,
                  onPressed: () async {
                    if (planPrice == null) {
                      Utils.mySnackBar(
                          title: DemoLocalization.of(context)!
                              .translate('Select_Plan')
                              .toString(),
                          msg: DemoLocalization.of(context)!
                              .translate('Please_Select_Plan')
                              .toString());
                    } else {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      String? userId = prefs.getString("userId");
                      if (userId == null || userId == '') {
                        Get.to(() => const LoginScreen());
                        Get.delete<HomeController>();
                      } else {
                        //if()
                        homeController.purchasePlanApi(planId, planPrice);
                      }
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: CustomText(
                    text: DemoLocalization.of(context)!
                        .translate('webringtext')
                        .toString(),
                    //  "We bring the most deserving ones to flattery with just a hate payment of \$199 those who are softened and corrupted by present pleasures",
                    fontSize: 4,
                    color: FitnessColor.coloroutlineborder,
                    fontWeight: FontWeight.normal,
                    textAlign: TextAlign.center,
                    fontFamily: Fonts.arial //Fonts.arial,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:fitness/Controllers/HomeController/home_controller.dart';
import 'package:fitness/Utils/utils.dart';
import 'package:fitness/custom/CstAppbarWithtextimage.dart';
import 'package:fitness/custom/CustomButton.dart';
import 'package:fitness/custom/my_shimmer.dart';
import 'package:fitness/profile/PortfolioScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../colors.dart';
import '../custom/CustomText.dart';
import '../custom/Fonts.dart';
import '../utils/Demo_Localization.dart';

class HomeDetailsScreen extends StatefulWidget {
  const HomeDetailsScreen({super.key, this.detailsId});

  final String? detailsId;

  @override
  State<HomeDetailsScreen> createState() => _HomeDetailsScreenState();
}

class _HomeDetailsScreenState extends State<HomeDetailsScreen> {
  HomeController homeController = Get.put(HomeController());
  VideoPlayerController? controller;
  int selectedIndex = -1;
  String? planId, planPrice;

  @override
  void initState() {
    super.initState();
    video();
  }

  video() async {
    await homeController.homeDetailsApi(widget.detailsId);
    homeController.getMemberShipPlan();
    String videoUrl =
        "https://tfbfitness.com/${homeController.detailsData.first.videoPath ?? ""}";
    controller = VideoPlayerController.networkUrl(Uri.parse(videoUrl))
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return RefreshIndicator(
      onRefresh: () async {
        homeController.homeDetailsApi(widget.detailsId);
      },
      child: Scaffold(
        backgroundColor: isDarkMode ? FitnessColor.primary : FitnessColor.white,
        body: SingleChildScrollView(
          child: Obx(
            () {
              if (homeController.isLoadingDetails.value) {
                return myShimmer();
              }
              if (homeController.detailsData.isEmpty) {
                return CustomText1(text: "No_data_found", fontSize: 5);
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10.0, right: 16, top: 40),
                    child: CstAppbarWithtextimage(
                        title: DemoLocalization.of(context)!
                            .translate('TrainerProfile')
                            .toString(),
                        icon: Icons.arrow_back_ios,
                        fontFamily: Fonts.arial,
                        onImageTap: () {
                          Get.back();
                        }),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 200,
                    child: controller!.value.isInitialized
                        ? Stack(
                            children: [
                              // VideoPlayer(_controller),

                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      if (controller!.value.isPlaying) {
                                        setState(() {
                                          controller?.pause();
                                        });
                                      }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: SizedBox(
                                        height: 180,
                                        width: double.infinity,
                                        child: AspectRatio(
                                          aspectRatio:
                                              controller!.value.aspectRatio,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: VideoPlayer(controller!),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  if (!controller!.value.isPlaying)
                                    Positioned(
                                      bottom: 0,
                                      left: 0,
                                      right: 0,
                                      top: 0,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          IconButton(
                                            style: IconButton.styleFrom(
                                              foregroundColor:
                                                  FitnessColor.white,
                                              backgroundColor: FitnessColor
                                                  .primary
                                                  .withOpacity(0.7),
                                            ),
                                            icon: const Icon(
                                              Icons.play_arrow,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                controller?.play();
                                              });
                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                  // Volume Icon in the Top-Right Corner
                                ],
                              ),
                            ],
                          )
                        : const Center(
                            child:
                                CupertinoActivityIndicator()), // Show loading indicator
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 5, // Increase elevation for better shadow
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(15), // Rounded corners
                      ),
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          // Align items to the start
                          children: [
                            // Profile Image with better styling
                            SizedBox(
                              width: 60,
                              height: 60,
                              child: CircleAvatar(
                                radius: 50,
                                backgroundImage: homeController.detailsData
                                            .first.image?.isNotEmpty ??
                                        false
                                    ? NetworkImage(
                                        "https://tfbfitness.com${homeController.detailsData.first.image}")
                                    : const AssetImage(
                                            'assets/images/no Image.png')
                                        as ImageProvider,
                              ),
                            ),
                            const SizedBox(width: 16),
                            // User Details
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: homeController
                                          .detailsData.first.trainerName ??
                                      "No Trainer",
                                  fontSize: 5,
                                  color: FitnessColor.colorTextPrimary,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: Fonts.arial,
                                ),
                                CustomText(
                                  text: DemoLocalization.of(context)!
                                      .translate('Trainer')
                                      .toString(),
                                  fontSize: 3,
                                  color: FitnessColor.colorTextPrimary,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: Fonts.arial,
                                ),
                              ],
                            ),
                            const Spacer(),
                            // Portfolio text with better emphasis
                            Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: InkWell(
                                onTap: (){
                                  Get.to(()=>const PortfolioScreen());
                                },
                                child: CustomText(
                                  text: DemoLocalization.of(context)!
                                      .translate('Portfolio')
                                      .toString(),
                                  fontSize: 4,
                                  color: FitnessColor.colorTextPrimary,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: Fonts.arial,

                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Html(
                        data: homeController.detailsData.first.description ??
                            "No Data Found!!"),
                  ),

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
                    padding: const EdgeInsets.symmetric(horizontal: 12,),
                    child: CustomText1(
                        text: DemoLocalization.of(context)!
                            .translate('Itistext')
                            .toString(),
                        fontSize: 4,
                        color: FitnessColor.colorTextPrimary,
                        fontWeight: FontWeight.normal,
                        textAlign: TextAlign.center,
                        fontFamily: Fonts.arial),
                  ),
                  Obx(() {
                    return homeController.isLoading.value
                        ? myHorizontalShimmer()
                        : homeController.planData.isEmpty
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                    child: CustomText1(
                                        text: DemoLocalization.of(context)!
                                            .translate('No_data_found')
                                            .toString(),
                                        fontSize: 5)),
                              )
                            : Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: SizedBox(
                                  height: 160,
                                  child: ListView.builder(
                                    itemCount: homeController.planData.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      final planList =
                                          homeController.planData[index];
                                      final bool isSelected =
                                          index == selectedIndex;
                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selectedIndex = index;
                                            planId = planList.id.toString();
                                            planPrice =
                                                planList.price.toString();
                                          });
                                        },
                                        child: Center(
                                          child: SizedBox(
                                            // color: Colors.red,
                                            // width: 110,
                                            width: MediaQuery.of(context).size.width / 3.25,
                                            height: 150,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Card(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10.0),
                                                color: isSelected
                                                    ? FitnessColor.primaryLite
                                                        .withOpacity(0.01)
                                                    : FitnessColor
                                                        .colorinsidebox,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    side: BorderSide(
                                                      color: isSelected
                                                          ? FitnessColor
                                                              .coloroutlineborder
                                                          : Colors.transparent,
                                                      width: 2.0,
                                                    )),
                                                elevation: 4,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      height: 36,
                                                      // color: Colors.grey,
                                                      decoration: BoxDecoration(
                                                        color: isSelected
                                                            ? FitnessColor
                                                                .coloroutlineborder
                                                            : FitnessColor
                                                                .colormonthbgcolor
                                                                .withOpacity(
                                                                    0.30),
                                                        borderRadius:
                                                            const BorderRadius
                                                                .only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  10.0),
                                                          topRight:
                                                              Radius.circular(
                                                                  10.0),
                                                        ),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          "${planList.durationInDays.toString()} Days",
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color: isSelected
                                                                ? FitnessColor
                                                                    .colorinsidebox
                                                                : FitnessColor
                                                                    .colorfillText,
                                                            fontFamily:
                                                                Fonts.arial,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 16,
                                                    ),
                                                    Column(
                                                      children: [
                                                        Text(
                                                          planList.name
                                                              .toString(),
                                                          style: TextStyle(
                                                            fontSize: 11,
                                                            color: isSelected
                                                                ? FitnessColor
                                                                    .white
                                                                : (isDarkMode
                                                                    ? FitnessColor
                                                                        .primary // Dark mode color
                                                                    : FitnessColor
                                                                        .primary),
                                                            // Light mode color
                                                            fontFamily:
                                                                Fonts.arial,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                          ),
                                                        ),
                                                        Text(
                                                          "\$${(double.parse(planList.price ?? '0.0')).toStringAsFixed(0)}",
                                                          // Prepend $ symbol
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            fontFamily:
                                                                Fonts.arial,
                                                            color: isSelected
                                                                ? FitnessColor
                                                                    .white
                                                                : (isDarkMode
                                                                    ? FitnessColor
                                                                        .primary // Dark mode color
                                                                    : FitnessColor
                                                                        .primary),
                                                            // Light mode color
                                                            fontWeight:
                                                                FontWeight.w700,
                                                          ),
                                                        ),
                                                        if (isSelected)
                                                          Icon(
                                                            Icons.check_circle,
                                                            color: isSelected
                                                                ? FitnessColor
                                                                    .white
                                                                : (isDarkMode
                                                                    ? FitnessColor
                                                                        .primary // Dark mode color
                                                                    : FitnessColor
                                                                        .primary), // Light mode color
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
                      onPressed: () {
                        if (planPrice == null) {
                          Utils.mySnackBar(title: "Please select plan");
                        } else {
                          homeController.purchasePlanApi(planId, planPrice);
                        }
                        /*  Navigator.of(context).pushReplacement(MaterialPageRoute(
                                  builder: (context) => const ProfileDetailsScreen())
                              );*/
                      },
                    ),
                  ),
                  const SizedBox(height: 10,)
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

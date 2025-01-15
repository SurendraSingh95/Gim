import 'package:fitness/Utils/utils.dart';
import 'package:fitness/auth/LoginScreen.dart';
import 'package:fitness/custom/CustomButton.dart';
import 'package:fitness/profile/PortfolioScreen.dart';
import 'package:fitness/utils/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../Controllers/HomeController/home_controller.dart';
import '../colors.dart';
import '../custom/CstAppbarWithtextimage.dart';
import '../custom/CustomText.dart';
import '../custom/Fonts.dart';
import '../custom/my_shimmer.dart';
import '../utils/Demo_Localization.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:shared_preferences/shared_preferences.dart';
class TrainerDetailsScreen extends StatefulWidget {
  const TrainerDetailsScreen({super.key,});



  @override
  _TrainerDetailsScreenState createState() => _TrainerDetailsScreenState();
}

class _TrainerDetailsScreenState extends State<TrainerDetailsScreen> {
  late List<VideoPlayerController?> _controllers; // Made nullable to handle nulls
  final HomeController homeController = Get.put(HomeController());
  bool isMuted = false;
  int selectedIndex = -1;
  String? planId, planPrice;

  @override
  void initState() {
    super.initState();
    _controllers = [];
    homeController.trainerDetailsApi();
    _initializeVideos();

  }


  String get trainerImage => SharedPref.getTrainerImagePrefs();


  _initializeVideos() async {
    await homeController.trainerDetailsApi();
    setState(() {
      for (var item in homeController.tarinerData.value) {
        for (var videoUrl in item.videos) {
          if (videoUrl.isNotEmpty) {
            try {
              final controller = VideoPlayerController.networkUrl(Uri.parse(videoUrl))
                ..initialize().then((_) {
                  setState(() {});
                }).catchError((error) {
                  print("Error initializing video: $error");
                });
              _controllers.add(controller);
            } catch (e) {
              print("Error parsing video URL: $videoUrl -> $e");
            }
          } else {
            print("Invalid video URL: $videoUrl");
          }
        }
      }
    });
  }


  @override
  void dispose() {
    for (var controller in _controllers) {
      controller?.dispose();
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
          padding:  const EdgeInsets.all(16.0),
          child: Obx(
              () {
              return
                homeController.isLoading2.value
                    ? myShimmer()
                    : homeController.tarinerData.isEmpty
                    ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child: CustomText1(
                          text: DemoLocalization.of(context)!
                              .translate('No_data_found')
                              .toString(),
                          fontSize: 4)),
                )
                    :
                Column(
                children: [
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 0.0, top: 16),
                    child: CstAppbarWithtextimage(
                      title: DemoLocalization.of(context)!
                          .translate('TrainerProfile')
                          .toString(),
                      icon: Icons.arrow_back_ios,
                      fontFamily: Fonts.arial,
                      onImageTap: () {
                        Get.back();
                      },
                    ),
                  ),
                  // Obx(() {
                  //   return
                      ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        final item = homeController.tarinerData.first;
                        final controller = _controllers.length > index ? _controllers.first : null;

                        return  Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 8),
                            ValueListenableBuilder(
                                valueListenable : controller!,
                                builder: (_,value,child) {
                                  return Stack(
                                    alignment: Alignment.center,
                                    children: [

                                      Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          InkWell(
                                            onTap:(){
                                              if (controller.value.isPlaying) {
                                                controller.pause();
                                              }
                                            },
                                            child: SizedBox(
                                              height: 180,
                                              width: double.infinity,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    border: Border.all(width: 1,color: FitnessColor.colorsociallogintext),
                                                    borderRadius: BorderRadius.circular(10)
                                                ),
                                                child: AspectRatio(
                                                  aspectRatio: controller.value.aspectRatio,
                                                  child: ClipRRect(

                                                    borderRadius: BorderRadius.circular(8),
                                                    child: VideoPlayer(controller),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),

                                          if (value.isBuffering || !value.isInitialized)
                                            const Center(
                                              child: CupertinoActivityIndicator(),
                                            )
                                          else
                                          // item.questionId == null ||  item.questionId!.isEmpty ?
                                          // const Icon(Icons.lock,color: FitnessColor.white,) :
                                            Positioned(
                                              bottom: 0,
                                              left: 0,
                                              right: 0,
                                              top:0,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  if(!controller.value.isPlaying )
                                                    IconButton(
                                                      style: IconButton.styleFrom(
                                                        foregroundColor: FitnessColor.white,
                                                        backgroundColor: FitnessColor.primary.withOpacity(0.7),
                                                      ),
                                                      icon: const Icon(Icons.play_arrow,),
                                                      onPressed: () {
                                                        setState(() {
                                                          controller.play();
                                                        });
                                                      },
                                                    )
                                                ],
                                              ),
                                            ),
                                          // Volume Icon in the Top-Right Corner
                                          Positioned(
                                            top: -5,
                                            right: -5,
                                            child: Transform.scale(
                                              scale:0.7,
                                              child: IconButton(
                                                style: IconButton.styleFrom(
                                                  foregroundColor: FitnessColor.white,
                                                  backgroundColor: FitnessColor.primary.withOpacity(0.2),
                                                ),
                                                icon: Icon(

                                                  isMuted ? Icons.volume_off : Icons.volume_up,
                                                  color: Colors.white, // Optional: Color for better visibility
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    isMuted = !isMuted;
                                                    controller.setVolume(isMuted ? 0.0 : 1.0);
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                    ],
                                  );
                                }
                            ),



                          ],
                        );
                      },
                    ),
                 // }),
                  const SizedBox(height: 10,),
                  Card(
                    elevation: 5, // Increase elevation for better shadow
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(15), // Rounded corners
                    ),
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
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
                              backgroundImage: trainerImage.isNotEmpty
                                  ? NetworkImage(
                                  trainerImage.toString())
                                  : const AssetImage(
                                  'assets/images/no Image.png')
                              as ImageProvider,
                            ),
                          ),
                          const SizedBox(width: 5),
                          // User Details
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: homeController.tarinerData.first.title ??
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Html(
                        data: homeController.tarinerData.first.description ??
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
                    padding: const EdgeInsets.all(16.0),
                    child: CustomText(
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
                ],
              );
            }
          ),
        ),
      ),
    );
  }
}

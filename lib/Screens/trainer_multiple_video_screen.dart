import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../Controllers/HomeController/home_controller.dart';
import '../auth/sign_out_screen.dart';
import '../colors.dart';
import '../custom/CstAppbarWithtextimage.dart';
import '../custom/CustomText.dart';
import '../custom/Fonts.dart';
import '../custom/my_shimmer.dart';
import '../utils/Demo_Localization.dart';

class TrainerMultipleVideoScree extends StatefulWidget {
  const TrainerMultipleVideoScree({super.key, this.planId,this.monthName});
  final int? planId;
  final String? monthName;

  @override
  _TrainerMultipleVideoScreeState createState() => _TrainerMultipleVideoScreeState();
}

class _TrainerMultipleVideoScreeState extends State<TrainerMultipleVideoScree> {
  late List<VideoPlayerController?> _controllers; // Made nullable to handle nulls
  final HomeController homeController = Get.put(HomeController());
  bool isMuted = false;

  @override
  void initState() {
    super.initState();
    _controllers = [];
   // homeController.getVideoList(widget.planId.toString());
    _initializeVideos();
  }

  _initializeVideos() async {
    await homeController.getVideoList(widget.planId.toString());
    setState(() {
      for (var item in homeController.trainerVideoList.value) {
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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 0.0, top: 16),
                child: CstAppbarWithtextimage(
                  title: widget.monthName ?? "",
                  icon: Icons.arrow_back_ios,
                  fontFamily: Fonts.arial,
                  onImageTap: () {
                    Get.back();
                  },
                ),
              ),
              Obx(() {
                return homeController.isLoadingVideo.value
                    ? myShimmer()
                    : homeController.videoPlanList.isEmpty || homeController.videoPlanList == []
                    ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: CustomText1(
                      text: DemoLocalization.of(context)!
                          .translate('No_data_found')
                          .toString(),
                      fontSize: 4,
                    ),
                  ),
                )
                    : ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: homeController.videoPlanList.length,
                  itemBuilder: (context, index) {
                    final item = homeController.videoPlanList[index];
                    final controller = _controllers.length > index
                        ? _controllers[index]
                        : null;

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
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

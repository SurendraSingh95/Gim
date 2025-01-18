import 'package:fitness/Model/Trainer%20Model/get_trainer_all_video_model.dart';
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

class TrainerMultipleVideoScree extends StatefulWidget {
  const TrainerMultipleVideoScree({super.key, this.planId, this.monthName});

  final int? planId;
  final String? monthName;

  @override
  _TrainerMultipleVideoScreeState createState() =>
      _TrainerMultipleVideoScreeState();
}

class _TrainerMultipleVideoScreeState extends State<TrainerMultipleVideoScree> {
  late List<VideoPlayerController?>
      _controllers; // Made nullable to handle nulls
  final HomeController homeController = Get.put(HomeController());
  bool isMuted = false;

  @override
  void initState() {
    super.initState();
    _controllers = [];
    homeController.getVideoList(widget.planId.toString());
    _initializeVideos();
  }

// _initializeVideos  _initializeVideos() async {
//     await homeController.getVideoList(widget.planId.toString());
//     setState(() {
//       for (var item in homeController.trainerVideoList.value) {
//         for (var videoUrl in item.videos.first.videoPath) {
//           if (videoUrl.isNotEmpty) {
//             try {
//               final controller = VideoPlayerController.networkUrl(Uri.parse(videoUrl))
//                 ..initialize().then((_) {
//                   setState(() {});
//                 }).catchError((error) {
//                   print("Error initializing video: $error");
//                 });
//               _controllers.add(controller);
//             } catch (e) {
//               print("Error parsing video URL: $videoUrl -> $e");
//             }
//           } else {
//             print("Invalid video URL: $videoUrl");
//           }
//         }
//       }
//     });
//   }
  _initializeVideos() async {
    print("------Surendra-----------------");
    await homeController.getVideoList(widget.planId.toString());
    setState(() {
      for (var item in homeController.trainerVideoList.value) {
        for (var video in item.videos) {
          final videoUrl = video.videoPath;
          if (videoUrl != null && videoUrl.isNotEmpty) {
            try {
              final controller =
                  VideoPlayerController.networkUrl(Uri.parse(videoUrl))
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

  int timeToBreak = 0;
  VideoAnswer? videoAnswerToShow;

  void getVideoAnswerNotRead(List<VideoAnswer> videoAnswers) {
    final videoAnswer = videoAnswers.firstWhereOrNull((videoAnswer) =>
        videoAnswer.read == 0 && (videoAnswer.time ?? 0) > timeToBreak);
    timeToBreak = videoAnswer?.time ?? 0;
    debugPrint("time to break .... $timeToBreak");
    videoAnswerToShow = videoAnswer;
  }


/*  Future<bool> showBreakDialog() async {
    if (videoAnswerToShow == null) return false;
    if (!mounted || Navigator.of(context).mounted == false) return false;

    final response = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          title: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Break Time!', style: TextStyle(fontSize: 18)),
              Text('When you\'re done, press OK',
                  style: TextStyle(fontSize: 18)),
            ],
          ),
          content: Text(videoAnswerToShow?.answers ?? ''),
          actions: [
            TextButton(
              onPressed: () async {
                final updated = await homeController
                    .updateVideoAnswerStatus(videoAnswerToShow?.id.toString());

                if (!updated) return;
                //getVideoAnswerNotRead();
                homeController.getVideoList(widget.planId.toString());
                Navigator.pop(context, true);
              },
              child: Text("OK", style: TextStyle(fontSize: 18)),
            ),
          ],
        );
      },
    );
    return response ??
        false; // Return false if dialog is dismissed without action
  }*/

  Future<bool> showBreakDialog() async {
    if (videoAnswerToShow == null) return false;
    if (!mounted || Navigator.of(context).mounted == false) return false;

    final response = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          title: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Break Time!', style: TextStyle(fontSize: 18)),
              Text('When you\'re done, press OK', style: TextStyle(fontSize: 18)),
            ],
          ),
          content: Text(videoAnswerToShow?.answers ?? ''),
          actions: [
            TextButton(
              onPressed: () async {
                final updated = await homeController.updateVideoAnswerStatus(videoAnswerToShow?.id.toString());
                timeToBreak--;
                if (updated) {
                  await homeController.getVideoList(widget.planId.toString());
                }
                Get.back();
               // Navigator.of(context).pop(true);
              },
              child: Text("OK", style: TextStyle(fontSize: 18)),
            ),
          ],
        );
      },
    );

    return response ?? false;
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
                    : homeController.trainerVideoList.first.videos.isEmpty ||
                            homeController.trainerVideoList.first.videos == []
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
                            itemCount: homeController
                                .trainerVideoList.first.videos.length,
                            itemBuilder: (context, index) {
                              final item = homeController
                                  .trainerVideoList.first.videos[index];
                              final controller = _controllers.length > index
                                  ? _controllers[index]
                                  : null;
                              int playableIndex = homeController
                                  .trainerVideoList.first.videos
                                  .indexWhere((video) => video.status == 0);
                              if (item.status == 1) {
                                playableIndex = index;
                              }
                              // final playedIndex = homeController.trainerVideoList.first.videos.indexWhere((video)=> video.status==1);
                              debugPrint("indexxx $playableIndex");
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 8),
                                  ValueListenableBuilder(
                                      valueListenable : controller!,
                                      builder: (_,value,child)  {
                                        final minutes = value.position.inSeconds;
                                        final duration = value.duration.inSeconds;

                                        /// add new duration
                                        final currentMinutes =
                                            value.position.inMinutes;
                                        final currentSeconds =
                                            value.position.inSeconds % 60;
                                        final totalMinutes =
                                            value.duration.inMinutes;
                                        final totalSeconds =
                                            value.duration.inSeconds % 60;
                                        debugPrint("duration $duration, second $minutes");

                                          // controller.seekTo(
                                          //     Duration(seconds: 15));

                                        if(value.isInitialized && value.isPlaying && duration == minutes ){
                                          homeController.updateVideoStatus(item.id.toString(), widget.planId.toString());
                                        }
                                        if(timeToBreak == minutes && timeToBreak != 0){
                                          controller.pause();
                                          Future.delayed(Duration(milliseconds: 100), () {
                                            showBreakDialog();
                                          });
                                          //showBreakDialog();
                                        }

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
                                                  playableIndex == index?
                                                    !controller.value.isPlaying?
                                                     IconButton(
                                                      style: IconButton.styleFrom(
                                                        foregroundColor: FitnessColor.white,
                                                        backgroundColor: FitnessColor.primary.withOpacity(0.7),
                                                      ),
                                                      icon: const Icon(Icons.play_arrow,),
                                                      onPressed: () async {
                                                        getVideoAnswerNotRead(item.videoAnswers);
                                                        await Future.delayed(Duration(milliseconds: 150));
                                                        setState(() {
                                                          controller.play();
                                                        });
                                                      },
                                                    ): const SizedBox.shrink():

                                                     IconButton(
                                                    style: IconButton.styleFrom(
                                                      foregroundColor: FitnessColor.white,
                                                      backgroundColor: FitnessColor.primary.withOpacity(0.7),
                                                    ),
                                                    icon: const Icon(Icons.lock,),
                                                    onPressed: (){},
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
                                                        color: Colors.white,
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
                                            /// add duration
                                            Positioned(
                                              bottom: 10,
                                              child: Container(
                                                padding: const EdgeInsets
                                                    .symmetric(
                                                    horizontal: 10,
                                                    vertical: 5),
                                                decoration: BoxDecoration(
                                                  color: Colors.black
                                                      .withOpacity(0.5),
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      8),
                                                ),
                                                child: Text(
                                                  "$currentMinutes:${currentSeconds.toString().padLeft(2, '0')} / $totalMinutes:${totalSeconds.toString().padLeft(2, '0')}",
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14),
                                                ),
                                              ),
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

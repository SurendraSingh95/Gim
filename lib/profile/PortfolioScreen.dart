import 'dart:io';

import 'package:fitness/Controllers/HomeController/home_controller.dart';
import 'package:fitness/custom/my_shimmer.dart';
import 'package:fitness/utils/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../colors.dart';
import '../custom/CstAppbarWithtextimage.dart';
import '../custom/CustomButton.dart';
import '../custom/CustomText.dart';
import '../custom/Fonts.dart';
import '../utils/Demo_Localization.dart';
import 'package:video_player/video_player.dart';
import 'package:get/get.dart';

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key});

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  late List<VideoPlayerController?> _controllers;
  final HomeController homeController = Get.put(HomeController());
  bool isMuted = false;

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
      for (var item in homeController.tarinerData) {
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
            child: homeController.isLoading2.value
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
                const SizedBox(height: 25),
                CstAppbarWithtextimage(
                    title: DemoLocalization.of(context)!.translate('Portfolio').toString(),//'Portfolio',
                    icon: Icons.arrow_back_ios,
                    // imageAsset: 'assets/images/editbtn.png',
                    // Uncomment this line to show the image
                    fontFamily: Fonts.arial,
                    onImageTap: (){
                      Get.back();
                    }
                ),
                const SizedBox(height: 20),
                Card(
                  color: FitnessColor.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),  // Rounded corners for the card
                    side: BorderSide(
                        color: FitnessColor.colorsociallogintext.withOpacity(0.1),
                        width: 2
                    ),
                  ),
                  elevation: 5,  // Adding elevation for a subtle shadow effect
                  child: SizedBox(
                    width: 130,  // Slightly increase width for balance
                    height: 130,  // Slightly increase height for balance
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),  // Ensure image is also round
                      child: CircleAvatar(
                        radius: 50,  // Avatar's size
                        backgroundColor: Colors.transparent,  // Transparent background for the avatar
                        backgroundImage: trainerImage.isNotEmpty
                            ? NetworkImage(trainerImage.toString())
                            : const AssetImage('assets/images/no Image.png') as ImageProvider,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10,),
                CustomText1(text: homeController.tarinerData.first.title ?? "", fontSize: 5,fontWeight: FontWeight.bold,fontFamily: Fonts.arial),
                const SizedBox(height: 10,),

                SizedBox(
                  height: 170,
                  child:  ListView.builder(
                    physics: const ScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount:3,
                    itemBuilder: (context, index) {
                      final item = homeController.tarinerData.first.images[index];

                      return  Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                item,
                                fit: BoxFit.fill,
                                height: 150,
                                width: 100,
                                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  } else {
                                    return const Center(child: CupertinoActivityIndicator());
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10,),

                SizedBox(
                  height: 200,
                  child: Obx(
                          () {
                        return
                          ListView.builder(
                            physics: const ScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount:homeController.tarinerData.first.videos.length,
                            itemBuilder: (context, index) {
                              final controller = _controllers.length > index ? _controllers[index] : null;
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 5),
                                    child: ValueListenableBuilder(
                                        valueListenable: controller!,
                                        builder: (_, value, child) {
                                          return Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      if (controller.value.isPlaying) {
                                                        controller.pause();
                                                      }
                                                    },
                                                    child: SizedBox(
                                                      height: 180,
                                                      width: 320, // Set a fixed width for horizontal scrolling items
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          border: Border.all(width: 1, color: FitnessColor.colorsociallogintext),
                                                          borderRadius: BorderRadius.circular(10),
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
                                                    Positioned(
                                                      bottom: 0,
                                                      left: 0,
                                                      right: 0,
                                                      top: 0,
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          if (!controller.value.isPlaying)
                                                            IconButton(
                                                              style: IconButton.styleFrom(
                                                                foregroundColor: FitnessColor.white,
                                                                backgroundColor: FitnessColor.primary.withOpacity(0.7),
                                                              ),
                                                              icon: const Icon(Icons.play_arrow),
                                                              onPressed: () {
                                                                setState(() {
                                                                  controller.play();
                                                                });
                                                              },
                                                            )
                                                        ],
                                                      ),
                                                    ),
                                                  Positioned(
                                                    top: -5,
                                                    right: -5,
                                                    child: Transform.scale(
                                                      scale: 0.7,
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
                                            ],
                                          );
                                        }
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                      }
                  ),
                ),
                const SizedBox(height: 10,),
                SizedBox(
                  height: 170,
                  child: Obx(
                          () {
                        return ListView.builder(
                          physics: const ScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: homeController.tarinerData.first.images.length - 3,
                          itemBuilder: (context, index) {
                            final item = homeController.tarinerData.first.images[index + 3];
                            return Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      item,
                                      fit: BoxFit.fill,
                                      height: 150,
                                      width: 100,
                                      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        } else {
                                          return const Center(child: CupertinoActivityIndicator());
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }
                  ),
                ),



                Center(
                  child: CustomButton(
                    text: DemoLocalization.of(context)!.translate('ShareProfile').toString(),
                    fontFamily: Fonts.arial,
                    fontSize: 22,
                    color: FitnessColor.colorTextThird,
                    onPressed: () {
                      shareImageFromUrl();
                    },
                  ),
                ),
              ],
            ),
        ),
      ),
    );
  }
  void shareImageFromUrl() {
    String text = homeController.tarinerData.first.title ?? "";
    String text1 = homeController.tarinerData.first.title ?? "";
    String imageUrl = trainerImage.toString(); // Assuming this is a valid URL

    // Share.share(
    //   'Trainer Information: $text\n$text1\n$imageUrl',
    //   subject: 'Trainer Information',
    // );
  }

}

// class _PortfolioScreenState extends State<PortfolioScreen> {
//   late List<VideoPlayerController?> _controllers;
//   final HomeController homeController = Get.put(HomeController());
//
//   @override
//   void initState() {
//     super.initState();
//     _controllers = [];
//      homeController.trainerDetailsApi();
//
//     _initializeVideos();
//   }
//
//   String get trainerImage => SharedPref.getTrainerImagePrefs();
//
//   _initializeVideos() async {
//     await homeController.trainerDetailsApi();
//     for (var trainer in homeController.tarinerData) {
//       for (var videoUrl in trainer.videos) {
//         if (videoUrl.isNotEmpty) {
//           final controller = VideoPlayerController.network(videoUrl)
//             ..initialize().then((_) {
//               setState(() {});
//             }).catchError((error) {
//               print("Error initializing video: $error");
//             });
//           _controllers.add(controller);
//         } else {
//           _controllers.add(null);
//         }
//       }
//     }
//   }
//
//   @override
//   void dispose() {
//     for (var controller in _controllers) {
//       controller?.dispose();
//     }
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Obx(() {
//         if (homeController.isLoading2.value) {
//           return const Center(child: CircularProgressIndicator());
//         } else if (homeController.tarinerData.isEmpty) {
//           return const Center(child: Text("No Data Found"));
//         } else {
//           return SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const SizedBox(height: 20),
//                   ...homeController.tarinerData.map((trainer) {
//                     return Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // Profile Section
//                         _buildTrainerHeader(trainer),
//
//                         const SizedBox(height: 20),
//
//                         // Portfolio Section (Images and Videos)
//                         ..._buildPortfolioItems(trainer.images, trainer.videos),
//                       ],
//                     );
//                   }).toList(),
//                 ],
//               ),
//             ),
//           );
//         }
//       }),
//     );
//   }
//
//   Widget _buildTrainerHeader(TarinerData trainer) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         CircleAvatar(
//           radius: 40,
//           backgroundImage: trainer.profileImage != null
//               ? NetworkImage(trainer.profileImage!)
//               : const AssetImage('assets/images/no_image.png') as ImageProvider,
//         ),
//         const SizedBox(width: 16),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 trainer.title ?? "Trainer",
//                 style: const TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 5),
//               Text(
//                 trainer.description ?? "No description available",
//                 style: const TextStyle(fontSize: 14, color: Colors.grey),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   List<Widget> _buildPortfolioItems(List<String> images, List<String> videos) {
//     List<Widget> items = [];
//     int videoIndex = 0;
//
//     // Iterate through all images and videos
//     for (int i = 0; i < images.length; i++) {
//       // Add Image
//       items.add(
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 10.0),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(8),
//             child: Image.network(
//               images[i],
//               height: 200,
//               width: double.infinity,
//               fit: BoxFit.cover,
//               errorBuilder: (context, error, stackTrace) {
//                 return const Text("Failed to load image");
//               },
//             ),
//           ),
//         ),
//       );
//
//       // Add corresponding Video (if available)
//       if (videoIndex < videos.length) {
//         final controller = _controllers.length > videoIndex
//             ? _controllers[videoIndex]
//             : null;
//         if (controller != null) {
//           items.add(
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 10.0),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(8),
//                 child: AspectRatio(
//                   aspectRatio: controller.value.aspectRatio,
//                   child: Stack(
//                     alignment: Alignment.center,
//                     children: [
//                       VideoPlayer(controller),
//                       if (!controller.value.isPlaying)
//                         IconButton(
//                           icon: const Icon(Icons.play_arrow, size: 40),
//                           onPressed: () {
//                             setState(() {
//                               controller.play();
//                             });
//                           },
//                         ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           );
//         }
//         videoIndex++;
//       }
//     }
//
//     return items;
//   }
// }
// import 'package:fitness/Controllers/HomeController/home_controller.dart';
// import 'package:fitness/Utils/Demo_Localization.dart';
// import 'package:fitness/colors.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:fitness/custom/CustomButton.dart';
// import 'package:fitness/custom/CustomText.dart';
// import 'package:fitness/custom/Fonts.dart';
// import 'package:fitness/custom/my_shimmer.dart';
// import 'package:fitness/utils/shared_preferences.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:uni_links/uni_links.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:video_player/video_player.dart';
// import 'package:share/share.dart';
// class PortfolioScreen extends StatefulWidget {
//   const PortfolioScreen({super.key});
//
//   @override
//   State<PortfolioScreen> createState() => _PortfolioScreenState();
// }
//
// class _PortfolioScreenState extends State<PortfolioScreen> {
//   late List<VideoPlayerController?> _controllers;
//   final HomeController homeController = Get.put(HomeController());
//   bool isMuted = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _controllers = [];
//     homeController.trainerDetailsApi();
//     _initializeVideos();
//     _listenForDeepLinks();
//     _initDeepLink();
//   }
//   void _initDeepLink() async {
//     try {
//       final initialLink = await getInitialLink();
//       if (initialLink != null) {
//         _handleDeepLink(initialLink);
//       }
//
//       linkStream.listen((String? link) {
//         if (link != null) {
//           _handleDeepLink(link);
//         }
//       });
//     } catch (e) {
//       print("Error in deep link: $e");
//     }
//   }
//
//   void _handleDeepLink(String link) {
//     Uri uri = Uri.parse(link);
//     String trainerId = uri.pathSegments.last;
//     Navigator.pushNamed(context, '/trainer/$trainerId');
//   }
//   _listenForDeepLinks() async {
//     try {
//       final initialLink = await getInitialLink();
//       if (initialLink != null) {
//         _navigateToTrainerProfile(initialLink);
//       }
//       linkStream.listen((String? link) {
//         if (link != null) {
//           _navigateToTrainerProfile(link);
//         }
//       });
//     } catch (e) {
//       print('Error handling deep link: $e');
//     }
//   }
//
//   void _navigateToTrainerProfile(String link) async {
//     try {
//       Uri uri = Uri.parse(link);
//       String trainerId = uri.pathSegments.isNotEmpty ? uri.pathSegments.last : "";
//
//       if (trainerId.isNotEmpty) {
//         Get.toNamed('/trainer/$trainerId');
//       } else {
//         throw 'Invalid trainer ID in link: $link';
//       }
//     } catch (e) {
//       print("Error navigating to trainer profile: $e");
//       const playStoreUrl = 'https://play.google.com/store/apps/details?id=com.example.tfbfitness';
//       if (await canLaunchUrl(Uri.parse(playStoreUrl))) {
//         await launchUrl(Uri.parse(playStoreUrl), mode: LaunchMode.externalApplication);
//       } else {
//         print('Could not launch Play Store');
//       }
//     }
//   }
//
//   String get trainerImage => SharedPref.getTrainerImagePrefs();
//
//   _initializeVideos() async {
//     await homeController.trainerDetailsApi();
//     setState(() {
//       for (var item in homeController.tarinerData) {
//         for (var videoUrl in item.videos) {
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
//
//   @override
//   void dispose() {
//     for (var controller in _controllers) {
//       controller?.dispose();
//     }
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
//
//     return Scaffold(
//       backgroundColor: isDarkMode ? FitnessColor.primary : FitnessColor.white,
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: homeController.isLoading2.value
//               ? myShimmer()
//               : homeController.tarinerData.isEmpty
//               ? Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Center(
//               child: CustomText1(
//                 text: DemoLocalization.of(context)!
//                     .translate('No_data_found')
//                     .toString(),
//                 fontSize: 4,
//               ),
//             ),
//           )
//               : Column(
//              children: [
//               const SizedBox(height: 25),
//               const SizedBox(height: 20),
//               Card(
//                 color: FitnessColor.white,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(100),
//                   side: BorderSide(
//                     color: FitnessColor.colorsociallogintext
//                         .withOpacity(0.1),
//                     width: 2,
//                   ),
//                 ),
//                 elevation: 5,
//                 child: SizedBox(
//                   width: 130,
//                   height: 130,
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(100),
//                     child: CircleAvatar(
//                       radius: 50,
//                       backgroundColor: Colors.transparent,
//                       backgroundImage: trainerImage.isNotEmpty
//                           ? NetworkImage(trainerImage.toString())
//                           : const AssetImage(
//                           'assets/images/no Image.png')
//                       as ImageProvider,
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 10),
//               CustomText1(
//                 text: homeController.tarinerData.first.title ?? "",
//                 fontSize: 5,
//                 fontWeight: FontWeight.bold,
//                 fontFamily: Fonts.arial,
//               ),
//                const SizedBox(height: 10),
//                SizedBox(
//                 height: 170,
//                 child: ListView.builder(
//                   physics: const ScrollPhysics(),
//                   scrollDirection: Axis.horizontal,
//                   itemCount: homeController.tarinerData.first.images.length,
//                   itemBuilder: (context, index) {
//                     final item = homeController.tarinerData.first.images[index];
//                     return Padding(
//                       padding: const EdgeInsets.all(5.0),
//                       child: Stack(
//                         children: [
//                           ClipRRect(
//                             borderRadius: BorderRadius.circular(10),
//                             child: Image.network(
//                               item,
//                               fit: BoxFit.fill,
//                               height: 150,
//                               width: 100,
//                               loadingBuilder: (BuildContext context,
//                                   Widget child,
//                                   ImageChunkEvent? loadingProgress) {
//                                 if (loadingProgress == null) {
//                                   return child;
//                                 } else {
//                                   return const Center(
//                                       child:
//                                       CupertinoActivityIndicator());
//                                 }
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//               ),
//                SizedBox(
//                   height: 200,
//                   child: Obx(
//                           () {
//                         return
//                           ListView.builder(
//                             physics: const ScrollPhysics(),
//                             scrollDirection: Axis.horizontal,
//                             itemCount:homeController.tarinerData.first.videos.length,
//                             itemBuilder: (context, index) {
//                               final controller = _controllers.length > index ? _controllers[index] : null;
//                               return Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   const SizedBox(height: 10),
//                                   Padding(
//                                     padding: const EdgeInsets.symmetric(horizontal: 5),
//                                     child: ValueListenableBuilder(
//                                         valueListenable: controller!,
//                                         builder: (_, value, child) {
//                                           return Stack(
//                                             alignment: Alignment.center,
//                                             children: [
//                                               Stack(
//                                                 alignment: Alignment.center,
//                                                 children: [
//                                                   InkWell(
//                                                     onTap: () {
//                                                       if (controller.value.isPlaying) {
//                                                         controller.pause();
//                                                       }
//                                                     },
//                                                     child: SizedBox(
//                                                       height: 180,
//                                                       width: 320, // Set a fixed width for horizontal scrolling items
//                                                       child: Container(
//                                                         decoration: BoxDecoration(
//                                                           border: Border.all(width: 1, color: FitnessColor.colorsociallogintext),
//                                                           borderRadius: BorderRadius.circular(10),
//                                                         ),
//                                                         child: AspectRatio(
//                                                           aspectRatio: controller.value.aspectRatio,
//                                                           child: ClipRRect(
//                                                             borderRadius: BorderRadius.circular(8),
//                                                             child: VideoPlayer(controller),
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                   if (value.isBuffering || !value.isInitialized)
//                                                     const Center(
//                                                       child: CupertinoActivityIndicator(),
//                                                     )
//                                                   else
//                                                     Positioned(
//                                                       bottom: 0,
//                                                       left: 0,
//                                                       right: 0,
//                                                       top: 0,
//                                                       child: Row(
//                                                         mainAxisAlignment: MainAxisAlignment.center,
//                                                         children: [
//                                                           if (!controller.value.isPlaying)
//                                                             IconButton(
//                                                               style: IconButton.styleFrom(
//                                                                 foregroundColor: FitnessColor.white,
//                                                                 backgroundColor: FitnessColor.primary.withOpacity(0.7),
//                                                               ),
//                                                               icon: const Icon(Icons.play_arrow),
//                                                               onPressed: () {
//                                                                 setState(() {
//                                                                   controller.play();
//                                                                 });
//                                                               },
//                                                             )
//                                                         ],
//                                                       ),
//                                                     ),
//                                                   Positioned(
//                                                     top: -5,
//                                                     right: -5,
//                                                     child: Transform.scale(
//                                                       scale: 0.7,
//                                                       child: IconButton(
//                                                         style: IconButton.styleFrom(
//                                                           foregroundColor: FitnessColor.white,
//                                                           backgroundColor: FitnessColor.primary.withOpacity(0.2),
//                                                         ),
//                                                         icon: Icon(
//                                                           isMuted ? Icons.volume_off : Icons.volume_up,
//                                                           color: Colors.white,
//                                                         ),
//                                                         onPressed: () {
//                                                           setState(() {
//                                                             isMuted = !isMuted;
//                                                             controller.setVolume(isMuted ? 0.0 : 1.0);
//                                                           });
//                                                         },
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ],
//                                           );
//                                         }
//                                     ),
//                                   ),
//                                 ],
//                               );
//                             },
//                           );
//                       }
//                   ),
//                 ),
//                const SizedBox(height: 10),
//                 SizedBox(
//                   height: 170,
//                   child: Obx(
//                           () {
//                         return ListView.builder(
//                           physics: const ScrollPhysics(),
//                           scrollDirection: Axis.horizontal,
//                           itemCount: homeController.tarinerData.first.images.length - 3,
//                           itemBuilder: (context, index) {
//                             final item = homeController.tarinerData.first.images[index + 3];
//                             return Padding(
//                               padding: const EdgeInsets.all(5.0),
//                               child: Stack(
//                                 children: [
//                                   ClipRRect(
//                                     borderRadius: BorderRadius.circular(10),
//                                     child: Image.network(
//                                       item,
//                                       fit: BoxFit.fill,
//                                       height: 150,
//                                       width: 100,
//                                       loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
//                                         if (loadingProgress == null) {
//                                           return child;
//                                         } else {
//                                           return const Center(child: CupertinoActivityIndicator());
//                                         }
//                                       },
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             );
//                           },
//                         );
//                       }
//                   ),
//                 ),
//                 Center(
//                 child: CustomButton(
//                   text: "ShareProfile",
//                  // text: "DemoLocalization.of(context)!.translate('ShareProfile').toString(),",
//                   fontFamily: Fonts.arial,
//                   fontSize: 22,
//                   color: FitnessColor.colorTextThird,
//                   onPressed: () {
//                     shareImageFromUrl();
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   void shareImageFromUrl() {
//     String trainerName = homeController.tarinerData.first.title ?? "Trainer Name";
//     String trainerId = homeController.tarinerData.first.id.toString();
//     String trainerImageUrl = trainerImage.toString();
//
//     // Ensure the trainerId is properly encoded
//     String deepLink = Uri.encodeFull("https://tfbfitness.com/api/trainer_details/$trainerId");
//
//     Share.share(
//       '${DemoLocalization.of(context)?.translate('Trainer Information')}:\n'
//           '${DemoLocalization.of(context)?.translate('Name')}: $trainerName\n'
//           '${DemoLocalization.of(context)?.translate('Image')}: $trainerImageUrl\n\n'
//           '${DemoLocalization.of(context)?.translate('MoreDetails')}: $deepLink',
//       subject: DemoLocalization.of(context)?.translate('Trainer Profile'),
//     );
//   }
//
// }



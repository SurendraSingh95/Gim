// import 'dart:io';
//
// import 'package:fitness/Controllers/HomeController/home_controller.dart';
// import 'package:fitness/Utils/utils.dart';
// import 'package:fitness/auth/LoginScreen.dart';
// import 'package:fitness/auth/sign_out_screen.dart';
// import 'package:fitness/colors.dart';
// import 'package:fitness/custom/CstAppbarWithtextimage.dart';
// import 'package:fitness/custom/CustomButton.dart';
// import 'package:fitness/custom/CustomText.dart';
// import 'package:fitness/custom/Fonts.dart';
// import 'package:fitness/Screens/profile_details_screen.dart';
// import 'package:fitness/utils/Demo_Localization.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:video_player/video_player.dart';
//
// import '../custom/my_shimmer.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key, this.userName, this.userEmail,this.questionId,this.trainerName,this.trainerImage,this.trainerId});
//
//   final String? userName,trainerName,trainerImage, userEmail;
//   final String? questionId;
//   final int? trainerId;
//
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   late List<VideoPlayerController> _controllers;
//   HomeController homeController = Get.put(HomeController());
//   bool isMuted = false;
//   int selectedIndex = -1;
//
//   @override
//   void initState() {
//     super.initState();
//     _controllers = [];
//     homeController.getProfileApi();
//     homeController.getMemberShipPlan();
//     homeController.getVideoList();
//     _initializeVideos();
//   }
//
//   String? planId, planPrice;
//
//   Future<bool> _onWillPop() async {
//     return (await showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20),
//         ),
//         title: const Row(
//           children: [
//             Icon(
//               Icons.exit_to_app,
//               color: Colors.redAccent,
//             ),
//             SizedBox(width: 10),
//             Text(
//               'Exit App',
//               style: TextStyle(
//                 color: Colors.redAccent,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 18,
//               ),
//             ),
//           ],
//         ),
//         content: const Text(
//           'Are you sure you want to exit the app?',
//           style: TextStyle(
//             color: Colors.black87,
//             fontSize: 16,
//           ),
//         ),
//         actions: <Widget>[
//           TextButton(
//             style: TextButton.styleFrom(
//               backgroundColor: Colors.grey[200],
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//             ),
//             onPressed: () => Navigator.of(context).pop(false),
//             // Dismiss dialog
//             child: Text(
//               'Cancel',
//               style: TextStyle(
//                 color: Colors.grey[800],
//               ),
//             ),
//           ),
//           TextButton(
//             style: TextButton.styleFrom(
//               backgroundColor: Colors.redAccent,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//             ),
//             onPressed: () => exit(0),
//             child: const Text(
//               'Exit',
//               style: TextStyle(
//                 color: Colors.white,
//               ),
//             ),
//           ),
//         ],
//       ),
//     )) ??
//         false;
//   }
//
//   _initializeVideos() async {
//     await homeController.getVideoList();
//     setState(() {
//       for (var item in homeController.videoList) {
//         final videoUrl = "https://tfbfitness.com/${item.videoPath}";
//         final controller = VideoPlayerController.networkUrl(Uri.parse(videoUrl))
//           ..initialize().then((_) {
//             setState(() {});
//           }).catchError((error) {
//             print("Error initializing video: $error");
//           });
//         _controllers.add(controller); // Add controller for each video
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     for (var controller in _controllers) {
//       controller.dispose();
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
//           child: Column(
//             children: [
//               const SizedBox(height: 30),
//               CstAppbarWithtextimage(
//                   title: DemoLocalization.of(context)!
//                       .translate('Profile')
//                       .toString(),
//                   //'Profile',
//                   imageAsset: 'assets/images/edit-btn.png',
//                   imageColor:
//                   isDarkMode ? Colors.transparent : FitnessColor.primary,
//                   fontFamily: Fonts.arial,
//                   onImageTap: () {
//                     Get.to(() => const SignOutScreen());
//                   }),
//               const SizedBox(height: 10),
//               Obx(() {
//                 return
//                   homeController.profileData.isEmpty || homeController.profileData.first.name == null?
//                   homeController.isLoading1.value
//                       ? const Center(child: CupertinoActivityIndicator())
//                       : homeController.profileData.isEmpty || homeController.profileData.first.name == null
//                       ? Center(
//                       child: CustomText1(
//                           text: DemoLocalization.of(context)!
//                               .translate('No_data_found')
//                               .toString(),
//                           fontSize: 4))
//                       : Column(
//                     children: [
//                       Obx(() {
//                         return Padding(
//                           padding: const EdgeInsets.all(16.0),
//                           child: homeController.profileData.isEmpty
//                               ? const CupertinoActivityIndicator()
//                               : (homeController.profileData.first.profileImage == null ||
//                               homeController.profileData.first.profileImage == ""
//                               ?  Card(
//                             color: FitnessColor.white,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(100),
//                               side: BorderSide(
//                                 color: Colors.black.withOpacity(0.2),
//                                 width: 1,
//                               ),
//
//                             ),
//                             child: const CircleAvatar(
//                               backgroundColor: FitnessColor.white,
//                               radius: 55,
//                               backgroundImage: AssetImage(
//                                   "assets/images/no Image.png"),
//                             ),
//                           )
//                               : Card(
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(100),
//                               side: BorderSide(
//                                 color: Colors.black.withOpacity(0.2),
//                                 width: 1,
//                               ),
//
//                             ),
//                             child: CircleAvatar(
//                               backgroundColor: FitnessColor.white,
//                               radius: 58,
//                               backgroundImage: NetworkImage(
//                                   "https://tfbfitness.com/${homeController.profileData.first.profileImage}"),
//                             ),
//                           )),
//                         );
//                       }),
//                       Obx(() {
//                         return CustomText1(
//                           // text: DemoLocalization.of(context)!.translate('Rahul').toString(),//"Rahul",
//                           text: homeController
//                               .profileData.first.name ==
//                               null
//                               ? homeController.profileData.first.email
//                               .toString()
//                               : homeController
//                               .profileData.first.name ??
//                               "",
//                           fontSize: 5.5,
//                           color: FitnessColor.colorTextPrimary,
//                           fontWeight: FontWeight.bold,
//                           fontFamily: Fonts.arial,
//                         );
//                       }),
//                     ],
//                   ):
//                   Column(
//                     children: [
//                       Obx(() {
//                         return Padding(
//                           padding: const EdgeInsets.all(16.0),
//                           child: homeController.profileData.isEmpty
//                               ? const CupertinoActivityIndicator()
//                               : (homeController.profileData.first.profileImage == null ||
//                               homeController.profileData.first.profileImage == ""
//                               ?  Card(
//                             color: FitnessColor.white,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(100),
//                               side: BorderSide(
//                                 color: Colors.black.withOpacity(0.2),
//                                 width: 1,
//                               ),
//
//                             ),
//                             child: const CircleAvatar(
//                               backgroundColor: FitnessColor.white,
//                               radius: 55,
//                               backgroundImage: AssetImage(
//                                   "assets/images/no Image.png"),
//                             ),
//                           )
//                               : Card(
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(100),
//                               side: BorderSide(
//                                 color: Colors.black.withOpacity(0.2),
//                                 width: 1,
//                               ),
//
//                             ),
//                             child: CircleAvatar(
//                               backgroundColor: FitnessColor.white,
//                               radius: 58,
//                               backgroundImage: NetworkImage(widget.trainerImage.toString()),
//                             ),
//                           )),
//                         );
//                       }),
//                       Obx(() {
//                         return CustomText1(
//                           // text: DemoLocalization.of(context)!.translate('Rahul').toString(),//"Rahul",
//                           text: homeController
//                               .profileData.first.name ==
//                               null
//                               ? homeController.profileData.first.email
//                               .toString()
//                               : homeController
//                               .profileData.first.name ??
//                               "",
//                           fontSize: 5.5,
//                           color: FitnessColor.colorTextPrimary,
//                           fontWeight: FontWeight.bold,
//                           fontFamily: Fonts.arial,
//                         );
//                       }),
//                     ],
//                   );
//               }),
//               Obx(() {
//                 return homeController.isLoading2.value
//                     ? myShimmer()
//                     : homeController.videoList.isEmpty
//                     ? Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Center(
//                       child: CustomText1(
//                           text: DemoLocalization.of(context)!
//                               .translate('No_data_found')
//                               .toString(),
//                           fontSize: 4)),
//                 )
//                     : ListView.builder(
//                   physics: const NeverScrollableScrollPhysics(),
//                   shrinkWrap: true,
//                   itemCount: homeController.videoList.length,
//                   itemBuilder: (context, index) {
//                     final item = homeController.videoList[index];
//                     final controller = _controllers.length > index
//                         ? _controllers[index]
//                         : null;
//
//                     return Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const SizedBox(height: 8),
//                         ValueListenableBuilder(
//                             valueListenable : controller!,
//                             builder: (_,value,child) {
//                               return Stack(
//                                 alignment: Alignment.center,
//                                 children: [
//
//                                   Stack(
//                                     alignment: Alignment.center,
//                                     children: [
//                                       InkWell(
//                                         onTap:(){
//                                           if (controller.value.isPlaying) {
//                                             controller.pause();
//                                           }
//                                         },
//                                         child: SizedBox(
//                                           height: 180,
//                                           width: double.infinity,
//                                           child: Container(
//                                             decoration: BoxDecoration(
//                                                 border: Border.all(width: 1,color: FitnessColor.colorsociallogintext),
//                                                 borderRadius: BorderRadius.circular(10)
//                                             ),
//                                             child: AspectRatio(
//                                               aspectRatio: controller.value.aspectRatio,
//                                               child: ClipRRect(
//
//                                                 borderRadius: BorderRadius.circular(8),
//                                                 child: VideoPlayer(controller),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//
//                                       if (value.isBuffering || !value.isInitialized)
//                                         const Center(
//                                           child: CupertinoActivityIndicator(),
//                                         )
//                                       else
//                                         item.questionId == null ||  item.questionId!.isEmpty ?
//                                         const Icon(Icons.lock,color: FitnessColor.white,) :
//                                         Positioned(
//                                           bottom: 0,
//                                           left: 0,
//                                           right: 0,
//                                           top:0,
//                                           child: Row(
//                                             mainAxisAlignment: MainAxisAlignment.center,
//                                             children: [
//                                               if(!controller.value.isPlaying )
//                                                 IconButton(
//                                                   style: IconButton.styleFrom(
//                                                     foregroundColor: FitnessColor.white,
//                                                     backgroundColor: FitnessColor.primary.withOpacity(0.7),
//                                                   ),
//                                                   icon: const Icon(Icons.play_arrow,),
//                                                   onPressed: () {
//                                                     setState(() {
//                                                       controller.play();
//                                                     });
//                                                   },
//                                                 )
//                                             ],
//                                           ),
//                                         ),
//                                       // Volume Icon in the Top-Right Corner
//                                       Positioned(
//                                         top: -5,
//                                         right: -5,
//                                         child: Transform.scale(
//                                           scale:0.7,
//                                           child: IconButton(
//                                             style: IconButton.styleFrom(
//                                               foregroundColor: FitnessColor.white,
//                                               backgroundColor: FitnessColor.primary.withOpacity(0.2),
//                                             ),
//                                             icon: Icon(
//
//                                               isMuted ? Icons.volume_off : Icons.volume_up,
//                                               color: Colors.white, // Optional: Color for better visibility
//                                             ),
//                                             onPressed: () {
//                                               setState(() {
//                                                 isMuted = !isMuted;
//                                                 controller.setVolume(isMuted ? 0.0 : 1.0);
//                                               });
//                                             },
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//
//                                 ],
//                               );
//                             }
//                         ),
//                         /*    ValueListenableBuilder(
//                                     valueListenable: controller!,
//                                     builder: (_, value, child) {
//                                       return Stack(
//                                         alignment: Alignment.center,
//                                         children: [
//                                           Stack(
//                                             alignment: Alignment.center,
//                                             children: [
//                                               InkWell(
//                                                 onTap: () {
//                                                   // Only allow play/pause if video is initialized
//                                                   if (controller.value.isInitialized && controller.value.isPlaying) {
//                                                     controller.pause();
//                                                   }
//                                                 },
//                                                 child: SizedBox(
//                                                   height: 180,
//                                                   width: double.infinity,
//                                                   child: Container(
//                                                     decoration: BoxDecoration(
//                                                       border: Border.all(width: 1, color: FitnessColor.colorsociallogintext),
//                                                       borderRadius: BorderRadius.circular(10),
//                                                     ),
//                                                     child: AspectRatio(
//                                                       aspectRatio: controller.value.aspectRatio,
//                                                       child: ClipRRect(
//                                                         borderRadius: BorderRadius.circular(8),
//                                                         child: controller.value.isInitialized
//                                                             ? VideoPlayer(controller) // Show video if initialized
//                                                             : const Center( // Lock icon if video is not initialized
//                                                           child: Icon(
//                                                             Icons.lock,
//                                                             size: 40,
//                                                             color: Colors.white,
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                               // Show buffering indicator if the video is buffering or not initialized
//                                               if (value.isBuffering || !controller.value.isInitialized)
//                                                 const Center(
//                                                   child: CupertinoActivityIndicator(),
//                                                 )
//                                               else
//                                                 Positioned(
//                                                   bottom: 0,
//                                                   left: 0,
//                                                   right: 0,
//                                                   top: 0,
//                                                   child: Row(
//                                                     mainAxisAlignment: MainAxisAlignment.center,
//                                                     children: [
//                                                       // Only show the play button if the video is initialized
//                                                       if (controller.value.isInitialized && !controller.value.isPlaying)
//                                                         IconButton(
//                                                           style: IconButton.styleFrom(
//                                                             foregroundColor: FitnessColor.white,
//                                                             backgroundColor: FitnessColor.primary.withOpacity(0.7),
//                                                           ),
//                                                           icon: const Icon(Icons.play_arrow),
//                                                           onPressed: () {
//                                                             setState(() {
//                                                               controller.play(); // Play the video
//                                                             });
//                                                           },
//                                                         ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               // Volume Icon in the Top-Right Corner
//                                               Positioned(
//                                                 top: -5,
//                                                 right: -5,
//                                                 child: Transform.scale(
//                                                   scale: 0.7,
//                                                   child: IconButton(
//                                                     style: IconButton.styleFrom(
//                                                       foregroundColor: FitnessColor.white,
//                                                       backgroundColor: FitnessColor.primary.withOpacity(0.2),
//                                                     ),
//                                                     icon: Icon(
//                                                       isMuted ? Icons.volume_off : Icons.volume_up,
//                                                       color: Colors.white, // Optional: Color for better visibility
//                                                     ),
//                                                     onPressed: () {
//                                                       setState(() {
//                                                         isMuted = !isMuted;
//                                                         controller.setVolume(isMuted ? 0.0 : 1.0);
//                                                       });
//                                                     },
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ],
//                                       );
//                                     },
//                                   ),*/
//
//                         const SizedBox(height: 5),
//                         Row(
//                           mainAxisAlignment:
//                           MainAxisAlignment.spaceBetween,
//                           children: [
//                             CustomText(
//                               text: item.trainer ?? 'No Name',
//                               fontSize: 3.5,
//                               color:
//                               FitnessColor.colortextselectbox,
//                               fontFamily: Fonts.arial,
//                             ),
//                             InkWell(
//                               onTap: (){
//                                 Get.to(()=> HomeDetailsScreen(detailsId: item.id.toString()));
//                               },
//                               child: CustomText(
//                                 text: DemoLocalization.of(context)!
//                                     .translate('View_more_details')
//                                     .toString(),
//                                 fontSize: 4.0,
//                                 color: FitnessColor.primary,
//                                 fontFamily: Fonts.arial,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         ),
//                         CustomText(
//                             text: item.title ?? 'No Data',
//                             fontSize: 3.5),
//                       ],
//                     );
//                   },
//                 );
//               }),
//               const SizedBox(height: 20),
//               CustomText1(
//                   text: DemoLocalization.of(context)!
//                       .translate('SubscriptionPlan')
//                       .toString(),
//                   //"Subscription Plan",
//                   fontSize: 8,
//                   color: FitnessColor.colorTextFour,
//                   fontWeight: FontWeight.bold,
//                   fontFamily: Fonts.arial),
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: CustomText(
//                     text: DemoLocalization.of(context)!
//                         .translate('Itistext')
//                         .toString(),
//                     fontSize: 4,
//                     color: FitnessColor.colorTextPrimary,
//                     fontWeight: FontWeight.normal,
//                     textAlign: TextAlign.center,
//                     fontFamily: Fonts.arial),
//               ),
//               Obx(() {
//                 return homeController.isLoading.value
//                     ? myHorizontalShimmer()
//                     : homeController.planData.isEmpty
//                     ?  Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Center(
//                     child: CustomText1(text: DemoLocalization.of(context)!
//                         .translate('No_data_found')
//                         .toString(), fontSize: 5),
//                   ),
//                 )
//                     : SizedBox(
//                   height: 160,
//                   child: ListView.builder(
//                     itemCount: homeController.planData.length,
//                     scrollDirection: Axis.horizontal,
//                     itemBuilder: (context, index) {
//                       final planList =
//                       homeController.planData[index];
//                       final bool isSelected =
//                           index == selectedIndex;
//                       return GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             selectedIndex = index;
//                             planId = planList.id.toString();
//                             planPrice = planList.price.toString();
//                           });
//                         },
//                         child: Center(
//                           child: SizedBox(
//                             // color: Colors.red,
//                             // width: 110,
//                             width:
//                             MediaQuery.of(context).size.width /
//                                 3.25,
//                             height: 150,
//                             child: Padding(
//                               padding: const EdgeInsets.all(4.0),
//                               child: Card(
//                                 margin: const EdgeInsets.symmetric(
//                                     vertical: 10.0),
//                                 color: isSelected
//                                     ? FitnessColor.primaryLite
//                                     .withOpacity(0.01)
//                                     : FitnessColor.colorinsidebox,
//                                 shape: RoundedRectangleBorder(
//                                     borderRadius:
//                                     BorderRadius.circular(10.0),
//                                     side: BorderSide(
//                                       color: isSelected
//                                           ? FitnessColor.colorsociallogintext
//                                           : Colors.transparent,
//                                       width: 1.0,
//                                     )),
//                                 elevation: 4,
//                                 child: Column(
//                                   crossAxisAlignment:
//                                   CrossAxisAlignment.center,
//                                   children: [
//                                     Container(
//                                       width: MediaQuery.of(context)
//                                           .size
//                                           .width,
//                                       height: 36,
//                                       // color: Colors.grey,
//                                       decoration: BoxDecoration(
//                                         color: isSelected
//                                             ? FitnessColor
//                                             .coloroutlineborder
//                                             : FitnessColor
//                                             .colormonthbgcolor
//                                             .withOpacity(0.30),
//                                         borderRadius:
//                                         const BorderRadius.only(
//                                           topLeft:
//                                           Radius.circular(10.0),
//                                           topRight:
//                                           Radius.circular(10.0),
//                                         ),
//                                       ),
//                                       child: Center(
//                                         child: Text(
//                                           "${planList.durationInDays.toString()} Days",
//                                           style: TextStyle(
//                                             fontSize: 12,
//                                             color: isSelected
//                                                 ? FitnessColor
//                                                 .colorinsidebox
//                                                 : FitnessColor
//                                                 .colorfillText,
//                                             fontFamily: Fonts.arial,
//                                             fontWeight:
//                                             FontWeight.bold,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     const SizedBox(
//                                       height: 16,
//                                     ),
//                                     Column(
//                                       children: [
//                                         Text(
//                                           planList.name.toString(),
//                                           style: TextStyle(
//                                             fontSize: 11,
//                                             color: isSelected
//                                                 ? FitnessColor.white
//                                                 : (isDarkMode
//                                                 ? FitnessColor
//                                                 .primary // Dark mode color
//                                                 : FitnessColor
//                                                 .primary),
//                                             // Light mode color
//                                             fontFamily: Fonts.arial,
//                                             fontWeight:
//                                             FontWeight.normal,
//                                           ),
//                                         ),
//                                         Text(
//                                           "\$${(double.parse(planList.price ?? '0.0')).toStringAsFixed(0)}",
//                                           // Prepend $ symbol
//                                           style: TextStyle(
//                                             fontSize: 16,
//                                             fontFamily: Fonts.arial,
//                                             color: isSelected
//                                                 ? FitnessColor.white
//                                                 : (isDarkMode
//                                                 ? FitnessColor
//                                                 .primary // Dark mode color
//                                                 : FitnessColor
//                                                 .primary),
//                                             // Light mode color
//                                             fontWeight:
//                                             FontWeight.w700,
//                                           ),
//                                         ),
//                                         if (isSelected)
//                                           Icon(
//                                             Icons.check_circle,
//                                             color: isSelected
//                                                 ? FitnessColor.white
//                                                 : (isDarkMode
//                                                 ? FitnessColor
//                                                 .primary // Dark mode color
//                                                 : FitnessColor
//                                                 .primary), // Light mode color
//                                           ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       );
//                       // );
//                     },
//                   ),
//                 );
//               }),
//               Center(
//                 child: CustomButton(
//                   text: DemoLocalization.of(context)!
//                       .translate('MakePayment')
//                       .toString(),
//                   //'Make Payment',
//                   fontFamily: Fonts.arial,
//                   fontSize: 22,
//                   color: FitnessColor.colorTextThird,
//                   onPressed: () async {
//                     if(planPrice == null){
//                       Utils.mySnackBar(title:DemoLocalization.of(context)!.translate('Select_Plan').toString(),msg:DemoLocalization.of(context)!.translate('Please_Select_Plan').toString());
//                     }else{
//                       SharedPreferences prefs = await SharedPreferences.getInstance();
//                       String? userId = prefs.getString("userId");
//                       if(userId == null || userId == ''){
//                         Get.to(()=> const LoginScreen());
//                       }else {
//                         homeController.purchasePlanApi(planId, planPrice);
//
//                       }
//
//
//                     }
//
//                   },
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: CustomText(
//                     text: DemoLocalization.of(context)!
//                         .translate('webringtext')
//                         .toString(),
//                     //  "We bring the most deserving ones to flattery with just a hate payment of \$199 those who are softened and corrupted by present pleasures",
//                     fontSize: 3,
//                     color: FitnessColor.coloroutlineborder,
//                     fontWeight: FontWeight.normal,
//                     textAlign: TextAlign.center,
//                     fontFamily: Fonts.arial //Fonts.arial,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
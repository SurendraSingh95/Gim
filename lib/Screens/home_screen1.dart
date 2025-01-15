// import 'dart:io';
//
// import 'package:fitness/Controllers/HomeController/home_controller.dart';
// import 'package:fitness/auth/sign_out_screen.dart';
// import 'package:fitness/custom/my_shimmer.dart';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import '../colors.dart';
// import '../custom/CstAppbarWithtextimage.dart';
// import '../custom/CustomButton.dart';
// import '../custom/CustomText.dart';
// import '../custom/Fonts.dart';
// import '../utils/Demo_Localization.dart';
// import 'package:get/get.dart';
//
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key, this.userName, this.userEmail});
//
//   final String? userName, userEmail;
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   final List<Map<String, dynamic>> items = [
//     {
//       'title': '1 month videos',
//       'image': 'assets/images/profileimg1.png',
//       'subtitle': 'Full Shot man Stretching Arm',
//       'details': 'View more details',
//       'level': 'Beginner',
//       'time': '30 min'
//     },
//     {
//       'title': '3 month videos',
//       'image': 'assets/images/profileimg2.png',
//       'subtitle': 'Half Shot man Running',
//       'details': 'View more details',
//       'level': 'Intermediate',
//       'time': '30 min'
//     },
//     {
//       'title': '6 month videos',
//       'image': 'assets/images/profileimg3.png',
//       'subtitle': 'Full Shot man Stretching Arm',
//       'details': 'View more details',
//       'level': 'Advanced',
//       'time': '30 min'
//     },
//   ];
//
//   int selectedIndex = -1;
//
//   HomeController homeController = Get.put(HomeController());
//
//   @override
//   void initState() {
//     super.initState();
//     homeController.getProfileApi();
//     homeController.getMemberShipPlan();
//
//   }
//
//   String? planId, planPrice;
//   Future<bool> _onWillPop() async {
//     return (await showDialog(
//           context: context,
//           builder: (context) => AlertDialog(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(20),
//             ),
//             title: const Row(
//               children: [
//                 Icon(
//                   Icons.exit_to_app,
//                   color: Colors.redAccent,
//                 ),
//                 SizedBox(width: 10),
//                 Text(
//                   'Exit App',
//                   style: TextStyle(
//                     color: Colors.redAccent,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 18,
//                   ),
//                 ),
//               ],
//             ),
//             content: const Text(
//               'Are you sure you want to exit the app?',
//               style: TextStyle(
//                 color: Colors.black87,
//                 fontSize: 16,
//               ),
//             ),
//             actions: <Widget>[
//               TextButton(
//                 style: TextButton.styleFrom(
//                   backgroundColor: Colors.grey[200],
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 onPressed: () => Navigator.of(context).pop(false),
//                 // Dismiss dialog
//                 child: Text(
//                   'Cancel',
//                   style: TextStyle(
//                     color: Colors.grey[800],
//                   ),
//                 ),
//               ),
//               TextButton(
//                 style: TextButton.styleFrom(
//                   backgroundColor: Colors.redAccent,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 onPressed: () => exit(0),
//                 child: const Text(
//                   'Exit',
//                   style: TextStyle(
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         )) ??
//         false;
//   }
//
//   bool isPlaying = false;
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//
//     bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
//
//     return RefreshIndicator(
//       onRefresh: () async {
//         await homeController.refresh().then((val) {
//           setState(() {
//             homeController.getProfileApi();
//             homeController.getMemberShipPlan();
//           });
//         });
//       },
//       child: PopScope(
//         canPop: false,
//         onPopInvoked: (val) async {
//           _onWillPop();
//         },
//         child: Scaffold(
//           backgroundColor: isDarkMode ? FitnessColor.primary:FitnessColor.white,
//
//           body: SingleChildScrollView(
//             child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   children: [
//                     const SizedBox(height: 30),
//                     CstAppbarWithtextimage(
//                         title: DemoLocalization.of(context)!
//                             .translate('Profile')
//                             .toString(),
//                         //'Profile',
//                         imageAsset: 'assets/images/edit-btn.png',
//                         imageColor:isDarkMode ? Colors.transparent: FitnessColor.primary,
//                         fontFamily: Fonts.arial,
//                         onImageTap: () {
//                           Get.to(() => const SignOutScreen());
//                         }),
//                     const SizedBox(height: 20),
//
//                     Obx(() {
//                       return homeController.isLoading.value
//                           ? const Center(
//                           child: CupertinoActivityIndicator())
//                           : homeController.profileData.isEmpty
//                           ? CustomText(
//                           text: "No Profile found!!",
//                           fontSize: 4,
//                           color: FitnessColor.primary,
//                           fontWeight: FontWeight.normal)
//                           : Column(
//                         children: [
//                           Obx(() {
//                         return Padding(
//                           padding: const EdgeInsets.all(16.0),
//                           child: homeController.isLoading.value
//                               ? const CupertinoActivityIndicator()
//                               : (homeController.profileData.first.profileImage == null
//                               ? const CircleAvatar(
//                             radius: 50,
//                             child: Icon(Icons.person, size: 50), // Default icon if no profile image
//                           )
//                               : CircleAvatar(
//                             radius: 50,
//                             backgroundImage: NetworkImage("https://tfbfitness.com/${homeController.profileData.first.profileImage}"),
//                           )),
//                         );
//                       }),
//                           Obx(() {
//                             return CustomText(
//                               // text: DemoLocalization.of(context)!.translate('Rahul').toString(),//"Rahul",
//                                 text: homeController.profileData.first.name == null ?  homeController.profileData.first.email.toString():homeController.profileData.first.name ?? "",
//                                 fontSize: 5,
//                                 color: FitnessColor
//                                     .colorTextPrimary,
//                                 fontWeight: FontWeight.bold,
//                                 fontFamily:
//                                 Fonts.arial //Fonts.arial,
//                             );
//                           }),
//
//                         ],
//                       );
//                     }),
//                     ListView.builder(
//                       itemCount: 3,
//                       physics: const NeverScrollableScrollPhysics(),
//                       shrinkWrap: true,
//                       itemBuilder: (context, index) {
//                         final item = items[index];
//                         return Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             CustomText(
//                                 text: item['title'],
//                                 fontSize: 5,
//                                 color: FitnessColor.colorTextPrimary,
//                                 fontWeight: FontWeight.bold,
//                                 fontFamily: Fonts.arial //Fonts.arial,
//                             ),
//                             Image.asset(
//                               item['image'],
//                               width: MediaQuery.of(context).size.width,
//                               fit: BoxFit.cover,
//                             ),
//                             Row(
//                               mainAxisAlignment:
//                               MainAxisAlignment.spaceBetween,
//                               children: [
//                                 CustomText(
//                                     text: item['subtitle'],
//                                     fontSize: 3.5,
//                                     color: FitnessColor.colorTextPrimary,
//                                     fontWeight: FontWeight.normal,
//                                     fontFamily:
//                                     Fonts.arial
//                                 ),
//                                 CustomText(
//                                     text: item['details'],
//                                     fontSize: 3,
//                                     color: FitnessColor.colorTextPrimary,
//                                     fontWeight: FontWeight.bold,
//                                     fontFamily: Fonts.arial //Fonts.arial,
//                                 ),
//                               ],
//                             ),
//                             Row(
//                               // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 CustomText(
//                                     text: item['level'],
//                                     fontSize: 3,
//                                     color: FitnessColor.colorTextPrimary,
//                                     fontWeight: FontWeight.bold,
//                                     fontFamily:
//                                     Fonts.arial //Fonts.arial,
//                                 ),
//                                 CustomText(
//                                     text: "   |   ",
//                                     fontSize: 3,
//                                     color: FitnessColor.colorTextPrimary,
//                                     fontWeight: FontWeight.bold,
//                                     fontFamily:
//                                     Fonts.arial //Fonts.arial,
//                                 ),
//                                 Container(
//                                   child: const Icon(
//                                     Icons.watch_later_outlined,
//                                     size: 14,
//                                   ),
//                                 ),
//                                 const SizedBox(
//                                   width: 3,
//                                 ),
//                                 CustomText(
//                                     text: item['time'],
//                                     fontSize: 3,
//                                     color: FitnessColor.colorTextPrimary,
//                                     fontWeight: FontWeight.normal,
//                                     fontFamily:
//                                     Fonts.arial //Fonts.arial,
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(
//                               width: 3,
//                             ),
//                             const Divider(),
//                             const SizedBox(
//                               width: 3,
//                             ),
//                           ],
//                         );
//                         // );
//                       },
//                     ),
//                     CustomText(
//                         text: DemoLocalization.of(context)!
//                             .translate('SubscriptionPlan')
//                             .toString(),
//                         //"Subscription Plan",
//                         fontSize: 8,
//                         color: FitnessColor.colorTextFour,
//                         fontWeight: FontWeight.bold,
//                         fontFamily: Fonts.arial //Fonts.arial,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: CustomText(
//                           text: DemoLocalization.of(context)!
//                               .translate('Itistext')
//                               .toString(),
//                           // "It is a long established fact that a reader will be distracted by the readable",
//                           fontSize: 4,
//                           color: FitnessColor.colorTextPrimary,
//                           fontWeight: FontWeight.normal,
//                           textAlign: TextAlign.center,
//                           fontFamily: Fonts.arial //Fonts.arial,
//                       ),
//                     ),
//                     Obx(() {
//                       return homeController.isLoading.value
//                           ? myHorizontalShimmer()
//                           : homeController.planData.isEmpty
//                           ? const Padding(
//                         padding: EdgeInsets.all(8.0),
//                         child: Center(
//                           child: Text(
//                             'No Plan found',
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.normal,
//                               color: FitnessColor.primary,
//                             ),
//                           ),
//                         ),
//                       )
//                           : SizedBox(
//                         height: 160,
//                         child: ListView.builder(
//                           itemCount: homeController.planData.length,
//                           //  physics: NeverScrollableScrollPhysics(),
//                           // shrinkWrap: true,
//                           scrollDirection: Axis.horizontal,
//                           itemBuilder: (context, index) {
//                             final planList =
//                             homeController.planData[index];
//                             final bool isSelected =
//                                 index == selectedIndex;
//                             return GestureDetector(
//                               onTap: () {
//                                 setState(() {
//                                   selectedIndex = index;
//                                   planId = planList.id.toString();
//                                   planPrice =
//                                       planList.price.toString();
//                                   print("dsfsfsdfds${planId}");
//                                   print("dsfsfsdfds${planPrice}");
//                                 });
//                               },
//                               child: Center(
//                                 child: SizedBox(
//                                   // color: Colors.red,
//                                   // width: 110,
//                                   width: MediaQuery.of(context)
//                                       .size
//                                       .width /
//                                       3.25,
//                                   height: 150,
//                                   child: Padding(
//                                     padding:
//                                     const EdgeInsets.all(4.0),
//                                     child: Card(
//                                       margin:
//                                       const EdgeInsets.symmetric(
//                                           vertical: 10.0),
//                                       color: isSelected
//                                           ? FitnessColor.primaryLite
//                                           .withOpacity(0.01)
//                                           : FitnessColor
//                                           .colorinsidebox,
//                                       shape: RoundedRectangleBorder(
//                                           borderRadius:
//                                           BorderRadius.circular(
//                                               10.0),
//                                           side: BorderSide(
//                                             color: isSelected
//                                                 ? FitnessColor
//                                                 .coloroutlineborder
//                                                 : Colors.transparent,
//                                             width: 2.0,
//                                           )),
//                                       elevation: 4,
//                                       child: Column(
//                                         crossAxisAlignment:
//                                         CrossAxisAlignment.center,
//                                         children: [
//                                           Container(
//                                             width:
//                                             MediaQuery.of(context)
//                                                 .size
//                                                 .width,
//                                             height: 36,
//                                             // color: Colors.grey,
//                                             decoration: BoxDecoration(
//                                               color: isSelected
//                                                   ? FitnessColor
//                                                   .coloroutlineborder
//                                                   : FitnessColor
//                                                   .colormonthbgcolor
//                                                   .withOpacity(
//                                                   0.30),
//                                               borderRadius:
//                                               const BorderRadius
//                                                   .only(
//                                                 topLeft:
//                                                 Radius.circular(
//                                                     10.0),
//                                                 topRight:
//                                                 Radius.circular(
//                                                     10.0),
//                                               ),
//                                             ),
//                                             child: Center(
//                                               child: Text(
//                                                 "${planList.durationInDays.toString()} Days",
//                                                 style: TextStyle(
//                                                   fontSize: 12,
//                                                   color: isSelected
//                                                       ? FitnessColor
//                                                       .colorinsidebox
//                                                       : FitnessColor
//                                                       .colorfillText,
//                                                   fontFamily:
//                                                   Fonts.arial,
//                                                   fontWeight:
//                                                   FontWeight.bold,
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                           const SizedBox(
//                                             height: 16,
//                                           ),
//                                           Column(
//                                             children: [
//                                               Text(
//                                                 planList.name.toString(),
//                                                 style: TextStyle(
//                                                   fontSize: 11,
//                                                   color: isSelected
//                                                       ? FitnessColor.white
//                                                       : (isDarkMode
//                                                       ? FitnessColor.primary // Dark mode color
//                                                       : FitnessColor.primary), // Light mode color
//                                                   fontFamily: Fonts.arial,
//                                                   fontWeight: FontWeight.normal,
//                                                 ),
//                                               ),
//
//                                               Text(
//                                                 "\$${(double.parse(planList.price ?? '0.0')).toStringAsFixed(0)}",
//                                                 // Prepend $ symbol
//                                                 style:
//                                                  TextStyle(
//                                                   fontSize: 16,
//                                                   fontFamily: Fonts
//                                                       .arial,
//                                                   color: isSelected
//                                                       ? FitnessColor.white
//                                                       : (isDarkMode
//                                                       ? FitnessColor.primary // Dark mode color
//                                                       : FitnessColor.primary), // Light mode color
//                                                   fontWeight:
//                                                   FontWeight.w700,
//                                                 ),
//                                               ),
//                                               if (isSelected)
//                                                  Icon(
//                                                   Icons.check_circle,
//                                                   color: isSelected
//                                                       ? FitnessColor.white
//                                                       : (isDarkMode
//                                                       ? FitnessColor.primary // Dark mode color
//                                                       : FitnessColor.primary), // Light mode color
//                                                 ),
//                                             ],
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             );
//                             // );
//                           },
//                         ),
//                       );
//                     }),
//                     Center(
//                       child: CustomButton(
//                         text: DemoLocalization.of(context)!
//                             .translate('MakePayment')
//                             .toString(),
//                         //'Make Payment',
//                         fontFamily: Fonts.arial,
//                         fontSize: 22,
//                         color: FitnessColor.colorTextThird,
//                         onPressed: () {
//                           homeController.purchasePlanApi(planId, planPrice);
//                           /*  Navigator.of(context).pushReplacement(MaterialPageRoute(
//                                   builder: (context) => const ProfileDetailsScreen())
//                               );*/
//                         },
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: CustomText(
//                           text: DemoLocalization.of(context)!
//                               .translate('webringtext')
//                               .toString(),
//                           //  "We bring the most deserving ones to flattery with just a hate payment of \$199 those who are softened and corrupted by present pleasures",
//                           fontSize: 3,
//                           color: FitnessColor.coloroutlineborder,
//                           fontWeight: FontWeight.normal,
//                           textAlign: TextAlign.center,
//                           fontFamily: Fonts.arial //Fonts.arial,
//                       ),
//                     ),
//                   ],
//                 ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

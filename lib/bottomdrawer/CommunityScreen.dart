import 'package:fitness/auth/sign_out_screen.dart';
import 'package:fitness/colors.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../custom/CstAppbarWithtextimage.dart';
import '../custom/CustomText.dart';
import '../custom/Fonts.dart';
import '../utils/Demo_Localization.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  final List<Map<String, dynamic>> items = [
    {
      'image': 'assets/images/f1row1.png',
      'title': 'General',
    },
    {
      'image': 'assets/images/checkoutimg.png',
      'title': 'Share your run',
      'price': '\$6.99',
    },
    {
      'image': 'assets/images/f1row1.png',
      'title': 'Manage Spaces',
      'price': '\$6.99',
    },
    {
      'image': 'assets/images/checkoutimg.png',
      'title': 'Explore All',
      'price': '\$6.99',
    },
  ];
  final List<Map<String, dynamic>> itemslist = [
    {
      'userimage': 'assets/images/f1row1.png',
      'name': 'Rahul',
      'status': 'Share your run',
      'time': '23m',
      'title': 'Olympic Marathon 2024',
      'description':
      'First up on Saturday in the mens marathon, legendary rivals Eliud Kipchoge and Kenenisa Bekele are back in Paris for the 2024 Olympics'
          'First up on Saturday in the mens marathon, legendary rivals Eliud Kipchoge and Kenenisa Bekele are back in Paris for the 2024 Olympics',
      'image': 'assets/images/f1row1.png',
      'like': '2 Likes',
      'comments': '0 Comments',
    },
    {
      'userimage': 'assets/images/f1row1.png',
      'name': 'User Name',
      'status': 'General',
      'time': '23m',
      'title': 'General',
      'description': 'General',
      'image': 'assets/images/f1row1.png',
      'like': '1 Likes',
      'comments': '0 Comments',
    },
    {
      'userimage': 'assets/images/f1row1.png',
      'name': 'General',
      'status': 'General',
      'time': '23m',
      'title': 'General',
      'description': 'General',
      'image': 'assets/images/f1row1.png',
      'like': '0 Likes',
      'comments': '0 Comments',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey,
      body:Stack(
        children: [
          SingleChildScrollView(
            child: Column(

              children: [
                const SizedBox(height: 20),
                // Navigator.push(context, _createRoute());
                 Padding(
                 padding:  const EdgeInsets.only(left: 16.0, right: 16, top: 16),
               child:  CstAppbarWithtextimage(
                  title: DemoLocalization.of(context)!.translate('Community').toString(),//'Community',
                  icon: Icons.arrow_back_ios,
                  fontFamily: Fonts.arial,
                  imageAsset: "assets/images/logo.png",
                  onImageTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: const SignOutScreen(),
                          inheritTheme: true,
                          ctx: context),
                    );

                    // Navigator.push(context,createRoute(),);
                  },
                )),
               /* Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16, top: 16),
                  child: CstAppbarWithtextimage(
                    title: 'Community',
                    icon: Icons.arrow_back_ios,
                    fontFamily: Fonts.arial,
                      onImageTap: (){

                      }
                  ),
                ),*/
                const SizedBox(height: 20),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 110,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16, top: 0, bottom: 0),
                    child: ListView.builder(
                      itemCount: items.length,
                      //  physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final item = items[index];
                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Container(
                            //   color: Colors.green,
                            width: 60,
                            // height: 60,
                            child: Column(
                              children: [
                                Container(
                                  // color: Colors.red,
                                  width: MediaQuery.of(context).size.width,
                                  height: 60,
                                  child: Card(
                                    margin: const EdgeInsets.symmetric(vertical: 0.0),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                        side: BorderSide(
                                          color: FitnessColor.coloroutlineborder
                                              .withOpacity(0.25),
                                          width: 1.0,
                                        )),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: Image.asset(
                                        item['image'],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                CustomText(
                                    text: item['title'],
                                    fontSize: 3,
                                    textAlign: TextAlign.center,
                                    color: FitnessColor.colortextselectbox,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: Fonts.arial //Fonts.arial,
                                ),
                              ],
                            ),
                          ),
                        );
                        // );
                      },
                    ),
                  ),
                ),
                Container(
                  child: ListView.builder(
                    itemCount: itemslist.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.zero, // Remove extra padding
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      final item = itemslist[index];
                      return Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Card(
                          margin: const EdgeInsets.symmetric(vertical: 0.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0.0),
                              side: BorderSide(
                                color: FitnessColor.coloroutlineborder
                                    .withOpacity(0.25),
                                width: 0.0,
                              )),
                          child: Column(
                            children: [
                              Container(
                                // color: Colors.cyan,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 40,
                                        height: 40,
                                        child: CircleAvatar(
                                          radius: 50,
                                          backgroundImage: AssetImage(
                                              itemslist[index]['userimage']!),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          CustomText(
                                              text: itemslist[index]['name']!,
                                              fontSize: 4,
                                              color: FitnessColor.colorTextPrimary,
                                              fontWeight: FontWeight.bold,
                                              fontFamily:
                                              Fonts.arial //Fonts.arial,
                                          ),
                                          CustomText(
                                              text: itemslist[index]['status']!,
                                              fontSize: 3,
                                              color: FitnessColor.colorTextPrimary,
                                              fontWeight: FontWeight.normal,
                                              fontFamily:
                                              Fonts.arial //Fonts.arial,
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      Padding(
                                        padding:
                                        const EdgeInsets.only(bottom: 16.0),
                                        child: CustomText(
                                            text: itemslist[index]['time']!,
                                            fontSize: 3,
                                            color: FitnessColor.colorTextPrimary,
                                            fontWeight: FontWeight.normal,
                                            fontFamily:
                                            Fonts.arial //Fonts.arial,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: CustomText(
                                          text: itemslist[index]['title']!,
                                          fontSize: 4,
                                          textAlign: TextAlign.start,
                                          color: FitnessColor.colorTextPrimary,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: Fonts.arial //Fonts.arial,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: CustomText(
                                          text: itemslist[index]['description']!,
                                          fontSize: 3,
                                          textAlign: TextAlign.start,
                                          color: FitnessColor.colorTextPrimary,
                                          fontWeight: FontWeight.normal,
                                          fontFamily:
                                          Fonts.arial //Fonts.arial,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4.0,bottom: 4.0),
                                      child: Container(
                                        height: 180,
                                        width: MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10.0)),
                                          image: DecorationImage(
                                            image: AssetImage(
                                                itemslist[index]['image']!),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: 40,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: Colors.grey, width: 1),
                                              borderRadius: const BorderRadius.all(
                                                  Radius.circular(
                                                      10.0)), // Border radius
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: <Widget>[
                                                const Icon(Icons.favorite_border,
                                                    color: Colors.grey),
                                                const SizedBox(width: 5),
                                                CustomText(
                                                    text: itemslist[index]
                                                    ['like']!,
                                                    fontSize: 3,
                                                    color: FitnessColor
                                                        .colorTextPrimary,
                                                    fontWeight: FontWeight.normal,
                                                    fontFamily: Fonts
                                                        .arial //Fonts.arial,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: 40,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: Colors.grey, width: 1),
                                              borderRadius: const BorderRadius.all(
                                                  Radius.circular(
                                                      10.0)), // Border radius
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: <Widget>[
                                                const Icon(Icons.thumb_up,
                                                    color: Colors.grey),
                                                const SizedBox(width: 5),
                                                CustomText(
                                                    text: itemslist[index]
                                                    ['comments']!,
                                                    fontSize: 3,
                                                    color: FitnessColor
                                                        .colorTextPrimary,
                                                    fontWeight: FontWeight.normal,
                                                    fontFamily: Fonts
                                                        .arial //Fonts.arial,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          )
                          ,
                        ),
                      );
                      // );
                    },
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right:14,
            bottom: 50,
            // alignment: Alignment.bottomRight, // Aligns the container to the bottom-right
            child: Padding(
              padding: const EdgeInsets.all(16.0), // Adjust the padding as needed
              child: GestureDetector(
                onTap: (){

                 /* showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
                    ),
                    builder: (BuildContext context) {
                      return PostDialog();
                    },
                  );*/
                  // BottomDialog().showBottomDialog(context);
                   /* Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: HomeScreen(),
                          inheritTheme: true,
                          ctx: context),
                    );*/

                },
                child: Container(
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.red, width: 1),
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)), // Border radius
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Icon(Icons.favorite_border, color: Colors.red),
                      const SizedBox(width: 5),
                      CustomText(
                        text:  DemoLocalization.of(context)!.translate('Post').toString(),//"Post",
                        fontSize: 3,
                        color: FitnessColor.colorTextPrimary,
                        fontWeight: FontWeight.normal,
                        fontFamily: Fonts.arial,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

        ],
      )

    );
  }
}

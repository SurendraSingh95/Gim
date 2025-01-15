import 'package:fitness/question/GeneralTraining.dart';
import 'package:flutter/material.dart';
import '../colors.dart';
import '../custom/CustomText.dart';
import '../custom/Fonts.dart';
import '../utils/Demo_Localization.dart';

class QuestionStart extends StatelessWidget {
  final List<Map<String, String>> fitnessGoals = [
    {
      'title': 'Lose Weight',
      'image': 'assets/images/checkoutimg.png', // replace with actual image path
    },
    {
      'title': 'Get Fitter And Tone Muscle',
      'image': 'assets/images/fimg2.png', // replace with actual image path
    },
    {
      'title': 'Increase Muscle Strength And Size',
      'image': 'assets/images/fimg3.png', // replace with actual image path
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Get the screen size
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      // backgroundColor: Colors.grey.withOpacity(1),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back action
            Navigator.of(context).pop();
          },
        ),
        title: Center(child: Text('')),
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              // Handle close action
              // You can navigate back or close the app/page
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const SizedBox(height: 20),
              // CustomTextWidget(title: "",fontFamily: Fonts.arial,icon: Icons.arrow_back_ios,imageAsset: ""),
              // const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: CustomText(
                  text:DemoLocalization.of(context)!.translate('Whatyourgoal').toString(), //"What's your goal?",
                  fontSize: 7.0,
                  color: FitnessColor.colorTextFour,
                  fontWeight: FontWeight.bold,
                  fontFamily: Fonts.arial,
                  textAlign: TextAlign.start,
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: CustomText(
                    text: DemoLocalization.of(context)!.translate('ick').toString(),//"ick a goal that you think suits you best",
                    fontSize: 3,
                    textAlign: TextAlign.start,
                    color: FitnessColor.colorTextPrimary,
                    fontWeight: FontWeight.normal,
                    fontFamily:
                    Fonts.arial //Fonts.arial,
                ),
              ),

         /* Container(
            height: 250,
            width: double.maxFinite,
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              // side: BorderSide(
              //   color: Colors.grey,
              //   width: 1.0,
              // ),
              image: const DecorationImage(
                image: NetworkImage("https://images.pexels.com/photos/20522325/pexels-photo-20522325/free-photo-of-pier-at-the-beach.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"),
                fit: BoxFit.cover,
              ),
            ),
            child: Card(

              color: Colors.transparent,
              elevation: 0,
             */
              /* shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)
              ),*/
              /*
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),

              ),
              child: const Center(
                child: Text("Pier at the beach"),
              ),
            ),
          ),*/
              Padding(
                padding: const EdgeInsets.only(left: 8.0,right: 8.0,top: 2.0,bottom: 2.0),
                child: Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  color: Colors.transparent,
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(
                      color: Colors.green,
                      width: 1.0,
                    ),
                  ),
                  elevation: 4,
                  child: Container(
                    width:  screenSize.width ,
                    height: screenSize.height * 0.20, // Adjust the height as needed
                    child: InkWell(
                      onTap: () {

                      },
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: DecorationImage(
                                image: NetworkImage(
                                  "https://images.pexels.com/photos/20522325/pexels-photo-20522325/free-photo-of-pier-at-the-beach.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            // top: 10.0,
                            left: 10.0,
                            right: 10.0,
                            bottom: 10,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(DemoLocalization.of(context)!.translate('Race').toString(),//"Race",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontFamily: Fonts.arial,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                               /* ,Text("Booked a running or triathlon race and want to train?",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontFamily: Fonts.arial,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),*/
                                CustomText(
                                    text: DemoLocalization.of(context)!.translate('Bookeda').toString(),//"Booked a running or triathlon race and want to train?",
                                    fontSize: 3.5,
                                    textAlign: TextAlign.start,
                                    color: FitnessColor.colorBg1,
                                    fontWeight: FontWeight.bold,
                                    fontFamily:
                                    Fonts.arial //Fonts.arial,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      /*Padding(
                            padding: EdgeInsets.only(right: 0.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10.0),
                                  bottomRight: Radius.circular(10.0),
                                ),
                                image: DecorationImage(
                                  image:NetworkImage("https://images.pexels.com/photos/20522325/pexels-photo-20522325/free-photo-of-pier-at-the-beach.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"),
                                  */
                      /* AssetImage(fitnessGoals[index]['image']!)*//*
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          )*/
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0,right: 8.0,top: 2.0,bottom:2.0),
                child: Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  color: Colors.transparent,
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(
                      color: Colors.red,
                      width: 1.0,
                    ),
                  ),
                  elevation: 4,
                  child: Container(
                    width:  screenSize.width ,
                    height: screenSize.height * 0.20, // Adjust the height as needed
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => GeneralTraining()));
                      },
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: DecorationImage(
                                image: NetworkImage(
                                  "https://images.pexels.com/photos/20522325/pexels-photo-20522325/free-photo-of-pier-at-the-beach.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            // top: 10.0,
                            left: 10.0,
                            right: 10.0,
                            bottom: 10,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text( DemoLocalization.of(context)!.translate('Generaltraining').toString(),//"General training",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontFamily: Fonts.arial,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                CustomText(
                                    text: DemoLocalization.of(context)!.translate('Runfaster').toString(),//"Run faster and further with a variety of sessions to maintain and build your fitness",
                                    fontSize: 3.5,
                                    textAlign: TextAlign.start,
                                    color: FitnessColor.colorBg1,
                                    fontWeight: FontWeight.bold,
                                    fontFamily:
                                    Fonts.arial //Fonts.arial,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),

                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                child: Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                   color: Colors.grey,
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(
                      color: Colors.blueAccent,
                      width: 1.0,
                    ),
                  ),
                  // elevation: 4,
                  child: Container(
                    width:  screenSize.width ,
                    height: screenSize.height * 0.10, // Adjust the height as needed
                    child: InkWell(
                      onTap: () {

                      },
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.do_disturb_alt_rounded),
                              SizedBox(width: 5,),
                              Text( DemoLocalization.of(context)!.translate('Run').toString(),//"Run a distance goal",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontFamily: Fonts.arial,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Spacer(),
                              Icon(Icons.arrow_forward_ios),
                            ],
                          ),
                        ),
                      )
                      /*Stack(
                        children: [
                        */
                      /*  Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: DecorationImage(
                                image: NetworkImage(
                                  "https://images.pexels.com/photos/20522325/pexels-photo-20522325/free-photo-of-pier-at-the-beach.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),*/
                      /*
                          Positioned(
                            // top: 10.0,
                            left: 10.0,
                            right: 10.0,
                            bottom: 10,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.do_disturb_alt_rounded),
                                Text("Run a distance goal",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontFamily: Fonts.arial,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ],
                      ),*/

                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                child: Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  color: Colors.grey,
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(
                      color: Colors.yellow,
                      width: 1.0,
                    ),
                  ),
                  // elevation: 4,
                  child: Container(
                    width:  screenSize.width ,
                    height: screenSize.height * 0.10, // Adjust the height as needed
                    child: InkWell(
                        onTap: () {

                        },
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.run_circle_outlined),
                                SizedBox(width: 5,),
                                Text( DemoLocalization.of(context)!.translate('Run5k').toString(),//"Run a first 5k",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontFamily: Fonts.arial,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Spacer(),
                                Icon(Icons.arrow_forward_ios),
                              ],
                            ),
                          ),
                        )
                      /*Stack(
                        children: [
                        */
                      /*  Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: DecorationImage(
                                image: NetworkImage(
                                  "https://images.pexels.com/photos/20522325/pexels-photo-20522325/free-photo-of-pier-at-the-beach.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),*/
                      /*
                          Positioned(
                            // top: 10.0,
                            left: 10.0,
                            right: 10.0,
                            bottom: 10,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.do_disturb_alt_rounded),
                                Text("Run a distance goal",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontFamily: Fonts.arial,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ],
                      ),*/

                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                child: Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  color: Colors.grey,
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(
                      color: Colors.orange,
                      width: 1.0,
                    ),
                  ),
                  // elevation: 4,
                  child: Container(
                    width:  screenSize.width ,
                    height: screenSize.height * 0.10, // Adjust the height as needed
                    child: InkWell(
                        onTap: () {

                        },
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.accessible_forward_outlined),
                                SizedBox(width: 5,),
                                Text(DemoLocalization.of(context)!.translate('Postnatal').toString(), //"Postnatal plan",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontFamily: Fonts.arial,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Spacer(),
                                Icon(Icons.arrow_forward_ios),
                              ],
                            ),
                          ),
                        )
                      /*Stack(
                        children: [
                        */
                      /*  Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: DecorationImage(
                                image: NetworkImage(
                                  "https://images.pexels.com/photos/20522325/pexels-photo-20522325/free-photo-of-pier-at-the-beach.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),*/
                      /*
                          Positioned(
                            // top: 10.0,
                            left: 10.0,
                            right: 10.0,
                            bottom: 10,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.do_disturb_alt_rounded),
                                Text("Run a distance goal",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontFamily: Fonts.arial,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ],
                      ),*/

                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                child: Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  color: Colors.grey,
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(
                      color: Colors.orange,
                      width: 1.0,
                    ),
                  ),
                  // elevation: 4,
                  child: Container(
                    width:  screenSize.width ,
                    height: screenSize.height * 0.10, // Adjust the height as needed
                    child: InkWell(
                        onTap: () {

                        },
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.accessible_forward_outlined),
                                SizedBox(width: 5,),
                                Text(DemoLocalization.of(context)!.translate('Functional').toString(),//"Functional fitness",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontFamily: Fonts.arial,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Spacer(),
                                Icon(Icons.arrow_forward_ios),
                              ],
                            ),
                          ),
                        )
                      /*Stack(
                        children: [
                        */
                      /*  Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: DecorationImage(
                                image: NetworkImage(
                                  "https://images.pexels.com/photos/20522325/pexels-photo-20522325/free-photo-of-pier-at-the-beach.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),*/
                      /*
                          Positioned(
                            // top: 10.0,
                            left: 10.0,
                            right: 10.0,
                            bottom: 10,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.do_disturb_alt_rounded),
                                Text("Run a distance goal",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontFamily: Fonts.arial,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ],
                      ),*/

                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                child: Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  color: Colors.grey,
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(
                      color: Colors.orange,
                      width: 1.0,
                    ),
                  ),
                  // elevation: 4,
                  child: Container(
                    width:  screenSize.width ,
                    height: screenSize.height * 0.10, // Adjust the height as needed
                    child: InkWell(
                        onTap: () {

                        },
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.accessible_forward_outlined),
                                SizedBox(width: 5,),
                                Text(DemoLocalization.of(context)!.translate('Postinjuryrecovery').toString(),//"Post-injury recovery",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontFamily: Fonts.arial,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Spacer(),
                                Icon(Icons.arrow_forward_ios),
                              ],
                            ),
                          ),
                        )
                      /*Stack(
                        children: [
                        */
                      /*  Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: DecorationImage(
                                image: NetworkImage(
                                  "https://images.pexels.com/photos/20522325/pexels-photo-20522325/free-photo-of-pier-at-the-beach.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),*/
                      /*
                          Positioned(
                            // top: 10.0,
                            left: 10.0,
                            right: 10.0,
                            bottom: 10,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.do_disturb_alt_rounded),
                                Text("Run a distance goal",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontFamily: Fonts.arial,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ],
                      ),*/

                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                child: Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  color: Colors.grey,
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(
                      color: Colors.green,
                      width: 1.0,
                    ),
                  ),
                  // elevation: 4,
                  child: Container(
                    width:  screenSize.width ,
                    height: screenSize.height * 0.10, // Adjust the height as needed
                    child: InkWell(
                        onTap: () {

                        },
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.accessible_forward_outlined),
                                SizedBox(width: 5,),
                                Text(DemoLocalization.of(context)!.translate('Postracerecovery').toString(),//"Post-race recovery",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontFamily: Fonts.arial,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Spacer(),
                                Icon(Icons.arrow_forward_ios),
                              ],
                            ),
                          ),
                        )
                      /*Stack(
                        children: [
                        */
                      /*  Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: DecorationImage(
                                image: NetworkImage(
                                  "https://images.pexels.com/photos/20522325/pexels-photo-20522325/free-photo-of-pier-at-the-beach.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),*/
                      /*
                          Positioned(
                            // top: 10.0,
                            left: 10.0,
                            right: 10.0,
                            bottom: 10,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.do_disturb_alt_rounded),
                                Text("Run a distance goal",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontFamily: Fonts.arial,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ],
                      ),*/

                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                child: Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  color: Colors.grey,
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(
                      color: Colors.green,
                      width: 1.0,
                    ),
                  ),
                  // elevation: 4,
                  child: Container(
                    width:  screenSize.width ,
                    height: screenSize.height * 0.10, // Adjust the height as needed
                    child: InkWell(
                        onTap: () {

                        },
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.accessible_forward_outlined),
                                SizedBox(width: 5,),
                                Text(DemoLocalization.of(context)!.translate('TrainforaTriathlon').toString(),//"Train for a Triathlon",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontFamily: Fonts.arial,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Spacer(),
                                Icon(Icons.arrow_forward_ios),
                              ],
                            ),
                          ),
                        )
                      /*Stack(
                        children: [
                        */
                      /*  Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: DecorationImage(
                                image: NetworkImage(
                                  "https://images.pexels.com/photos/20522325/pexels-photo-20522325/free-photo-of-pier-at-the-beach.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),*/
                      /*
                          Positioned(
                            // top: 10.0,
                            left: 10.0,
                            right: 10.0,
                            bottom: 10,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.do_disturb_alt_rounded),
                                Text("Run a distance goal",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontFamily: Fonts.arial,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ],
                      ),*/

                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 100,
              )
              /*ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: fitnessGoals.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {

                  return Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    color: Colors.transparent,
                    margin: const EdgeInsets.symmetric(vertical: 10.0),
                    shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(
                        color: Colors.red,
                        width: 2.0,
                      ),
                    ),
                    elevation: 4,
                    child: Container(
                      width:  screenSize.width ,
                      height: screenSize.height * 0.15, // Adjust the height as needed
                      child: InkWell(
                        onTap: () {

                        },
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    "https://images.pexels.com/photos/20522325/pexels-photo-20522325/free-photo-of-pier-at-the-beach.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 10.0,
                              left: 10.0,
                              right: 10.0,
                              child: Column(
                                children: [
                                  Text(
                                    fitnessGoals[index]['title']!,
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontFamily: Fonts.arial,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  )
                                  ,Text(
                                    fitnessGoals[index]['title']!,
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontFamily: Fonts.arial,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),*/
              /*Padding(
                          padding: EdgeInsets.only(right: 0.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10.0),
                                bottomRight: Radius.circular(10.0),
                              ),
                              image: DecorationImage(
                                image:NetworkImage("https://images.pexels.com/photos/20522325/pexels-photo-20522325/free-photo-of-pier-at-the-beach.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"),
                                *//**/
              /* AssetImage(fitnessGoals[index]['image']!)*//**//*
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        )*//*
                      ),
                    ),
                  );
                },
              )*/
            ],
          ),
        ),
      ),
      Positioned(
      bottom: 16,
      right: 8,
      left: 8,
      child:
      /* Padding(
        padding: const EdgeInsets.only(left: 0.0,right: 0.0),
        child: Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          color: Colors.grey,
          // margin: const EdgeInsets.symmetric(vertical: 10.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(
              color: FitnessColor.colorBg1,
              width: 1.0,
            ),
          ),
          // elevation: 4,
          child: Container(
            // width:  screenSize.width ,
            height: screenSize.height * 0.08, // Adjust the height as needed
            child: InkWell(
                onTap: () {

                },
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Text("Help me choose my goal",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontFamily: Fonts.arial,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                      ],
                    ),
                  ),
                )/*Stack(
                        children: [
                        *//*  Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: DecorationImage(
                                image: NetworkImage(
                                  "https://images.pexels.com/photos/20522325/pexels-photo-20522325/free-photo-of-pier-at-the-beach.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),*//*
                          Positioned(
                            // top: 10.0,
                            left: 10.0,
                            right: 10.0,
                            bottom: 10,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.do_disturb_alt_rounded),
                                Text("Run a distance goal",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontFamily: Fonts.arial,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ],
                      ),*/

            ),
          ),
        ),
      )*/
      Padding(
        padding: EdgeInsets.all(0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                /*showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.vertical(top: Radius.circular(25.0)),
                  ),
                  builder: (BuildContext context) {
                    return PostReferralCodeDialog();
                  },
                );*/
              },
              child: Container(
                height: 50,

               decoration: BoxDecoration(
                  color: Colors.grey,
                  border: Border.all(color: FitnessColor.colorfillText, width: 1),
                  borderRadius: BorderRadius.all(
                      Radius.circular(10.0)), // Border radius
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // Icon(Icons.favorite_border, color: Colors.red),
                    // SizedBox(width: 5),
                    CustomText(
                      text: DemoLocalization.of(context)!.translate('Helpmechoose').toString(),//"Help me choose my goal",
                      fontSize: 4,
                      color: FitnessColor.colorBg1,
                      fontWeight: FontWeight.bold,
                      fontFamily: Fonts.arial,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ),
    ],
    )

      ,
    );
  }
}
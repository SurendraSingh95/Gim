import 'package:flutter/material.dart';
import '../colors.dart';
import '../custom/CstAppbarWithtextimage.dart';
import '../custom/CustomButton.dart';
import '../custom/CustomText.dart';
import '../custom/Fonts.dart';
import '../success/SuccessScreen.dart';
import '../utils/Demo_Localization.dart';

class CheckOutSecondScreen extends StatefulWidget {
  const CheckOutSecondScreen({super.key});

  @override
  State<CheckOutSecondScreen> createState() => _CheckOutSecondScreenState();
}

class _CheckOutSecondScreenState extends State<CheckOutSecondScreen> {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> items = [
      {
        'image': 'assets/images/checkoutimg.png',
        'title': 'Full Shot Woman \nStretching Arm',
        'price': '\$6.99',
      },
    ];

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 16.0,right: 16,top: 16),
              child: CstAppbarWithtextimage(
                title: DemoLocalization.of(context)!.translate('Checktext').toString(),//'Checkout',
                icon: Icons.arrow_back_ios,
                // imageAsset: 'assets/images/editbtn.png',
                // Uncomment this line to show the image
                fontFamily: Fonts.arial,
                  onImageTap: (){

                  }
              ),
            ),
            // SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 16.0,right: 16,top: 0,bottom: 10),
              child: ListView.builder(
                itemCount: 1,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 10.0),

                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(
                          color: FitnessColor.coloroutlineborder.withOpacity(0.25),
                          width: 1.0,
                        )),
                    // height: screenSize.height * 0.15,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            // color: Colors.cyan,
                            height: 90,
                            width: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              // Set the same radius here
                              child: Image.asset(
                                item['image'],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                  text: item['title'],
                                  fontSize: 4,
                                  color: FitnessColor.colortextselectbox,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: Fonts.arial //Fonts.arial,
                                  ),
                              CustomText(
                                  text: item['price'],
                                  fontSize: 4,
                                  color: FitnessColor.colortextselectbox,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: Fonts.arial //Fonts.arial,
                                  ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                  // );
                },
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height/8.0,),
            Container(
              // color: FitnessColor.colorinsidebox,
              height: 200,
              child: ClipRRect(
                // borderRadius: BorderRadius.only(
                //   topLeft: Radius.circular(20.0),
                //   topRight: Radius.circular(20.0),
                // ),
                child: Card(
                  elevation: 5,
                  color: FitnessColor.colorBg1,
                  margin: EdgeInsets.symmetric(vertical: 10.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.0),
                      topRight: Radius.circular(40.0),
                    ),
                  /*  side: BorderSide(
                      // color:  FitnessColor.coloroutlineborder,
                      width: 1.0,
                    ),*/
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CustomText(
                                text: DemoLocalization.of(context)!.translate('Total').toString(),//"Total",
                                fontSize: 4,
                                color: FitnessColor.colortexttotal,
                                fontWeight: FontWeight.bold,
                                fontFamily: Fonts.arial //Fonts.arial,
                                ),
                            const Spacer(),
                            CustomText(
                                text: "\$6.99",
                                fontSize: 4,
                                color: FitnessColor.colortexttotalprice,
                                fontWeight: FontWeight.bold,
                                fontFamily: Fonts.arial //Fonts.arial,
                                )
                          ],
                        ),
                        Divider(),
                        Row(
                          children: [
                            CustomText(
                                text: DemoLocalization.of(context)!.translate('Subtotal').toString(),//"Subtotal",
                                fontSize: 5,
                                color: FitnessColor.colortexttotal,
                                fontWeight: FontWeight.bold,
                                fontFamily: Fonts.arial //Fonts.arial,
                                ),
                            Spacer(),
                            CustomText(
                                text: "\$6.99",
                                fontSize: 4,
                                color: FitnessColor.colortexttotalprice,
                                fontWeight: FontWeight.bold,
                                fontFamily: Fonts.arial //Fonts.arial,
                                )
                          ],
                        ),
                        SizedBox(height: 15,),
                        Center(
                          child: CustomButton(
                            text: DemoLocalization.of(context)!.translate('Confirm').toString(),//'Confirm',
                            fontFamily: Fonts.arial,
                            fontSize: 22,
                            color: FitnessColor.colorTextThird,
                            onPressed: () {
                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context) => SuccessScreen()));

                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )

            /* Container(

              height: 200,

              child:  Card(
                margin: EdgeInsets.symmetric(vertical: 10.0),

                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(

                      // color:  FitnessColor.coloroutlineborder,
                      width: 1.0,
                    )),
                child: Column(
                  children: [
                    Row(
                      children: [

                      ],
                    ),
                    Center(
                      child: CustomButton(
                        text: 'Confirm',
                        fontFamily: Fonts.arial,
                        fontSize: 22,
                        color: FitnessColor.colorTextThird,
                        onPressed: () {},
                      ),
                    ),

                  ],
                ),
              ),
            )*/
          ],
        ),
      ),
    );
  }
}

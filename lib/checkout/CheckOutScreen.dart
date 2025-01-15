import 'package:fitness/checkout/CheckOutSecondScreen.dart';
import 'package:flutter/material.dart';
import '../colors.dart';
import '../custom/CstAppbarWithtextimage.dart';
import '../custom/CustomButton.dart';
import '../custom/CustomText.dart';
import '../custom/CustomTextFormField.dart';
import '../custom/Fonts.dart';
import '../utils/Demo_Localization.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _controllerCardName = TextEditingController();
    final TextEditingController _controllerCardNumber = TextEditingController();
    final TextEditingController _controllerExpiry = TextEditingController();
    final TextEditingController _controllerCvv = TextEditingController();
    String? _selectedCard; // Nullable type to handle no initial selection
    final List<Map<String, dynamic>> items = [
      {
        'title': '1 month videos',
        'image': 'assets/images/profileimg1.png',
        'subtitle': 'Full Shot man Stretching Arm',
        'details': 'View more details',
        'level': 'Beginner',
        'time': '30 min'
      },
      {
        'title': '3 month videos',
        'image': 'assets/images/profileimg2.png',
        'subtitle': 'Half Shot man Running',
        'details': 'View more details',
        'level': 'Intermediate',
        'time': '30 min'
      },
      {
        'title': '6 month videos',
        'image': 'assets/images/profileimg3.png',
        'subtitle': 'Full Shot man Stretching Arm',
        'details': 'View more details',
        'level': 'Advanced',
        'time': '30 min'
      },
    ];


    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(height: 20),
                CstAppbarWithtextimage(
                  title: DemoLocalization.of(context)!.translate('Checktext').toString(),// 'Checkout',
                  icon: Icons.arrow_back_ios,
                  // imageAsset: 'assets/images/editbtn.png',
                  // Uncomment this line to show the image
                  fontFamily: Fonts.arial,
                    onImageTap: (){

                    }
                ),
                SizedBox(height: 10),
                CustomText(
                    text: DemoLocalization.of(context)!.translate('SelectaPaymentMethod').toString(),//"Select a Payment Method",
                    fontSize: 4,
                    color: FitnessColor.colorTextPrimary,
                    fontWeight: FontWeight.normal,
                    fontFamily: Fonts.arial //Fonts.arial,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedCard = "mastercard";
                    });
                  },
                  child: Row(
                    children: [
                      Container(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.asset("assets/images/rectangleimg.png"),
                            Center(
                              child:
                              Image.asset("assets/images/mstcartimg.png"),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 8), // Adjust width as needed
                      CustomText(
                        text:DemoLocalization.of(context)!.translate('MasterCardVisa').toString(),// "Master Card Visa",
                        fontSize: 5,
                        color: FitnessColor.colorTextThird,
                        fontWeight: FontWeight.normal,
                        fontStyle: FontStyle.italic,
                        fontFamily: Fonts.arial,
                      ),
                      Spacer(), // Add spacer to push radio button to the right
                      Radio<String>(
                        value: "mastercard",
                        groupValue: _selectedCard,
                        onChanged: (String? value) {
                          setState(() {
                            _selectedCard = value!;
                          });
                        },
                        activeColor: FitnessColor.colorTextThird,
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedCard = "mastercard";
                      });
                    },
                    child: Row(
                      children: [
                        Container(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.asset("assets/images/rectangleimg.png"),
                              Center(
                                  child: Image.asset(
                                      "assets/images/kngimg.png")), //kngimg
                            ],
                          ),
                        ),
                        SizedBox(width: 8),
                        //
                        CustomText(
                            text: DemoLocalization.of(context)!.translate('Knet').toString(),//"Knet",
                            fontSize: 5,
                            color: FitnessColor.colorTextThird,
                            fontWeight: FontWeight.normal,
                            fontStyle: FontStyle.italic,
                            fontFamily: Fonts.arial //Fonts.arial,
                        ),
                        Spacer(),
                        // Add spacer to push radio button to the right
                        Radio<String>(
                          value: "knet",
                          groupValue: _selectedCard,
                          onChanged: (String? value) {
                            setState(() {
                              _selectedCard = value!;
                            });
                          },
                          activeColor: FitnessColor.colorTextThird,
                        ),
                      ],
                    )),
                const SizedBox(height: 20),
                Container(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: DemoLocalization.of(context)!.translate('CardHolderName').toString(),//"Card Holder Name",
                          fontSize: 4,
                          color: FitnessColor.colorTextPrimary,
                          fontWeight: FontWeight.bold,
                          fontFamily: Fonts.arial,
                          textAlign: TextAlign.start,
                        ),
                        const SizedBox(height: 5),
                        CustomTextFormField(
                          // labelText: 'Email',
                          hintText:DemoLocalization.of(context)!.translate('Enterholdername').toString(),// 'Enter holder name',

                          controller: _controllerCardName,
                          // icon: "Icons.email",

                          onChanged: (value) {
                            print('fd: $value');
                          },
                        ),
                        const SizedBox(height: 10),
                        CustomText(
                          text: DemoLocalization.of(context)!.translate('CardNumber').toString(),//"Card Number",
                          fontSize: 4,
                          color: FitnessColor.colorTextPrimary,
                          fontWeight: FontWeight.bold,
                          fontFamily: Fonts.arial,
                          textAlign: TextAlign.start,
                        ),
                        const SizedBox(height: 5),
                        CustomTextFormField(
                          // labelText: 'Email',
                          hintText: DemoLocalization.of(context)!.translate('Entercardnumber').toString(),//'Enter card number',

                          controller: _controllerCardNumber,
                          // icon: "Icons.email",

                          onChanged: (value) {
                            print('dfd: $value');
                          },
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 2.3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomText(
                                    text: DemoLocalization.of(context)!.translate('ExpiryDate').toString(),//"Expiry Date",
                                    fontSize: 4,
                                    color: FitnessColor.colorTextPrimary,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: Fonts.arial,
                                    textAlign: TextAlign.start,
                                  ),
                                  const SizedBox(height: 5),
                                  CustomTextFormField(
                                    // labelText: 'Email',
                                    hintText: DemoLocalization.of(context)!.translate('MMYY').toString(),//'MM/YY',

                                    controller: _controllerExpiry,
                                    // icon: "Icons.email",
                                    // secondaryIcon: Icons.check,
                                    onChanged: (value) {
                                      print('fd: $value');
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Spacer(),
                            Container(
                              width: MediaQuery.of(context).size.width / 2.3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomText(
                                    text: DemoLocalization.of(context)!.translate('CVV').toString(),//"CVV",
                                    fontSize: 4,
                                    color: FitnessColor.colorTextPrimary,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: Fonts.arial,
                                    textAlign: TextAlign.start,
                                  ),
                                  const SizedBox(height: 5),
                                  CustomTextFormField(
                                    // labelText: 'Email',
                                    hintText: DemoLocalization.of(context)!.translate('no123').toString(),//'123',

                                    controller: _controllerCvv,
                                    // icon: "Icons.email",
                                    // secondaryIcon: Icons.check,
                                    onChanged: (value) {
                                      print('fd: $value');
                                    },
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                      ]),
                ),
                const SizedBox(height: 20),
                Center(
                  child: CustomButton(
                    text: DemoLocalization.of(context)!.translate('Confirm').toString(),//'Confirm',
                    fontFamily: Fonts.arial,
                    fontSize: 22,
                    color: FitnessColor.colorTextThird,
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context) => CheckOutSecondScreen()));

                    },
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

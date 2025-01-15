import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../colors.dart';
import '../custom/CustomText.dart';
import '../custom/Fonts.dart';
import '../score/ScoreScreen.dart';
import '../utils/Demo_Localization.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({super.key});

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Image.asset(
                "assets/images/successicon.png",
                width: MediaQuery.of(context).size.width / 1.5,
              ),
              GestureDetector(
                onTap: (){
               //   Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context) => ScoreScreen()));

                },
                child: CustomText(
                    textAlign: TextAlign.center,
                    text: DemoLocalization.of(context)!.translate('YourMembershiphasbeenactivatedsuccessfully').toString(),//"Your Membership has been activated successfully",
                    fontSize: 8,
                    color: FitnessColor.colortexttotalprice,
                    fontWeight: FontWeight.bold,
                    fontFamily: Fonts.arial //Fonts.arial,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

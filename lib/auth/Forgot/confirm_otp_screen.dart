// Flutter imports:
import 'package:fitness/Controllers/Auth%20Controllers/login_controller.dart';
import 'package:fitness/Utils/utils.dart';
import 'package:fitness/colors.dart';
import 'package:fitness/constants/constants.dart';
import 'package:fitness/custom/CustomButton.dart';
import 'package:fitness/custom/CustomText.dart';
import 'package:fitness/custom/CustomWidget.dart';
import 'package:fitness/custom/Fonts.dart';
import 'package:fitness/utils/Demo_Localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:



class ConfirmOtpScreen extends StatefulWidget {
  final String email;
  final int? otp;

  const ConfirmOtpScreen({super.key, required this.otp, required this.email});

  @override
  State<ConfirmOtpScreen> createState() => _ConfirmOtpScreenState();
}

class _ConfirmOtpScreenState extends State<ConfirmOtpScreen> {
  double large = Constants.largeSize;
  double h = Constants.screen.height;
  double w = Constants.screen.width;
  LoginController loginController = Get.put(LoginController());

  final List<TextEditingController> _controllers =
      List.generate(4, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode());

  /// get next or previous field
  void nextField(String value, int index) {
    if (value.length == 1 && index < 3) {
      FocusScope.of(context).nextFocus();
    } else if (value.isEmpty && index > 0) {
      FocusScope.of(context).previousFocus();
    }
  }

  ///get otp from all controllers
  String getOtp() {
    String otp =
        '${_controllers[0].text}${_controllers[1].text}${_controllers[2].text}${_controllers[3].text}';
    return otp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: h,
        padding: EdgeInsets.symmetric(horizontal: w * 0.05, vertical: 30)
            .copyWith(top: 56),
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/a2a2/back_image.jpg'),
              fit: BoxFit.fill
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomTextWidget(
                title: DemoLocalization.of(context)!.translate('Skip').toString(),  // Localized title
                fontFamily: Fonts.arial,
                icon: Icons.arrow_back_ios,
                imageAsset: "",
                onTap: () {
                  Get.back();
                },
              ),
              SizedBox(
                height: large * 0.02,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   CustomText(
                      text: "Verification",
                      fontSize: 9,
                      color: FitnessColor.appbarBg,
                      fontWeight: FontWeight.bold),
                  SizedBox(
                    height: large * 0.01,
                  ),
                  CustomText(
                      text:
                          "Enter the verification code we send you on ${widget.email}",
                      fontSize: 5,
                      color:FitnessColor.primary,
                      fontWeight: FontWeight.normal),
                  const SizedBox(height: 5,),
                  CustomText(
                      text:
                      "OTP:${widget.otp}",
                      fontSize: 5,
                      color: FitnessColor.appbarBg,
                      fontWeight: FontWeight.normal),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(4, (index) {
                      return SizedBox(
                        width: large * 0.08,
                        height: large * 0.08,
                        child: TextField(
                          controller: _controllers[index],
                          focusNode: _focusNodes[index],
                          maxLength: 1,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 24,color: FitnessColor.secondary),
                          decoration: InputDecoration(

                            counterText: "",
                           enabledBorder: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(12.0),
                               borderSide: const BorderSide(color: FitnessColor.secondary)),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: const BorderSide(color: Colors.black)),
                            border: OutlineInputBorder(

                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: const BorderSide(color: FitnessColor.secondary), // Use custom color
                            ),
                          ),
                          onChanged: (value) => nextField(value, index),
                        ),
                      );
                    }),
                  ),
                  SizedBox(
                    height: large * 0.03,
                  ),

                ],
              ),
              Center(
                child: CustomButton(
                  color: Colors.black,
                  height: 55,
                  text: 'Verify OTP',
                  onPressed: () {
                    String otp = getOtp();
                    if (otp.isEmpty) {
                      Utils.mySnackBar(title: "Enter OTP", msg: "Please enter OTP");
                    } else if (otp == widget.otp.toString()) {
                      Get.back();
                      Utils.mySnackBar(title: "OTP verified successfully");
                      loginController.verifyOtp(widget.otp!);
                    } else {
                      Utils.mySnackBar(title: "Wrong OTP", msg: "The OTP you entered is incorrect");
                    }
                  },

                  fontFamily: '',

                ),
              ),
              SizedBox(
                height: large * 0.03,
              ),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: "Haven't received the verification code?",
                    style: TextStyle(
                      fontFamily: Fonts.arial,
                      color: FitnessColor.appbarBg,
                      fontSize: Constants.getResponsiveFontSize(3.5),
                      fontWeight: FontWeight.normal,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: " Resend",
                        style: TextStyle(
                          fontFamily: Fonts.arial, //Fonts.arial,
                          color: FitnessColor.appbarBg,
                          fontSize: Constants.getResponsiveFontSize(4.0),
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                           // loginController.verifyForgotMobile();
                          },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }
}

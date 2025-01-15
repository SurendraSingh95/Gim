/*
import 'dart:async';
import 'dart:developer';

import 'package:fitness/Controllers/Auth%20Controllers/login_controller.dart';
import 'package:fitness/colors.dart';
import 'package:fitness/custom/CustomButton.dart';
import 'package:fitness/custom/CustomText.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../../constants/constants.dart';
import '../../../constants/responsive.dart';

class VerifyOtpScreen extends StatefulWidget {
  final String mobileNumber;
  final dynamic otp;
  const VerifyOtpScreen({super.key, required this.mobileNumber,required this.otp});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen>{
  double large = Constants.largeSize;
  double h = Constants.screen.height;
  double w = Constants.screen.width;
  LoginController loginController = Get.find<LoginController>();

  String? otpCode;
  String? appSignature;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    print("this is otp-->${widget.otp}");
    // SmsAutoFill().getAppSignature.then((signature) {
    //   setState(() {
    //     appSignature = signature;
    //     log('app signature  $appSignature');
    //   });
    // });
    startContDown();
  }

  // int minutes = 0;
  ValueNotifier<int> seconds = ValueNotifier(0);

  ///resend code count down
  void startContDown({bool resend = false}) {
    // minutes = 1;
    seconds.value = 59;
    if(resend){
      setState(() {});
    }
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (*/
/*minutes == 0 &&*//*
 seconds.value == 0) {
        timer.cancel();
        setState(() {});
      }
      */
/*else if (seconds.value == 0) {
        minutes--;
        seconds.value = 59;
      } *//*

      else {
        seconds.value--;
      }
    });
  }

  @override
  void dispose() {
    if (timer != null) {
      timer!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: h,
        padding: EdgeInsets.symmetric(horizontal: w * 0.05, vertical: 30),
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/a2a2/back_image.jpg'),
              fit: BoxFit.fill
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Responsive(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
              //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: const Icon(Icons.arrow_back_ios, size: 30)),
                       CustomText(
                          text: "Verification",
                          fontSize: 9,
                          color: FitnessColor.appbarBg,
                          fontWeight: FontWeight.bold),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: large * 0.02,
                      ),
                      Image.asset("assets/a2a2/a2a2logo.png",height: large * 0.15,width: large * 0.15,),
                      SizedBox(
                        height: large * 0.03,
                      ),
                      CustomText(
                          text:
                              "Enter the verification code we sent you on ${widget.mobileNumber}",
                          fontSize: 5,
                          color: FitnessColor.colorTextPrimary,
                          fontWeight: FontWeight.normal),
            
                      CustomText(
                          text:
                          "OTP :${widget.otp}",
                          fontSize: 5,
                          color:FitnessColor.colorTextPrimary,
                          fontWeight: FontWeight.normal),
                      PinFieldAutoFill(
                        codeLength: 4,
                        autoFocus: true,
                        cursor: Cursor(
                            color: Colors.black,
                          width: 2,
                          height: 16
                        ),
                        decoration: UnderlineDecoration(
                          lineHeight: 0,
                          gapSpace: 20,
                          lineStrokeCap: StrokeCap.square,
            
                          bgColorBuilder: PinListenColorBuilder(
                              FitnessColor.secondary,
                              FitnessColor.secondary.withOpacity(0.4)),
                          colorBuilder:
                              const FixedColorBuilder(Colors.transparent),
            
                        ),
                        
                        // decoration: BoxLooseDecoration(
                        //   strokeColorBuilder: PinListenColorBuilder(
                        //     NatureColor.blackColor,   // Default color
                        //     NatureColor.primary,     // Color when the field is active
                        //   ),
                        //   gapSpace: 16.0,  // Adjust gap space between OTP fields
                        // ),
                        onCodeSubmitted: (code) {
                          otpCode = code;
                          log("OTP Submitted: $code");
                        },
                        onCodeChanged: (code) {
                          if (code?.length == 4) {
                            otpCode = code;
                            log("Complete OTP: $code");
                          }
                        },
                      ),
                      SizedBox(
                        height: large * 0.03,
                      ),
                      Row(
                        mainAxisAlignment:  MainAxisAlignment.center,
                        children: [
                          CustomText(
                            text: seconds.value == 0 */
/* && minutes == 0*//*

                                ? "Didn't receive code? "
                                : 'Resend code after : ',
                            fontSize: 4.5, color: FitnessColor.primary, fontWeight: FontWeight.bold,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          ValueListenableBuilder(
                              valueListenable: seconds,
                              builder: (_, second, child) {
                                String timerText =
                                    */
/*${minutes.toString().padLeft(2, '0')}*//*
'00:${second.toString().padLeft(2, '0')}';
                                return InkWell(
                                  onTap: () async {
                                    if (second != 0) return;
                                   // await loginController.verifyRegisterMobile(resend: true);startContDown(resend: true);
                                  },
                                  child: CustomText(
                                    text: second == 0 */
/*&& minutes == 0*//*

                                        ? 'Resend'
                                        : timerText,
                                    fontSize: 4.6,
                                    color: FitnessColor.primary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                );
                              })
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: large * 0.03,
                  ),
                  Center(
                    child: CustomButton(
                      height: 55,
                      text: 'Verify',
                      onPressed: () {
                        loginController.verifyOtp(otpCode ?? '');
                      }, fontFamily: '',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
*/

import 'dart:developer';


import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fitness/Api%20Services1/api_helper_methods.dart';
import 'package:fitness/Api%20Services1/api_services.dart';
import 'package:fitness/Screens/home_screen.dart';
import 'package:fitness/Screens/question_answer_screen.dart';
import 'package:fitness/Screens/select_trainer_screen.dart';
import 'package:fitness/auth/Forgot/confirm_otp_screen.dart';
import 'package:fitness/auth/Forgot/reset_password_screen.dart';
import 'package:fitness/auth/VerifyOtpScreen.dart';
import 'package:fitness/utils/Demo_Localization.dart';
import 'package:fitness/utils/shared_preferences.dart';
import 'package:fitness/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {

  RxBool passwordVisible = false.obs;
  RxBool isLoading = false.obs;
  RxInt selectedIndex = 0.obs;


  ///api services instances
  ApiServices apiServices = ApiServices();
  ApiBaseHelper apiBaseHelper = ApiBaseHelper();

  String get languageCode => SharedPref.getLanguageToPrefs();


  ///api urls
  String get loginUrl => apiServices.login;
  String get socialUrl => apiServices.socialLogin;
  String get forgotPassword => apiServices.forgotPassword;
  String get verifyOtpUrl =>apiServices.verifyOtp;

  String _fcmToken = '';
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final forgetPassEmailController = TextEditingController();
  ///on controller close
  ///
  final _messaging = FirebaseMessaging.instance;

  Future<void> getFCMToken() async {
    _fcmToken = await _messaging.getToken() ?? "";
    print("fcm token -->$_fcmToken");
  }
 /* @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }*/

  ///handle password visibility
  void togglePasswordVisibility() {
    passwordVisible.value = !passwordVisible.value;
  }

  /// login method on submit
  Future<void> login(context) async {
    if (emailController.text.isEmpty) {
      Utils.mySnackBar(title:DemoLocalization.of(context)!.translate('NotFound').toString(),msg: DemoLocalization.of(context)!.translate('ENTER_MAIL').toString(),maxWidth: 200 );
    } else if (passwordController.text.isEmpty) {
      Utils.mySnackBar(title:DemoLocalization.of(context)!.translate('PASSWORD_FOUND').toString(),msg: DemoLocalization.of(context)!.translate('ENTER_PASS').toString(),maxWidth: 200 );
    } else {

      getLogin();

    }
  }

  ///  api request for login


   getLogin() async {

    getFCMToken();
    try {
      Utils.showLoader();

      final response = await apiBaseHelper.postAPICall(Uri.parse(loginUrl),langCode:languageCode.toString() , {
        "email": emailController.text.trim(),
        "password": passwordController.text.trim(),
        "fcm_token": _fcmToken,
      });
      Get.back();
      if (response["status"] == false) {
        Utils.mySnackBar(
          title: "Error Found",
          msg: response["message"],
        );
      } else {
        await SharedPref.setLoginAndUserId(response['user']['id'].toString());
        Utils.mySnackBar(
          msg: response["message"]
        );
        Get.to(()=>const QuestionAnswerScreen());
      }
    }finally {
      Future.delayed(const Duration(seconds: 3), () {
        if (Get.isDialogOpen ?? false) {
          Get.back();
        }
      });
    }
  }



  ///handle verify email and send confirmation code method and get back to the login screen
  Future<bool> verifyEmailAndSendCode() async {
    if (forgetPassEmailController.text.isEmpty) {
      Utils.mySnackBar(title:"Email Not Found",msg: 'Please Enter email id',maxWidth: 200 );
      return false;
    } else {
      isLoading.value = true;
      // await apiRequests.userLogin(
      //   mobileController.text,
      //   passwordController.text,
      //   audioController,
      // );
      Get.back();
      isLoading.value = false;
      return true;
    }
  }


  /// forgot password api
  Future<String?> verifyForgotEmail(context,{bool resend =  false} ) async {
    if (forgetPassEmailController.text.isEmpty) {
      Utils.mySnackBar(title:DemoLocalization.of(context)!.translate('NotFound').toString(),msg: DemoLocalization.of(context)!.translate('ENTER_MAIL').toString(),maxWidth: 200 );

      //Utils.mySnackBar(title: "Email id not found", msg: "Please email id verify");
      return '';
    }
    Utils.showLoader();
    try {
      final response = await apiBaseHelper.postAPICall(Uri.parse(forgotPassword),langCode:languageCode.toString(), {
        "email": forgetPassEmailController.text,
      });
      Get.back();
      if (response["status"] == false) {
        Utils.mySnackBar(
            title: "Error Found",
            msg: response["message"] ?? "Something went wrong please try again");
      } else {
        Get.back();
        Utils.mySnackBar(
            title: "Success",
            msg: response["message"],duration: const Duration(seconds: 2));

        var otp = response['otp'];
        if(!resend){
          Get.to(() => ConfirmOtpScreen(otp:otp, email:forgetPassEmailController.text));
        }
      }
    } on Exception catch (e) {
      Get.back();
    }
  }

  ///  api request for verify otp
  Future verifyOtp(int otp) async {
    if (otp == null) {
      Utils.mySnackBar(
          title: "Otp not  found", msg: "Please enter otp to verify");
      return;
    }
    Utils.showLoader();
    try {
      final response = await apiBaseHelper.postAPICall(Uri.parse(verifyOtpUrl),langCode:languageCode.toString(), {
        "email":forgetPassEmailController.text,
        "otp":otp.toString(),
      });
      Get.back();
      if (response["status"] == false) {
        Utils.mySnackBar(
            title: "Error Found",
            msg: response["message"] ?? "Something went wrong please try again");
      } else {
        Utils.mySnackBar(
            title: "Error Found",
            msg: response["message"] ?? "Something went wrong please try again");
      //  Get.close(2);
        print("sssss${otp}${forgetPassEmailController.text}");
        Get.to(()=> ResetPasswordScreen(isFalse: true,email: forgetPassEmailController.text,otp:otp.toString() ,));
       /* Get.to(() => RegistrationScreen(
          mobileNumber: verifyMobileController.text,otp:otp,
        ));*/
      }
    } on Exception catch (e) {
      Get.back();
      Utils.mySnackBar(
          title: "Error Found",
          msg: e.toString());
    }
    return null;
  }

  /// social login
  Future<void> socialLogin(String? email) async {
    try {
      Utils.showLoader();

      final response = await apiBaseHelper.postAPICall(Uri.parse(socialUrl),langCode:languageCode.toString(), {
        "email":email,
      });

      Get.back();
      if (response["status"] == false) {
        Utils.mySnackBar(
          title: "Error Found",
          msg: response["message"] ?? "Something went wrong. Please try again.",
        );
      } else {
        await SharedPref.setLoginAndUserId(response['user']['id'].toString());
        Utils.mySnackBar(title: "Success", msg: "Logged in successfully!");
        Get.to(() => const HomeScreen());
      }
    } catch (error) {
      Get.back();
      Utils.mySnackBar(
        title: "Error",
        msg: error.toString(),
      );
    } finally {
      Future.delayed(const Duration(seconds: 5), () {
        if (Get.isDialogOpen ?? false) {
          Get.back();
        }
      });
    }
  }

}

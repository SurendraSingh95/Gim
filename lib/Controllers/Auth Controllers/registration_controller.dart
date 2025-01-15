import 'dart:async';

import 'package:fitness/Api%20Services1/api_helper_methods.dart';
import 'package:fitness/Api%20Services1/api_services.dart';
import 'package:fitness/Screens/home_screen.dart';
import 'package:fitness/Utils/utils.dart';
import 'package:fitness/auth/LoginScreen.dart';
import 'package:fitness/utils/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
class RegistrationController extends GetxController {

  var passwordVisible = false.obs;
  var isLoading = false.obs;
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  RxString userName = ''.obs;
  RxString userEmail = ''.obs;

  final GoogleSignIn _googleSignIn = GoogleSignIn(clientId: '1065267522684-agk7eplcvboje8fcfn68044of0bv37e1.apps.googleusercontent.com',scopes: ['email']);
  final FirebaseAuth _auth = FirebaseAuth.instance;


  Future<User?> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return null;
      }
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      if (googleAuth.accessToken == null || googleAuth.idToken == null) {
        debugPrint('Google Authentication failed: No tokens found');
        return null;
      }
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;
      if (user != null) {
        userEmail.value = googleUser.email;
        userName.value = googleUser.displayName!;
        debugPrint('User email: $userEmail');
        debugPrint('User name: $userName');
        return user;
      } else {
        debugPrint('User not found after Google sign-in');
        return null;
      }
    } catch (e) {
      debugPrint('Google Sign-In Failed: $e');
      return null;
    }
  }


  ///api services instances
  ApiServices apiServices = ApiServices();
  ApiBaseHelper apiBaseHelper = ApiBaseHelper();
  ///api urls
  String get registerUrl => apiServices.register;
  String get socialUrl => apiServices.socialLogin;
  String get languageCode => SharedPref.getLanguageToPrefs();


  /// social login
    Future<void> socialLogin(String? email) async {
      try {
        Utils.showLoader();

        final response = await apiBaseHelper.postAPICall(Uri.parse(socialUrl), {
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

  @override
  void onClose() {

    super.onClose();
  }

  ///handle password visibility
  void togglePasswordVisibility() {
    passwordVisible.value = !passwordVisible.value;
  }
  /// login method on submit
  Future<void> register() async {
    if (nameController.text.isEmpty) {
      Utils.mySnackBar(title:"User Mobile No Not Found",msg: 'Please Enter user mobile no',maxWidth: 270 );
     // Utils.mySnackBar(title: DemoLocalization.of(context)!.translate('User Name Not Found').toString(),msg: 'Please Enter user name',maxWidth: 250 );
    }
    else if (phoneController.text.isEmpty) {
      Utils.mySnackBar(title:"User Mobile No Not Found",msg: 'Please Enter user mobile no',maxWidth: 270 );
    }
    else if (emailController.text.isEmpty) {
      Utils.mySnackBar(title:"User Email Not Found",msg: 'Please Enter user email',maxWidth: 200 );

    } else if (passwordController.text.isEmpty) {
      Utils.mySnackBar(title:"Password Not Found",msg: 'Please Enter Password',maxWidth: 200 );
    } else {
      print("object");
      getRegister();

    }
  }

  /// api request for login
  getRegister() async {
    try {
      Utils.showLoader();

      final response = await apiBaseHelper.postAPICall(Uri.parse(registerUrl),langCode:languageCode.toString() , {
        "email": emailController.text,
        "password": passwordController.text,
        "phone": phoneController.text,
        "name": nameController.text,
      });
      Get.back();
      if (response["status"] == false) {
        Utils.mySnackBar(
          title: "Error Found",
          msg: response["message"],
        );
      } else {
        Utils.mySnackBar(
            msg: "Register Successfully"
        );
        Get.back();
        Get.off(() => const LoginScreen());
        Get.delete<RegistrationController>();
      }
    }finally {
      Future.delayed(const Duration(seconds: 3), () {
        if (Get.isDialogOpen ?? false) {
          Get.back();
        }
      });
    }
  }
 /* getRegister() async {
    Utils.showLoader(); // Show loader before API call

    try {
      var response = await apiBaseHelper.postAPICall(Uri.parse(registerUrl), {
        "email": emailController.text,
        "password": passwordController.text,
        "phone": phoneController.text,
        "name": nameController.text,
      });

      if (response["status"] == false) {
        Utils.mySnackBar(title: "Error Found", msg: response["message"]);
      } else {
        Utils.mySnackBar(title: "Success", msg: 'Register successfully!');
        Get.back();
        Get.off(() => const LoginScreen());
        Get.delete<RegistrationController>();
      }
    } catch (e) {
      Utils.mySnackBar(title: "Error", msg: "Something went wrong, please try again.");
    } finally {
      // Ensure loader is dismissed in all cases

    }
  }*/

/*  /// register user method on Sign up
  Future<void> register() async {
    if(formKey.currentState!.validate()){

    }
  }*/


}

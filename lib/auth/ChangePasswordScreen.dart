import 'dart:convert';
import 'package:fitness/auth/LoginScreen.dart';
import 'package:fitness/custom/CustomWidget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import '../Api Services/api_end_points.dart';
import '../colors.dart';
import '../custom/CustomButton.dart';
import '../custom/CustomContainer.dart';
import '../custom/CustomText.dart';
import '../custom/CustomTextFormField.dart';
import '../custom/Fonts.dart';
import '../custom/ShowSnackbar.dart';
import '../utils/Demo_Localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Changepasswordscreen extends StatefulWidget {
  const Changepasswordscreen({super.key});

  @override
  State<Changepasswordscreen> createState() => _ChangepasswordscreenState();
}

class _ChangepasswordscreenState extends State<Changepasswordscreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerCurrentPassword = TextEditingController();
  final TextEditingController _controllerNewPassword = TextEditingController();
  final TextEditingController _controllerConfirmPassword = TextEditingController();
//  final TextEditingController _controllerPassword = TextEditingController();

  String? mobile;
  int? otp;
  bool isLoading = false;


  // Create the method to handle Google Sign-In
  Future<User?> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        final OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        // Sign in to Firebase
        UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
        final User? user = userCredential.user;
        return user;

        // return userCredential.user;

      }
    } catch (e) {
      print('Google sign-in failed: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Login Failed: $e"),
      ));
    }
    return null;
  }

  void _validateAndSubmit() {
    if (_controllerCurrentPassword.text == "") {
      CustomSnackbar.show(context, "current password");
      return;
    }else if (_controllerNewPassword.text == "") {
      CustomSnackbar.show(context, "new password");
      return;
    }  if (_controllerConfirmPassword.text == "") {
      CustomSnackbar.show(context, "confirm password");
      return;
    }
    else {
      registrationApi();
    }
  }
String? userId;
  Future<void> registrationApi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString("userid");
    setState(() {
      isLoading =  true;
    });

    var headers = {
      'Cookie': 'ci_session=5nbd4rujnmj58327kb67h560njukte8i'
    };
    var request = http.MultipartRequest('POST', Uri.parse("${Endpoints.baseUrl}${Endpoints.changePassword}"));
    request.fields.addAll({
      'current_password':_controllerCurrentPassword.text.toString(),
      'new_password':_controllerNewPassword.text.toString(),
      'new_password_confirmation':_controllerConfirmPassword.text.toString(),
      'user_id':userId.toString(),


    });
    /*name:Rahul Parmar
    email:rahulraj10@gmail.com
    phone:9197654325
    password:123456*/
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult = jsonDecode(result);

      setState(() {
        isLoading =  false;
      });
       if(finalResult['status']== "error"){
      //   CustomSnackbar.show(context, "${finalResult['message']}");
//REGISTRATION FILE
      }else {
      //   otp = finalResult['user'];
        CustomSnackbar.show(context, "${finalResult['status']}");
        Navigator.push(context, MaterialPageRoute(builder: (context) =>
            LoginScreen())).then((value) {
          _controllerCurrentPassword.clear();
          _controllerNewPassword.clear();
          _controllerConfirmPassword.clear();

        });

     /*   Navigator.push(context, MaterialPageRoute(builder: (context) =>
            LoginScreen())).then((value) {
        //  mobileC.clear();
        });*/
        /* Navigator.push(context, MaterialPageRoute(builder: (context) =>
            VerifyOtpScreen(mobile: mobileC.text, otp: otp,))).then((value) {
          mobileC.clear();
        });*/
       }

      setState(() {
        isLoading =  false;
      });
    }
    else {
      setState(() {
        isLoading =  false;
      });
      print(response.reasonPhrase);
    }

  }



  @override
  void dispose() {
    _controllerCurrentPassword.dispose();
    _controllerNewPassword.dispose();
    _controllerConfirmPassword.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
               CustomTextWidget(title:  DemoLocalization.of(context)!.translate('Skip').toString(),/*"Skip"*/fontFamily:Fonts.montserrat,icon: Icons.arrow_back_ios,imageAsset: ""),

                const SizedBox(height: 20),
                CustomText(
                  text: DemoLocalization.of(context)!.translate('CreateAccounts').toString(),// "Create Accounts",
                  fontSize: 8.0,
                  color: FitnessColor.colorTextFour,
                  fontWeight: FontWeight.bold,
                  fontFamily: Fonts.roboto,
                ),

                const SizedBox(height: 10),
                CustomText(
                  text: DemoLocalization.of(context)!.translate('Pleaseenteryourcredentialstoproceed').toString(),//"Please enter your credentials to \nproceed",
                  fontSize: 4,
                  color: FitnessColor.colorTextPrimary,
                  fontWeight: FontWeight.bold,
                  fontFamily:Fonts.dmsans// Fonts.roboto,
                ),
                const SizedBox(height: 20),
                CustomText(
                  text: DemoLocalization.of(context)!.translate('Current Password').toString(),//"Full Name",
                  fontSize: 4,
                  color: FitnessColor.colorTextPrimary,
                  fontWeight: FontWeight.bold,
                  fontFamily: Fonts.montserrat,
                ),
                const SizedBox(height: 5),
                CustomTextFormField(
                  // labelText: 'Email',
                  hintText: DemoLocalization.of(context)!.translate('Enter Current Password').toString(),//'Enter full name',
                  keyboardType: TextInputType.text,
                  controller: _controllerCurrentPassword,
                  // icon: "Icons.email",
                  secondaryIcon: Icons.check,
                  onChanged: (value) {
                    print('name: $value');
                  },

                ),
                const SizedBox(height: 10),


                CustomText(
                  text: DemoLocalization.of(context)!.translate('New Password').toString(),//"Phone",
                  fontSize: 4,
                  color: FitnessColor.colorTextPrimary,
                  fontWeight: FontWeight.bold,
                  fontFamily: Fonts.montserrat,
                ),
                const SizedBox(height: 5),
                CustomTextFormField(
                  // labelText: 'Email',
                  hintText: DemoLocalization.of(context)!.translate('Enter New Password').toString(),//'Enter phone number',
                  //maxLength: 10,
                  keyboardType: TextInputType.text,
                  controller: _controllerNewPassword,
                  // icon: "Icons.email",
                //  secondaryIcon: Icons.check,
                  onChanged: (value) {
                    print('phone: $value');
                  },

                ),
                const SizedBox(height: 10),
                CustomText(
                  text:DemoLocalization.of(context)!.translate('Confirm Password').toString(),// "Email address",
                  fontSize: 4,
                  color: FitnessColor.colorTextPrimary,
                  fontWeight: FontWeight.bold,
                  fontFamily: Fonts.montserrat,
                ),
                const SizedBox(height: 5),
                CustomTextFormField(
                 // labelText: 'Email',
                  hintText: DemoLocalization.of(context)!.translate('Enter Confirm Password').toString(),//'Enter your email',
                  keyboardType: TextInputType.text,
                  controller: _controllerConfirmPassword,
                  // icon: "Icons.email",
                //  secondaryIcon: Icons.check,
                  onChanged: (value) {
                    print('Email: $value');
                  },

                ),
                const SizedBox(height: 10),

              /*  Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.centerRight,
                  child:  CustomText(
                    text: "Forgot Password?",
                    fontSize: 4,
                    color: FitnessColor.colorTextThird,
                    fontWeight: FontWeight.bold,
                    fontFamily:Fonts.roboto,
                  ),
                ),*/
                const SizedBox(height: 18),

                // SizedBox(height: 8),
                Center(
                  child: isLoading
                      ? const Center(child: SizedBox(
                      width: 25,
                      height: 25,
                      child: CircularProgressIndicator(color: FitnessColor.primaryLite)))
                      : CustomButton(
                    text: DemoLocalization.of(context)!.translate('Submit').toString(),//'Create Account',
                    fontFamily:Fonts.roboto,
                    fontSize: 22,
                    color: FitnessColor.colorTextThird,
                    onPressed: _validateAndSubmit,
                  ),
                ),
                const SizedBox(height: 18),

                const SizedBox(height: 5),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
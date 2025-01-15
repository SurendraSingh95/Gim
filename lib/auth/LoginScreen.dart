import 'dart:convert';
import 'dart:io';
import 'package:fitness/Controllers/Auth%20Controllers/login_controller.dart';
import 'package:fitness/Screens/home_screen.dart';
import 'package:fitness/auth/Forgot/ForgetPassScreen.dart';
import 'package:fitness/auth/RegistrationScreen.dart';
import 'package:fitness/auth/settings_page.dart';
import 'package:fitness/bottomdrawer/homeScreen.dart';
import 'package:fitness/constants/constants.dart';
import 'package:fitness/custom/CustomWidget.dart';
import 'package:fitness/notification_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
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
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginController loginController = Get.put(LoginController());

  /* double h = Constants.largeSize;
  double w = Constants.screen.width;*/

  String? userName, userEmail;
  int? userId;


 // final GoogleSignIn _googleSignIn = GoogleSignIn(serverClientId:"1065267522684-741mgeun47i1j099oub7edv8k90osbk4.apps.googleusercontent.com",scopes: ['email']);
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<User?> signInWithGoogle(BuildContext context) async {
    debugPrint('.....1....');
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      debugPrint('.....2....');
      if (googleUser == null) {
        debugPrint('.....3....');
        return null;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      debugPrint('.....4....');
      if (googleAuth.accessToken == null || googleAuth.idToken == null) {
        debugPrint('.....5....');
        debugPrint('Google Authentication failed: No tokens found');
        return null;
      }

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      debugPrint('.....6....');
      final User? user = userCredential.user;

      if (user != null) {
        debugPrint('.....7....');
        userEmail = googleUser.email;
        userName = googleUser.displayName;

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



  @override
  void initState() {
    super.initState();
    LocalNotificationService();
    getCountryCode();
  }
  String? languageCode;
  getCountryCode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    languageCode = prefs.getString("languageCode");
    print("this s skms $languageCode");
  }

  String? mobile;
  int? otp;
  bool isLoading = false;

  Future<void> getStavaAuthLogin() async {
    setState(() {
      isLoading = true;
    });
    var headers = {
      'Cookie':
          'XSRF-TOKEN=eyJpdiI6ImlDeGN2NytIaWlaNjk5ZU5qa212M2c9PSIsInZhbHVlIjoiaTVhMlNsdy9CdzZnK0NBVkFoNWtvQVVMYUVYKzJoWWtFV0s5NE5GeTlTbUlpSm11U0EwbEVrMWtPMVRVczlMTFl3bXBmMVUzTmd6S2tmTFpseHg2aG9jdG1TUGlIUjRjZ1NBNW9FSU1yQW1EdVVhTmxKZ0hNQzkvN0Y0NGxtdFYiLCJtYWMiOiI5ZGEwMTJjOTlhODMyN2ZhMzYwMTI5MjdmMTlmNmQ2MjJlYTY0MDM2MTE3ZWMxZDY3NDc1YTMwZTMzZmE5MjExIiwidGFnIjoiIn0%3D; laravel_session=eyJpdiI6IjRZVjc0enlqclVTQ3BVN2pOSjQyVkE9PSIsInZhbHVlIjoibVlpczdHc09BUzhTTSttUVluTncreFd4UGdDQUhSQ0N3dXFmMVdzdEN1R210cEh6aUtoVm81T0tvUmZVaWdPODFzckFpeWZCUFBnbkhZakh2dVZFZ1VncUtNWEFOa3hId0dDcytPZEI5TWJuRlM5UGppQzlTbnBtMkhKN3dpNDYiLCJtYWMiOiIzNDZmMTE4Mjk5YTU0NTIwY2Q4MTAxYzE1YTg1NzRhYzYyMTdlY2I5NTk0ZTA2ODNiNzAwMTQ5NjA4N2ZjOGVjIiwidGFnIjoiIn0%3D'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            '${Endpoints.baseUrl}auth/strava?client_id=133232&redirect_uri=http://tfbfitness.com&response_type=code&scope=read,activity:read'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      var result = await response.stream.bytesToString();
      var finalResult = jsonDecode(result);
      CustomSnackbar.show(context, "${finalResult['message']}");
    } else {
      setState(() {
        isLoading = false;
      });
      print(response.reasonPhrase);
    }
  }

  Future<void> getStavaTokenLogin() async {
    setState(() {
      isLoading = true;
    });
    var headers = {
      'Cookie': '_strava4_session=s941ub560974bdkh4balvr4l5ormkd4l'
    };
    var request = http.Request(
        'POST',
        Uri.parse(
            '${Endpoints.baseUrlStava}oauth/token?client_id=133232&client_secret=5f9015580cfa5567aa2f68b13167b86300d37f75&code=58782651ffdcefd8ad8b65341a9a001ce0c10fb0&grant_type=authorization_code'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }


  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: const Row(
              children: [
                Icon(
                  Icons.exit_to_app,
                  color: Colors.redAccent,
                ),
                SizedBox(width: 10),
                Text(
                  'Exit App',
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            content: const Text(
              'Are you sure you want to exit the app?',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 16,
              ),
            ),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.grey[200],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () => Navigator.of(context).pop(false),
                // Dismiss dialog
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    color: Colors.grey[800],
                  ),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () => exit(0),
                child: const Text(
                  'Exit',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Get.theme.brightness == Brightness.dark;

    return PopScope(
     /* canPop: false,
      onPopInvoked: (val) async {
        _onWillPop();
      },*/
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                InkWell(
                  onTap: () {
                    Get.to(()=>const SettingsPage());

                  },
                  child: CustomTextWidget(
                      title: DemoLocalization.of(context)!
                          .translate('Language')
                          .toString(),
                      fontFamily: Fonts.arial,
                     // icon: Icons.arrow_back_ios,
                      ),
                ),
                const SizedBox(height: 20),
                CustomText(
                  text: DemoLocalization.of(context)!
                      .translate('WelcometoProFitness')
                      .toString(),
                  fontSize: 8.0,
                  color: FitnessColor.colorTextFour,
                  fontWeight: FontWeight.bold,
                  fontFamily: Fonts.arial,
                ),

                const SizedBox(height: 10),
                CustomText(
                    text: DemoLocalization.of(context)!
                        .translate('HellothereSignintocontinue')
                        .toString(),
                    //"Hello there, sign in to \ncontinue!",
                    fontSize: 4,
                    color: FitnessColor.colorTextPrimary,
                    fontWeight: FontWeight.bold,
                    fontFamily: Fonts.arial //Fonts.arial,
                    ),
                const SizedBox(height: 20),
                CustomText(
                  text: DemoLocalization.of(context)!
                      .translate('Emailaddress')
                      .toString(),
                  // "Email address",
                  fontSize: 4,
                  color: FitnessColor.colorTextPrimary,
                  fontWeight: FontWeight.bold,
                  fontFamily: Fonts.arial,
                ),
                const SizedBox(height: 5),
                CustomTextFormField(
                  // labelText: 'Email',
                  hintText: DemoLocalization.of(context)!
                      .translate('Enteryouremail')
                      .toString(),
                  //'Enter your email',
                  keyboardType: TextInputType.emailAddress,
                  controller: loginController.emailController,
                  // icon: "Icons.email",
                  secondaryIcon: Icons.check,
                  onChanged: (value) {
                    print('Email: $value');
                  },
                ),
                const SizedBox(height: 10),
                CustomText(
                  text: DemoLocalization.of(context)!
                      .translate('Password')
                      .toString(),
                  //"",
                  fontSize: 4,
                  color: FitnessColor.colorTextPrimary,
                  fontWeight: FontWeight.bold,
                  fontFamily: Fonts.arial,
                ),
                const SizedBox(height: 5),
                CustomTextFormField(
                  hintText: DemoLocalization.of(context)!
                      .translate('Enteryourpassword')
                      .toString(),
                  //'Enter your password',
                  controller: loginController.passwordController,
                  // icon: Icons.lock,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  onChanged: (value) {
                    print('Password: $value');
                  },
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    Get.to(()=>const ForgetPassScreen());
                   /* Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ForgetPassScreen()));*/
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomText1(
                        text: DemoLocalization.of(context)!
                            .translate('ForgotPassword')
                            .toString(),

                        //"Forgot Password?",
                        fontSize: 4,
                        color: FitnessColor.colorTextThird,
                        fontWeight: FontWeight.bold,
                        fontFamily: Fonts.arial,
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                Center(child: Obx(() {
                  return !loginController.isLoading.value
                      ? CustomButton(
                          text: DemoLocalization.of(context)!
                              .translate('Login')
                              .toString(),
                          fontFamily: Fonts.arial,
                          fontSize: 22,
                          color: FitnessColor.colorTextThird,
                          onPressed: () {
                            loginController.login(context);
                          },
                        )
                      : const CircularProgressIndicator();
                })),
                const SizedBox(height: 18),
                Center(
                  child: CustomText1(
                    text: DemoLocalization.of(context)!
                        .translate('OrLoginwith')
                        .toString(),
                    //"Or Login with",
                    fontSize: 3.5,
                    color: FitnessColor.colorTextThird,
                    fontWeight: FontWeight.normal,
                    fontFamily: Fonts.arial,
                  ),
                ),
                const SizedBox(height: 18),
                GestureDetector(
                  // onTap: () async {

                  onTap: () async {
                    User? user = await signInWithGoogle(context);
                    if (user != null) {
                      loginController.socialLogin(userEmail);
                     /* Get.to(()=> HomeScreen(userName:userName,userEmail: userEmail ,))?.then(){

                      };*/

                      // Navigate to the home screen after a successful login
                     /* Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyHomePage(
                                  title: '',
                                )),
                      );*/
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Google Sign-In Failed')),
                      );
                    }
                  },
                  child: CustomContainer(
                      imageAsset: "assets/images/googlecon.png",
                      text: DemoLocalization.of(context)!
                          .translate('ConnectWithGoogle')
                          .toString(),
                      //"Connect with Google",
                      fontFamily: Fonts.arial,
                      borderColor: FitnessColor.primaryLite,
                      fillColor:  FitnessColor.primaryLite.withOpacity(0.15),
                      textColor: isDarkMode? FitnessColor.white: FitnessColor.colorsociallogintext),
                ),
                const SizedBox(height: 15),
                CustomContainer(
                  imageAsset: "assets/images/facebookicon.png",
                  text: DemoLocalization.of(context)!
                      .translate('ConnectwithFacebook')
                      .toString(),
                  //"Connect With Facebook",
                  fontFamily: Fonts.arial,
                  borderColor: FitnessColor.colorButton,
                  fillColor: FitnessColor.colorButton,
                  textColor: FitnessColor.colorBg1,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 14,
                ),
                Container(
                  //color:FitnessColor.colorfillBOx,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  alignment: Alignment.center,
                  child: RichText(
                    text: TextSpan(
                      text: DemoLocalization.of(context)!
                          .translate('DonthaveanaccountRegister')
                          .toString(),
                      //"Don't have an account? ",
                      style: const TextStyle(
                        fontFamily: Fonts.arial,
                        color: FitnessColor.colorfillText,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: DemoLocalization.of(context)!
                              .translate('Register')
                              .toString(), //"Register!",
                          style: const TextStyle(
                            fontFamily: Fonts.arial,
                            color: FitnessColor.colorTextThird,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              //Navigator.push(context, MaterialPageRoute(builder: (context)=> RegistrationScreen()));

                              Get.to(() => const RegistrationScreen());
                              /*  Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const RegistrationScreen()));*/
                              // Navigate to registration screen
                            },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 5),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

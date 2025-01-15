import 'dart:convert';

import 'package:fitness/Controllers/Auth%20Controllers/login_controller.dart';
import 'package:fitness/custom/CustomWidget.dart';
import 'package:flutter/material.dart';
import '../../Api Services/api_end_points.dart';
import '../../colors.dart';
import '../../custom/CustomButton.dart';
import '../../custom/CustomText.dart';
import '../../custom/CustomTextFormField.dart';
import '../../custom/Fonts.dart';
import '../../custom/ShowSnackbar.dart';
import '../../utils/Demo_Localization.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class ForgetPassScreen extends StatefulWidget {
  const ForgetPassScreen({super.key});

  @override
  State<ForgetPassScreen> createState() => _ForgetPassScreenState();
}

class _ForgetPassScreenState extends State<ForgetPassScreen> {



  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerEmail = TextEditingController();
  LoginController loginController = Get.put(LoginController());


  bool isLoading = false;
  Future<void> updateProfileApi() async {
    //userId = prefs.getString("userid");
    setState(() {
      isLoading = true;
    });

    var request = http.MultipartRequest(
        'POST', Uri.parse("${Endpoints.baseUrl}${Endpoints.sendOTP}"));
    request.fields.addAll({
      'email': _controllerEmail.text,

    });

    /*if (_image != null) {
      request.files
          .add(await http.MultipartFile.fromPath('image', _image?.path ?? ""));
    }*/

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult = jsonDecode(result);
      if (finalResult['error'] == true) {
        CustomSnackbar.show(context, "${finalResult['message']}");
      } else {
        CustomSnackbar.show(context, "${finalResult['message']}");

        //getProfileApi();
        // Navigator.push(context,
        //     MaterialPageRoute(builder: (context) => const Deshboard()));
      }
      setState(() {
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      print(response.reasonPhrase);
    }
  }

  @override
  void dispose() {
    _controllerEmail.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(

      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 25),
                CustomTextWidget(
                  title: DemoLocalization.of(context)!.translate('Skip').toString(),  // Localized title
                  fontFamily: Fonts.arial,
                  icon: Icons.arrow_back_ios,
                  imageAsset: "",
                  onTap: () {
                    Get.back();
                  },
                ),

             //   CustomTextWidget(title: DemoLocalization.of(context)!.translate('Skip').toString(),fontFamily: Fonts.arial,icon: Icons.arrow_back_ios,imageAsset: ""),

                const SizedBox(height: 20),
                CustomText(
                  text:  DemoLocalization.of(context)!.translate('ForgotPassword').toString(),//"Forgot Password",
                  fontSize: 8.0,
                  color: FitnessColor.colorTextFour,
                  fontWeight: FontWeight.bold,
                  fontFamily: Fonts.arial,
                ),

                const SizedBox(height: 10),
                CustomText(
                  text: DemoLocalization.of(context)!.translate('Pleaseenteryourcredentialstoproceed').toString(),//"Please enter your email below to receive your password reset code.",
                  fontSize: 4,
                  color: FitnessColor.colorTextPrimary,
                  fontWeight: FontWeight.normal,
                  fontFamily: Fonts.arial,
                ),
                SizedBox(height: screenSize.height/9),
                CustomText(
                  text: DemoLocalization.of(context)!.translate('Emailaddress').toString(),//"Email",
                  fontSize: 4,
                  color: FitnessColor.colorTextPrimary,
                  fontWeight: FontWeight.bold,
                  fontFamily: Fonts.arial,
                ),
                const SizedBox(height: 5),
                CustomTextFormField(
                 // labelText: 'Email',
                  hintText: DemoLocalization.of(context)!.translate('Enteryouremail').toString(),//'Enter your email',

                  controller: loginController.forgetPassEmailController,
                  // icon: "Icons.email",
                  secondaryIcon: Icons.check,
                  onChanged: (value) {
                    print('Email: $value');
                  },
                ),
                SizedBox(height: screenSize.height/8),
                Center(
                  child: CustomButton(
                    text:  DemoLocalization.of(context)!.translate('ResetPassword').toString(),//'Reset Password',
                    fontFamily:Fonts.arial,
                    fontSize: 22,
                    color: FitnessColor.colorTextThird,
                    onPressed: (){
                      loginController.verifyForgotEmail(context);
                    }
                    //_validateAndSubmit,
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
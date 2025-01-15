import 'package:fitness/Controllers/Auth%20Controllers/registration_controller.dart';
import 'package:fitness/auth/LoginScreen.dart';
import 'package:fitness/custom/CustomWidget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../colors.dart';
import '../custom/CustomButton.dart';
import '../custom/CustomContainer.dart';
import '../custom/CustomText.dart';
import '../custom/CustomTextFormField.dart';
import '../custom/Fonts.dart';
import '../utils/Demo_Localization.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';


class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  RegistrationController registrationController = Get.put(RegistrationController());



  PhoneNumber number = PhoneNumber(isoCode: 'KW');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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

           // CustomTextWidget(title:  DemoLocalization.of(context)!.translate('Skip').toString(),/*"Skip"*/fontFamily:Fonts.arial,icon: Icons.arrow_back_ios,imageAsset: "",),

              const SizedBox(height: 20),
              CustomText(
                text: DemoLocalization.of(context)!.translate('CreateAccounts').toString(),// "Create Accounts",
                fontSize: 8.0,
                color: FitnessColor.colorTextFour,
                fontWeight: FontWeight.bold,
                fontFamily: Fonts.arial,
              ),

              const SizedBox(height: 10),
              CustomText(
                text: DemoLocalization.of(context)!.translate('Pleaseenteryourcredentialstoproceed').toString(),//"Please enter your credentials to \nproceed",
                fontSize: 4,
                color: FitnessColor.colorTextPrimary,
                fontWeight: FontWeight.bold,
                fontFamily:Fonts.arial// Fonts.arial,
              ),
              const SizedBox(height: 20),
              CustomText(
                text: DemoLocalization.of(context)!.translate('FullName').toString(),//"Full Name",
                fontSize: 4,
                color: FitnessColor.colorTextPrimary,
                fontWeight: FontWeight.bold,
                fontFamily: Fonts.arial,
              ),
              const SizedBox(height: 5),
              CustomTextFormField(
                // labelText: 'Email',
                hintText: DemoLocalization.of(context)!.translate('Enterfullname').toString(),//'Enter full name',
                keyboardType: TextInputType.text,
                controller: registrationController.nameController,
                // icon: "Icons.email",
                secondaryIcon: Icons.check,
                onChanged: (value) {
                  print('name: $value');
                },

              ),
              const SizedBox(height: 10),


              CustomText(
                text: DemoLocalization.of(context)!.translate('Phone').toString(),//"Phone",
                fontSize: 4,
                color: FitnessColor.colorTextPrimary,
                fontWeight: FontWeight.bold,
                fontFamily: Fonts.arial,
              ),
              const SizedBox(height: 5),
              /*CustomTextFormField(
                // labelText: 'Email',
                hintText: DemoLocalization.of(context)!.translate('Enterphonenumber').toString(),//'Enter phone number',
                keyboardType: TextInputType.number,
                controller: registrationController.phoneController,

                onChanged: (value) {
                  print('phone: $value');
                },

              ),
              const SizedBox(height: 5),*/
              Container(
                height: 55,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.withOpacity(0.3),
                ),
                child: InternationalPhoneNumberInput(
                  cursorColor: Colors.grey,
                  onInputChanged: (PhoneNumber number) {
                    setState(() {
                      this.number = number;
                    });
                  },
                  onInputValidated: (bool value) {
                    print(value ? 'Valid' : 'Invalid');
                  },
                  selectorConfig: const SelectorConfig(
                    selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                    showFlags: true,
                    useEmoji: true,
                  ),
                  inputDecoration: InputDecoration(
                    hintText: DemoLocalization.of(context)!.translate('Enterphonenumber').toString(),
                    border: InputBorder.none,
                    counterText: "",
                    contentPadding: const EdgeInsets.symmetric(vertical: 14),
                    alignLabelWithHint: true,
                  ),
                  initialValue: number,
                  textFieldController: registrationController.phoneController,
                  formatInput: false,
                ),
              ),



              const SizedBox(height: 10),
              CustomText(
                text:DemoLocalization.of(context)!.translate('Emailaddress').toString(),
                fontSize: 4,
                color: FitnessColor.colorTextPrimary,
                fontWeight: FontWeight.bold,
                fontFamily: Fonts.arial,
              ),
              const SizedBox(height: 5),
              CustomTextFormField(
               // labelText: 'Email',
                hintText: DemoLocalization.of(context)!.translate('Enteryouremail').toString(),//'Enter your email',
                keyboardType: TextInputType.emailAddress,
                controller: registrationController.emailController,
                // icon: "Icons.email",
              //  secondaryIcon: Icons.check,
                onChanged: (value) {
                  print('Email: $value');
                },

              ),
              const SizedBox(height: 10),
              CustomText(
                text: DemoLocalization.of(context)!.translate('Password').toString(),//"Password",
                fontSize: 4,
                color: FitnessColor.colorTextPrimary,
                fontWeight: FontWeight.bold,
                fontFamily: Fonts.arial,
              ),
              const SizedBox(height: 5),
              CustomTextFormField(
              //  labelText: '',
                hintText: DemoLocalization.of(context)!.translate('Enteryourpassword').toString(),//'Enter your password',
                controller: registrationController.passwordController,
                // icon: Icons.lock,
                obscureText: true,
                onChanged: (value) {
                  print('Password: $value');
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
                  fontFamily:Fonts.arial,
                ),
              ),*/
              const SizedBox(height: 18),

              // SizedBox(height: 8),
              Center(
                child: Obx(() {
                    return !registrationController.isLoading.value ?
                      CustomButton(
                      text: DemoLocalization.of(context)!.translate('CreateAccount').toString(),//'Create Account',
                      fontFamily:Fonts.arial,
                      fontSize: 22,
                      color: FitnessColor.colorTextThird,
                      onPressed: (){
                        print("object");
                        registrationController.register();
                      },
                    ):const CircularProgressIndicator(color: FitnessColor.primary,);
                  }
                ),
              ),
              const SizedBox(height: 18),
              Center(
                child: CustomText1(
                  text: DemoLocalization.of(context)!.translate('OrRegisterwith').toString(),// "Or Register with",
                  fontSize: 3.5,
                  color: FitnessColor.colorTextThird,
                  fontWeight: FontWeight.normal,
                  fontFamily: Fonts.arial,
                ),
              ),
              const SizedBox(height: 18),
              GestureDetector(
                onTap: () async {
                  User? user = await registrationController. signInWithGoogle(context);
                  if (user != null) {
                    registrationController.socialLogin(registrationController.userEmail.value);
                   /* Get.to(()=> HomeScreen(userName:registrationController.userName.value,userEmail: registrationController.userEmail.value ,));*/

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
                  text: DemoLocalization.of(context)!.translate('ConnectWithGoogle').toString(),//"Connect with Google",
                  fontFamily: Fonts.arial,
                  borderColor: FitnessColor.primaryLite,
                  fillColor:FitnessColor.primaryLite.withOpacity(0.15),
                  textColor: FitnessColor.colorsociallogintext,
                ),
              ),
              const SizedBox(height: 15),
              CustomContainer(imageAsset:"assets/images/facebookicon.png",
                text: DemoLocalization.of(context)!.translate('ConnectwithFacebook').toString(),// "Connect With Facebook",
                fontFamily: Fonts.arial,
                borderColor: FitnessColor.colorButton,
                fillColor: FitnessColor.colorButton,
                textColor: FitnessColor.colorfillBOx),

              // SizedBox(height: 10),
              SizedBox(height: MediaQuery.of(context).size.height/14,),
              // SizedBox(height: 70,),
              Container(
                //color:FitnessColor.colorfillBOx,
                padding: const EdgeInsets.symmetric(vertical: 15),
                 alignment: Alignment.center,
                child: RichText(
                  text: TextSpan(
                    text: DemoLocalization.of(context)!.translate('AlreadyhaveanaccountLogin').toString(),//"Already have an account? ",
                    style: const TextStyle(
                      fontFamily: Fonts.arial,
                      color: FitnessColor.colorfillText,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: DemoLocalization.of(context)!.translate('Logintext').toString(),//"Login!",
                        style: const TextStyle(
                          fontFamily: Fonts.arial,
                          color: FitnessColor.colorTextThird,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context) => LoginScreen()));
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
    );
  }
}
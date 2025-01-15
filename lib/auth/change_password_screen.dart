import 'package:fitness/Controllers/Auth%20Controllers/reset_password_controller.dart';
import 'package:fitness/auth/LoginScreen.dart';
import 'package:fitness/constants/constants.dart';
import 'package:fitness/constants/responsive.dart';
import 'package:fitness/custom/CstAppbarWithtextimage.dart';
import 'package:fitness/custom/CustomButton.dart';

import 'package:flutter/material.dart';
import '../colors.dart';
import '../custom/CustomText.dart';
import '../custom/CustomTextFormField.dart';
import '../custom/Fonts.dart';
import '../utils/Demo_Localization.dart';
import 'package:get/get.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {

  ResetPasswordController resetPasswordController = Get.put(ResetPasswordController());
  double h = Constants.largeSize;
  double w = Constants.screen.width;
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
              CstAppbarWithtextimage(
                  title:DemoLocalization.of(context)!.translate('Change_Password').toString(),
                  icon: Icons.arrow_back_ios,
                  fontFamily: Fonts.arial,
                  onImageTap: (){
                    Get.back();
                  }
              ),

              const SizedBox(height: 30),

              CustomText(
                text: DemoLocalization.of(context)!.translate('Current_Password').toString(),//"Full Name",
                fontSize: 4,
                color: FitnessColor.colorTextPrimary,
                fontWeight: FontWeight.bold,
                fontFamily: Fonts.arial,
              ),
              const SizedBox(height: 5),

              CustomTextFormField(
                hintText: DemoLocalization.of(context)!.translate('Enter_Current_Password').toString(),//'Enter full name',
                keyboardType: TextInputType.text,
                  controller: resetPasswordController.oldPasswordController,
                  obscureText:true,

                onChanged: (value) {
                  print('name: $value');
                },

              ),
              const SizedBox(height: 10),


              CustomText(
                text: DemoLocalization.of(context)!.translate('New_Password').toString(),//"Phone",
                fontSize: 4,
                color: FitnessColor.colorTextPrimary,
                fontWeight: FontWeight.bold,
                fontFamily: Fonts.arial,
              ),
              const SizedBox(height: 5),
              CustomTextFormField(
                hintText: DemoLocalization.of(context)!.translate('Enter_New_Password').toString(),//'Enter phone number',
                keyboardType: TextInputType.text,
                controller: resetPasswordController.newPasswordController,
                obscureText: true,
                onChanged: (value) {

                },

              ),
              const SizedBox(height: 10),
              CustomText(
                text:DemoLocalization.of(context)!.translate('Confirm_Password').toString(),// "Email address",
                fontSize: 4,
                color: FitnessColor.colorTextPrimary,
                fontWeight: FontWeight.bold,
                fontFamily: Fonts.arial,
              ),
              const SizedBox(height: 5),
              CustomTextFormField(
                hintText: DemoLocalization.of(context)!.translate('Enter_Confirm_Password').toString(),//'Enter your email',
                keyboardType: TextInputType.text,
                controller: resetPasswordController.confirmPasswordController,
                obscureText: true,
                onChanged: (value) {
                },

              ),
              const SizedBox(height: 10),

              const SizedBox(height: 18),

              Obx(
                 () {
                  return Center(
                    child: !resetPasswordController.isLoading.value
                        ?  CustomButton(
                      text: DemoLocalization.of(context)!.translate('Submit').toString(),
                      fontFamily:Fonts.arial,
                      fontSize: 22,
                      color: FitnessColor.colorTextThird,
                      onPressed:(){
                        resetPasswordController.changePassword().then((v) {
                          if (v) {
                            showChangePasswordSuccessBottomSheet();
                          }
                        });
                      }
                    ):const CircularProgressIndicator()
                  );
                }
              ),
              const SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }
  ///show on password change successfully
  void showChangePasswordSuccessBottomSheet(){
    Get.bottomSheet(
        Responsive(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 12,bottom: 20),
            decoration: const BoxDecoration(
                color: FitnessColor.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32), topRight: Radius.circular(32))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 4,
                  width: 50,
                  decoration: BoxDecoration(
                      color: FitnessColor.white,
                      borderRadius: BorderRadius.circular(10)),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/successImage.png",height: h*0.25,),
                    SizedBox(
                      height: h * 0.03,
                    ),
                     CustomText(
                        text: "Password Changed",
                        fontSize: 7,
                        color: FitnessColor.primary,
                        fontWeight: FontWeight.bold),
                    SizedBox(
                      height: h * 0.01,
                    ),
                     CustomText(
                      text: "Password change successfully, you can login again with new password",
                      fontSize: 4.1,
                      color:FitnessColor.primary,
                      fontWeight: FontWeight.normal,
                      textAlign: TextAlign.center,

                    ),
                    SizedBox(
                      height: h * 0.03,
                    ),
                    CustomButton(
                      text: 'Go to Login',
                      onPressed: () {
                        Get.offAll(() => const LoginScreen());
                        Get.delete<ResetPasswordController>();
                      }, fontFamily: Fonts.arial,
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
    );
  }
}
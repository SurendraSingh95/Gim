

import 'package:fitness/Controllers/Auth%20Controllers/reset_password_controller.dart';
import 'package:fitness/colors.dart';
import 'package:fitness/constants/constants.dart';
import 'package:fitness/custom/CustomButton.dart';
import 'package:fitness/custom/CustomTextFormField.dart';
import 'package:fitness/custom/CustomWidget.dart';
import 'package:fitness/utils/Demo_Localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../custom/CustomText.dart';
import '../../../custom/Fonts.dart';

class ResetPasswordScreen extends StatefulWidget {
  bool isFalse = false;
  String? otp,email;
   ResetPasswordScreen({super.key,required this.isFalse,this.otp,this.email});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {

  ResetPasswordController resetPasswordController = Get.put(ResetPasswordController());

  double h = Constants.largeSize;
  double w = Constants.screen.width;


  @override
  initState() {
    super.initState();
  }

  @override
  void dispose() {
   /* resetPasswordController.newPasswordController.clear();
    resetPasswordController.oldPasswordController.clear();
    resetPasswordController.confirmPasswordController.clear();*/
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.otp,);
    print("rrrrrr${widget.email}",);
    return Scaffold(

      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: w*0.05, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 25,),
              CustomTextWidget(
                title: DemoLocalization.of(context)!.translate('Skip').toString(),  // Localized title
                fontFamily: Fonts.arial,
                icon: Icons.arrow_back_ios,
                imageAsset: "",
                onTap: () {
                  Get.back();
                },
              ),
              const SizedBox(height: 25,),

              CustomText(
                  text:widget.isFalse? "Reset Password": "Change Password",
                  fontSize: 10,
                  color: FitnessColor.primary,
                  fontWeight: FontWeight.bold),
              SizedBox(
                height: h * 0.01,
              ),
               CustomText(
                  text: "Your new password must be different from your previously used password",
                  fontSize: 4.0,
                  color:FitnessColor.primary,
                  fontWeight: FontWeight.normal),
              SizedBox(
                height: h * 0.03,
              ),
              widget.isFalse ? SizedBox(): CustomText(
                text: "Old Password",
                fontSize: 4,
                color: FitnessColor.primary,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: h * 0.01,
              ),
              widget.isFalse ? SizedBox():  Obx(() {
                return CustomTextFormField(

                    hintText: "Enter old password",
                    controller: resetPasswordController.oldPasswordController,
                    obscureText: !resetPasswordController.oldPasswordVisible.value, onChanged: (String value) {  },
                   /* suffixIcon:
                    InkWell(
                        onTap: (){
                          resetPasswordController.toggleOldPasswordVisibility();
                        },
                        child: resetPasswordController.oldPasswordVisible.value?
                        const Icon(Icons.visibility):const Icon(Icons.visibility_off)), onChanged: (String value) {  },*/
                );
              }
              ),
              SizedBox(
                height: h * 0.01,
              ),
               CustomText(
                text: "New Password",
                fontSize: 4,
                color: FitnessColor.primary,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: h * 0.01,
              ),
              Obx(() {
                return CustomTextFormField(

                  hintText: "Enter new password",
                  controller: resetPasswordController.newPasswordController,
                  obscureText: !resetPasswordController.newPasswordVisible.value, onChanged: (String value) {  },
                 /* suffixIcon:
                  InkWell(
                      onTap: (){
                        resetPasswordController.togglePasswordVisibility();
                      },
                      child: resetPasswordController.newPasswordVisible.value?
                      const Icon(Icons.visibility):const Icon(Icons.visibility_off))*/
                );
              }
              ),
              SizedBox(
                height: h * 0.01,
              ),
               CustomText(
                  text: "Must be at least 8 characters",
                  fontSize: 4,
                  color: FitnessColor.primary,
                  fontWeight: FontWeight.normal),
              SizedBox(
                height: h * 0.02,
              ),
               CustomText(
                  text: "Confirm Password",
                  fontSize: 4,
                  color: FitnessColor.primary,
                  fontWeight: FontWeight.bold),
              SizedBox(
                height: h * 0.01,
              ),
              Obx(() {
                return CustomTextFormField(

                  hintText: "Confirm password",
                  controller: resetPasswordController.confirmPasswordController,
                  obscureText: !resetPasswordController.confirmPasswordVisible.value,
                  /*suffixIcon:
                  InkWell(
                      onTap: (){
                        resetPasswordController.toggleConfirmPasswordVisibility();
                      },
                      child: resetPasswordController.confirmPasswordVisible.value?
                      const Icon(Icons.visibility):const Icon(Icons.visibility_off)),*/
                  onChanged: (String value) {  },
                );
              }
              ),
              SizedBox(
                height: h * 0.01,
              ),
               CustomText(
                  text: "Both passwords must match",
                  fontSize: 4,
                  color: FitnessColor.primary,
                  fontWeight: FontWeight.normal),
              SizedBox(
                height: h * 0.1,
              ),
              Center(
                  child: Obx(
                          () {
                        return !resetPasswordController.isLoading.value
                            ? CustomButton(
                          text: "Reset Password",
                          fontFamily: Fonts.arial,
                          fontSize: 22,
                          color: FitnessColor.colorTextThird,
                          onPressed: (){
                            resetPasswordController.resetPassword(widget.email,widget.otp);
                          },
                        ):const CircularProgressIndicator();
                      }
                  )
              ),

            ],
          ),
        ),
      ),
    );
  }




}

// Flutter imports:

import 'package:fitness/Api%20Services1/api_helper_methods.dart';
import 'package:fitness/Api%20Services1/api_services.dart';
import 'package:fitness/Utils/utils.dart';
import 'package:fitness/auth/LoginScreen.dart';
import 'package:fitness/utils/shared_preferences.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:


class ResetPasswordController extends GetxController {
  var oldPasswordVisible = false.obs;
  var newPasswordVisible = false.obs;
  var confirmPasswordVisible = false.obs;
  var isLoading = false.obs;
  final formKey = GlobalKey<FormState>();
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  /// get user id
  final String _userId = SharedPref.getUserId();
   String get userId => _userId;
  String get languageCode => SharedPref.getLanguageToPrefs();

  ///on controller close
  @override
  void onClose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }


  String get restPasswordUrl => ApiServices().resetPassword;
  String get changePasswordUrl => ApiServices().changePassword;
  ///  api request for password
 /* Future<bool> changePassword() async {
    Utils.showLoader();
    bool updated = false;
    await ApiBaseHelper().postAPICall(Uri.parse(passwordChangeUrl), {
      'login_id': userLoginId,
      "old_password": oldPasswordController.text,
      "new_password": newPasswordController.text
    }).then((value) {
      Get.back();
      if (value["status"] == "error") {
        Utils.mySnackBar(
            title: "Error Found",
            msg: value["message"] ?? "Something went wrong please try again");
        updated = false;
      } else {
        Utils.mySnackBar(
            title: "Password Changed",
            msg: value["message"] ?? "Something went wrong please try again");
        oldPasswordController.clear();
        newPasswordController.clear();
        confirmPasswordController.clear();
        updated = true;
      }
    }, onError: (error) {
      Get.back();
      updated = false;
    });
    return updated;
  }*/

  Future<bool> resetPassword(String ? email,otp) async {
    Utils.showLoader();
    bool updated = false;
    await ApiBaseHelper().postAPICall(Uri.parse(restPasswordUrl),langCode:languageCode.toString(), {
      'email': email,
      'otp': otp,
      "new_password": newPasswordController.text,
      "new_password_confirmation": confirmPasswordController.text
    }).then((value) {
      Get.back();
      if (value["status"] == false) {
        Utils.mySnackBar(
            title: "Error Found",
            msg: value["message"] ?? "Something went wrong please try again");
        updated = false;
      } else {
        Utils.mySnackBar(
            title: "Password Changed",
            msg: value["message"] ?? "Something went wrong please try again");
        oldPasswordController.clear();
        newPasswordController.clear();
        confirmPasswordController.clear();
        Get.off(()=>const LoginScreen());
        updated = true;
      }
    }, onError: (error) {
      Get.back();
      updated = false;
    });
    return updated;
  }
  Future changePassword() async {
    Utils.showLoader();

    Future.delayed(const Duration(seconds: 5), () {
      if (Get.isDialogOpen == true) {
        Get.back();
      }
    });

    try {
      await ApiBaseHelper().postAPICall(Uri.parse(changePasswordUrl),langCode:languageCode.toString(), {
        'user_id': userId.toString(),
        'current_password': oldPasswordController.text,
        "new_password": newPasswordController.text,
        "new_password_confirmation": confirmPasswordController.text
      }).then((value) {
        Get.back();
        if (value["status"] == false) {
          Utils.mySnackBar(
            title: "Error Found",
            msg: value["message"] ?? "Something went wrong, please try again",
          );
        } else {
          Utils.mySnackBar(
            title: "Password Changed",
            msg: value["message"] ?? "Password Changed Successfully",
          );
          oldPasswordController.clear();
          newPasswordController.clear();
          confirmPasswordController.clear();
          Get.off(() => const LoginScreen());

        }
      });
    } catch (error) {
      Get.back();

    }
  }





  /// register user method on Sign up
  Future<void> verifyAccount() async {
    if (formKey.currentState!.validate()) {}
  }
}

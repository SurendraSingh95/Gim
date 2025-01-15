// Flutter imports:

import 'package:fitness/Network%20Connectivity/connectivty_check.dart';
import 'package:fitness/colors.dart';
import 'package:fitness/custom/CustomButton.dart';
import 'package:fitness/custom/CustomText.dart';
import 'package:fitness/custom/Fonts.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

import 'Demo_Localization.dart';

// Project imports:


class Utils {

  static void mySnackBar({
    String title = "",
    String msg = "",
    double? maxWidth,
    SnackPosition snackPosition = SnackPosition.TOP,
    EdgeInsets margin = const EdgeInsets.only(top: 10, left: 12, right: 12),
    String? buttonText,
    VoidCallback? onTap,
    Duration duration = const Duration(milliseconds: 1500),

  }) {
    final isDarkMode = Get.theme.brightness == Brightness.dark;

    Get.snackbar(
      title,
      msg,
      snackPosition: snackPosition,
      mainButton: TextButton(
        onPressed: onTap,
        child: Text(
          buttonText ?? '',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
      maxWidth: maxWidth,
      animationDuration: const Duration(milliseconds: 900),
      duration: duration,
      borderColor: isDarkMode? FitnessColor.white: FitnessColor.primary,
      borderWidth: 1,  // Set border width
      colorText:  isDarkMode? FitnessColor.primary: FitnessColor.white,
      backgroundColor: isDarkMode? FitnessColor.white: FitnessColor.colorsociallogintext,
      titleText: title == "" ? const SizedBox() : null,
      messageText: msg == '' ? const SizedBox() : null,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      margin: margin,
    );
  }


  static Future<bool> showConfirmDialog(String title, String contentText, BuildContext context) async {
    bool? result = await Get.defaultDialog(
      title: title,
      content: CustomText(
        text: contentText,
        fontSize: 4.5,
        color: FitnessColor.white,
        fontWeight: FontWeight.bold,
        fontFamily: Fonts.arial,
      ),
      cancel: CustomButton(
        width: 50,
        text: DemoLocalization.of(context)!.translate('NO').toString(),
        onPressed: () {
          Get.back(result: false);
        },
        fontFamily: Fonts.arial,
          fontSize: 20,
      ),
      confirm: CustomButton(
        width: 50,
        text: DemoLocalization.of(context)!.translate('YES').toString(),
        onPressed: () {
          Get.back(result: true);
        },
        fontFamily: Fonts.arial,
        fontSize: 20,
      ),
      // Adding a border to the dialog
      buttonColor: FitnessColor.primary, // Set color of buttons
      radius: 15,
      titleStyle: const TextStyle(color: FitnessColor.white),
      barrierDismissible: false,
     // radius: 15,
      backgroundColor: FitnessColor.primaryLite,
    );
    if (result != null) {
      return result;
    }
    return false;
  }

  static Future<void> showLoader() async {
    Get.dialog(
      barrierDismissible: false,
      PopScope(
        canPop: !(await NetworkConnectivityService.checkInternetConnection()),
        child: Align(
          alignment: Alignment.center,
          child: Container(
            constraints: const BoxConstraints(maxHeight: 50, maxWidth: 50),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: FitnessColor.white,
              shape: BoxShape.circle,
              boxShadow: const [
                BoxShadow(
                  color: FitnessColor.primary,
                  blurRadius: 1,
                  spreadRadius: 2,
                )
              ],
              border: Border.all(color: Colors.white, width: 2), // White border
            ),
            child: const Center(child: CircularProgressIndicator()),
          ),
        ),
      ),
    );
  }

  static Future<dynamic> showOverlayLoader(Future<dynamic> asyncFunction) async {
    final response = await Get.showOverlay(
      asyncFunction: () async {
        return asyncFunction;
      },
      loadingWidget: Align(
        alignment: Alignment.center,
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: FitnessColor.white,
            shape: BoxShape.circle,
            boxShadow: const [
              BoxShadow(
                color: FitnessColor.secondary,
                blurRadius: 1,
                spreadRadius: 2,
              )
            ],
            border: Border.all(color: Colors.white, width: 2), // White border
          ),
          child: const CircularProgressIndicator(),
        ),
      ),
    );
    return response;
  }
}


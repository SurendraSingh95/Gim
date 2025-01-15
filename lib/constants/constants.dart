// Dart imports:
import 'dart:math';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:

/// get screen size
class Constants {
  static Size screen = Size(Get.width, Get.height);
  // static  Size screen = const Size(360.0, 730.0);
  static double largeSize = max(screen.height, screen.width);

  // static getScreenSize(context){
  //   // debugPrint("fgggggggg");
  //   // screen = MediaQuery.sizeOf(context);
  // }

  static double getResponsiveFontSize(double size) {
    double smallerSize = min(screen.width,screen.height);
    return size * smallerSize / 100;
  }

  static BoxDecoration get getDefaultBoxDecoration => BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      //  color: NatureColor.whiteTemp,
     // border: Border.all(color: CoboColor.primary, width: 2)
  );
}

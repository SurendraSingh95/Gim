import 'dart:math';


import 'constants.dart';

///scaling of text size according to the screen width
class ScaleSize {
  static double textScaleFactor({double maxTextScaleFactor = 2,double maxFixFactor = 0.9 }) {

    double val = (max(Constants.screen.height,Constants.screen.height) / 1400) * maxTextScaleFactor;
    return max(maxFixFactor, min(val, maxTextScaleFactor));
  }
}
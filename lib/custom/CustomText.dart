// // import 'package:flutter/material.dart';
// // import 'package:shared_preferences/shared_preferences.dart';
// //
// // class CustomText extends StatelessWidget {
// //   final String text;
// //   final double fontSize;
// //   final Color? color;
// //   final FontWeight? fontWeight;
// //   final FontStyle fontStyle;
// //   final String? fontFamily;
// //   final bool isUnderlined;
// //   final TextAlign textAlign;
// //
// //   CustomText({
// //     required this.text,
// //     required this.fontSize,
// //     this.color,
// //     this.fontWeight,
// //     this.fontStyle = FontStyle.normal,
// //     this.fontFamily,
// //     this.isUnderlined = false,
// //     this.textAlign = TextAlign.start,
// //   });
// //
// //   double getResponsiveFontSize(BuildContext context, double size) {
// //     return size * MediaQuery.of(context).size.width / 100;
// //   }
// //
// //   Future<TextDirection> _getTextDirection() async {
// //     SharedPreferences prefs = await SharedPreferences.getInstance();
// //     String? languageCode = prefs.getString("languageCode");
// //
// //     if (languageCode == 'ne') {
// //       return TextDirection.rtl;
// //     } else {
// //       return TextDirection.ltr;
// //     }
// //
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return FutureBuilder<TextDirection>(
// //       future: _getTextDirection(),
// //       builder: (context, snapshot) {
// //         if (snapshot.connectionState == ConnectionState.waiting) {
// //           return const CircularProgressIndicator();
// //         } else if (snapshot.hasError) {
// //           return Text('Error: ${snapshot.error}');
// //         } else if (snapshot.hasData) {
// //           TextDirection textDirection = snapshot.data ?? TextDirection.ltr;
// //           final isDarkMode = Theme.of(context).brightness == Brightness.dark;
// //           final textColor = color ?? (isDarkMode ? Colors.white : Colors.black);
// //
// //           return Text(
// //             text,
// //             style: TextStyle(
// //               fontSize: getResponsiveFontSize(context, fontSize),
// //               color: textColor,
// //               decoration: isUnderlined ? TextDecoration.underline : TextDecoration.none,
// //               fontWeight: fontWeight,
// //               fontStyle: fontStyle,
// //               fontFamily: fontFamily,
// //             ),
// //             textAlign: textAlign,
// //             textDirection: textDirection,
// //           );
// //         } else {
// //           return const SizedBox();
// //         }
// //       },
// //     );
// //   }
// // }
//
//
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class CustomText extends StatelessWidget {
//   final String text;
//   final double fontSize;
//   final Color? color;
//   final FontWeight? fontWeight;
//   final FontStyle fontStyle;
//   final String? fontFamily;
//   final bool isUnderlined;
//   final TextAlign textAlign;
//
//   CustomText({
//     required this.text,
//     required this.fontSize,
//     this.color,
//     this.fontWeight,
//     this.fontStyle = FontStyle.normal,
//     this.fontFamily,
//     this.isUnderlined = false,
//     this.textAlign = TextAlign.start,
//   });
//
//   double getResponsiveFontSize(BuildContext context, double size) {
//     return size * MediaQuery.of(context).size.width / 100;
//   }
//
//   Future<TextDirection> _getTextDirection() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? languageCode = prefs.getString("languageCode");
//
//     if (languageCode == 'en') {
//       return TextDirection.ltr;
//     } else if (languageCode == 'ne') {
//       return TextDirection.rtl;
//     } else {
//       return TextDirection.rtl;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<TextDirection>(
//       future: _getTextDirection(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const CircularProgressIndicator(); // Show loading indicator while waiting
//         } else if (snapshot.hasError) {
//           return Text('Error: ${snapshot.error}'); // Show error if any
//         } else if (snapshot.hasData) {
//           TextDirection textDirection = snapshot.data ?? TextDirection.rtl;
//           Alignment alignment =  textDirection == TextDirection.ltr ? Alignment.centerLeft:Alignment.centerRight;
//           TextAlign textAlignment = textDirection == TextDirection.rtl ? TextAlign.right : textAlign;
//
//           final isDarkMode = Theme.of(context).brightness == Brightness.dark;
//           final textColor = color ?? (isDarkMode ? Colors.white : Colors.black);
//
//           return Align(
//             alignment: alignment,
//             child: Text(
//               text,
//               style: TextStyle(
//                 fontSize: getResponsiveFontSize(context, fontSize),
//                 color: isDarkMode ? Colors.white : Colors.black,
//                 decoration: isUnderlined ? TextDecoration.underline : TextDecoration.none,
//                 fontWeight: fontWeight,
//                 fontStyle: fontStyle,
//                 fontFamily: fontFamily,
//               ),
//               textAlign: textAlignment, // Adjusted text alignment based on textDirection
//               textDirection: textDirection, // Apply the correct text direction (LTR or RTL)
//             ),
//           );
//         } else {
//           return const SizedBox(); // Return empty widget if no data
//         }
//       },
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  final FontStyle fontStyle;
  final String? fontFamily;
  final bool isUnderlined;
  final TextAlign textAlign;

  CustomText({
    required this.text,
    required this.fontSize,
    this.color,
    this.fontWeight,
    this.fontStyle = FontStyle.normal,
    this.fontFamily,
    this.isUnderlined = false,
    this.textAlign = TextAlign.start,
  });

  double getResponsiveFontSize(BuildContext context, double size) {
    return size * MediaQuery.of(context).size.width / 100;
  }

  Future<TextDirection> _getTextDirection() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? languageCode = prefs.getString("languageCode");

    if (languageCode == 'en') {
      return TextDirection.ltr;
    } else if (languageCode == 'ar') {
      return TextDirection.rtl;
    } else {
      return TextDirection.rtl;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<TextDirection>(
      future: _getTextDirection(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Remove CircularProgressIndicator and return a placeholder
          return Text(
            text,
            style: TextStyle(
              fontSize: getResponsiveFontSize(context, fontSize),
              color: color ?? Colors.grey, // Fallback color
              decoration: isUnderlined ? TextDecoration.underline : TextDecoration.none,
              fontWeight: fontWeight,
              fontStyle: fontStyle,
              fontFamily: fontFamily,
            ),
            textAlign: textAlign,
          );
        } else if (snapshot.hasError) {
          // Handle error with fallback text direction
          return Text(
            text,
            style: TextStyle(
              fontSize: getResponsiveFontSize(context, fontSize),
              color: color ?? Colors.red, // Optional error styling
              decoration: isUnderlined ? TextDecoration.underline : TextDecoration.none,
              fontWeight: fontWeight,
              fontStyle: fontStyle,
              fontFamily: fontFamily,
            ),
            textAlign: textAlign,
            textDirection: TextDirection.ltr, // Default direction in case of error
          );
        } else if (snapshot.hasData) {
          TextDirection textDirection = snapshot.data ?? TextDirection.rtl;
          Alignment alignment = textDirection == TextDirection.ltr ? Alignment.centerLeft : Alignment.centerRight;
          TextAlign textAlignment = textDirection == TextDirection.rtl ? TextAlign.right : textAlign;

          final isDarkMode = Theme.of(context).brightness == Brightness.dark;
          final textColor = color ?? (isDarkMode ? Colors.white : Colors.black);

          return Align(
            alignment: alignment,
            child: Text(
              text,
              style: TextStyle(
                fontSize: getResponsiveFontSize(context, fontSize),
                color: isDarkMode ? Colors.white : Colors.black,
                decoration: isUnderlined ? TextDecoration.underline : TextDecoration.none,
                fontWeight: fontWeight,
                fontStyle: fontStyle,
                fontFamily: fontFamily,
              ),
              textAlign: textAlignment,
              textDirection: textDirection,
            ),
          );
        } else {
          // Fallback in case of no data
          return const SizedBox();
        }
      },
    );
  }
}


class CustomText1 extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  final FontStyle fontStyle;
  final String? fontFamily;
  final bool isUnderlined;
  final TextAlign textAlign;

  CustomText1({super.key,
    required this.text,
    required this.fontSize,
    this.color,
    this.fontWeight,
    this.fontStyle = FontStyle.normal,
    this.fontFamily,
    this.isUnderlined = false,
    this.textAlign = TextAlign.start,
  });

  double getResponsiveFontSize(BuildContext context, double size) {
    return size * MediaQuery.of(context).size.width / 100;
  }

  Future<TextDirection> _getTextDirection() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? languageCode = prefs.getString("languageCode");

    if (languageCode == 'en') {
      return TextDirection.ltr;
    } else if (languageCode == 'ar') {
      return TextDirection.rtl;
    } else {
      return TextDirection.rtl;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<TextDirection>(
      future: _getTextDirection(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Remove CircularProgressIndicator and return a placeholder
          return Text(
            text,
            style: TextStyle(
              fontSize: getResponsiveFontSize(context, fontSize),
              color: color ?? Colors.grey, // Fallback color
              decoration: isUnderlined ? TextDecoration.underline : TextDecoration.none,
              fontWeight: fontWeight,
              fontStyle: fontStyle,
              fontFamily: fontFamily,
            ),
            textAlign: textAlign,
          );
        } else if (snapshot.hasError) {
          // Handle error with fallback text direction
          return Text(
            text,
            style: TextStyle(
              fontSize: getResponsiveFontSize(context, fontSize),
              color: color ?? Colors.red, // Optional error styling
              decoration: isUnderlined ? TextDecoration.underline : TextDecoration.none,
              fontWeight: fontWeight,
              fontStyle: fontStyle,
              fontFamily: fontFamily,
            ),
            textAlign: textAlign,
            textDirection: TextDirection.ltr, // Default direction in case of error
          );
        } else if (snapshot.hasData) {
          TextDirection textDirection = snapshot.data ?? TextDirection.rtl;
          //Alignment alignment = textDirection == TextDirection.ltr ? Alignment.centerLeft : Alignment.centerRight;
          TextAlign textAlignment = textDirection == TextDirection.rtl ? TextAlign.right : textAlign;

          final isDarkMode = Theme.of(context).brightness == Brightness.dark;
          final textColor = color ?? (isDarkMode ? Colors.white : Colors.black);

          return Align(
            child: Text(
              text,
              style: TextStyle(
                fontSize: getResponsiveFontSize(context, fontSize),
                color: isDarkMode ? Colors.white : Colors.black,
                decoration: isUnderlined ? TextDecoration.underline : TextDecoration.none,
                fontWeight: fontWeight,
                fontStyle: fontStyle,
                fontFamily: fontFamily,
              ),
              textAlign: textAlignment,
              textDirection: textDirection,
            ),
          );
        } else {
          // Fallback in case of no data
          return const SizedBox();
        }
      },
    );
  }
}


class CustomText2 extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  final FontStyle fontStyle;
  final String? fontFamily;
  final bool isUnderlined;
  final TextAlign textAlign;

  CustomText2({
    required this.text,
    required this.fontSize,
    this.color,
    this.fontWeight,
    this.fontStyle = FontStyle.normal,
    this.fontFamily,
    this.isUnderlined = false,
    this.textAlign = TextAlign.start,
  });

  double getResponsiveFontSize(BuildContext context, double size) {
    return size * MediaQuery.of(context).size.width / 100;
  }

  Future<TextDirection> _getTextDirection() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? languageCode = prefs.getString("languageCode");

    if (languageCode == 'en') {
      return TextDirection.ltr;
    } else if (languageCode == 'ar') {
      return TextDirection.rtl;
    } else {
      return TextDirection.rtl;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<TextDirection>(
      future: _getTextDirection(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Remove CircularProgressIndicator and return a placeholder
          return Text(
            text,
            style: TextStyle(
              fontSize: getResponsiveFontSize(context, fontSize),
              color: color ?? Colors.grey, // Fallback color
              decoration: isUnderlined ? TextDecoration.underline : TextDecoration.none,
              fontWeight: fontWeight,
              fontStyle: fontStyle,
              fontFamily: fontFamily,
            ),
            textAlign: textAlign,
          );
        } else if (snapshot.hasError) {
          // Handle error with fallback text direction
          return Text(
            text,
            style: TextStyle(
              fontSize: getResponsiveFontSize(context, fontSize),
              color: color ?? Colors.red, // Optional error styling
              decoration: isUnderlined ? TextDecoration.underline : TextDecoration.none,
              fontWeight: fontWeight,
              fontStyle: fontStyle,
              fontFamily: fontFamily,
            ),
            textAlign: textAlign,
            textDirection: TextDirection.ltr, // Default direction in case of error
          );
        } else if (snapshot.hasData) {
          TextDirection textDirection = snapshot.data ?? TextDirection.rtl;
          Alignment alignment = textDirection == TextDirection.ltr ? Alignment.centerLeft : Alignment.centerRight;
          TextAlign textAlignment = textDirection == TextDirection.rtl ? TextAlign.right : textAlign;

          final isDarkMode = Theme.of(context).brightness == Brightness.dark;
          final textColor = color ?? (isDarkMode ? Colors.white : Colors.black);

          return Align(
            alignment: alignment,
            child: Text(
              text,
              style: TextStyle(
                fontSize: getResponsiveFontSize(context, fontSize),
                color:Colors.white,
                decoration: isUnderlined ? TextDecoration.underline : TextDecoration.none,
                fontWeight: fontWeight,
                fontStyle: fontStyle,
                fontFamily: fontFamily,
              ),
              textAlign: textAlignment,
              textDirection: textDirection,
            ),
          );
        } else {
          // Fallback in case of no data
          return const SizedBox();
        }
      },
    );
  }
}
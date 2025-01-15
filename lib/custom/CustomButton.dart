import 'package:fitness/colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final double? height;
  final double? width;
  final double borderRadius;
  final String? fontFamily;
  final double? fontSize;
  final double? letterSpacing;

  const CustomButton({
    required this.text,
    required this.onPressed,
    this.color = FitnessColor.primary,
    this.height,
    this.width,
    this.borderRadius = 8.0,
    required this.fontFamily,
    this.fontSize,
    this.letterSpacing,
  });

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;



    final screenSize = MediaQuery.of(context).size;
    final buttonHeight = height ?? screenSize.height * 0.07;
    final buttonWidth = width ?? MediaQuery.of(context).size.width / 1.1;

    return GestureDetector(
      onTap: onPressed,
      child: Card(
        shape: RoundedRectangleBorder(
            side:  BorderSide(color: isDarkMode
                ? FitnessColor.white.withOpacity(0.4)
                : FitnessColor.white),
            borderRadius: BorderRadius.circular(10)
        ),
        elevation:5 ,
        child: Container(
          height: buttonHeight,
          width: buttonWidth,
          decoration: BoxDecoration(
            color:  (isDarkMode ?  FitnessColor.colorView.withOpacity(0.0) : FitnessColor.primary),
            borderRadius: BorderRadius.circular(borderRadius),

          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color:isDarkMode ?  FitnessColor.white : FitnessColor.white,
                letterSpacing: letterSpacing,
                fontWeight: FontWeight.bold,
                fontFamily: fontFamily,
                fontSize: fontSize,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

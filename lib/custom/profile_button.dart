import 'package:fitness/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Fonts.dart';

class CustomContainer extends StatelessWidget {
  final String buttonText;
  final IconData iconData;
  final double height;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? iconColor;
  final BorderRadiusGeometry borderRadius;
  final Function onTap;

  const CustomContainer({
    super.key,
    required this.buttonText,
    required this.iconData,
    required this.onTap,
    this.height = 50,
    this.backgroundColor,
    this.textColor,
    this.iconColor,
    this.borderRadius = const BorderRadius.all(Radius.circular(5.0)),
  });

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () => onTap(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3),
        child: Container(
          height: height,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: backgroundColor ?? (isDarkMode ?  FitnessColor.colorView.withOpacity(0.0) : FitnessColor.white), // Dynamic background color
            borderRadius: borderRadius,
            border: Border.all(
              color: isDarkMode
                  ? FitnessColor.white.withOpacity(0.4)
                  : FitnessColor.colorsociallogintext.withOpacity(0.5)
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                buttonText,
                style: TextStyle(
                  color: textColor ?? (isDarkMode ? Colors.white : Colors.black), // Dynamic text color
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  fontFamily: Fonts.arial,
                ),
              ),
              const Spacer(),
              Icon(
                iconData,
                color: iconColor ?? (isDarkMode ? Colors.white : Colors.black), // Dynamic icon color
                size: 22,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

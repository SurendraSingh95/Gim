import 'package:fitness/utils/shared_preferences.dart';
import 'package:flutter/material.dart';
import '../colors.dart';

class CstAppbarWithtextimage extends StatelessWidget {
  final String title;
  final IconData? icon;
  final String? imageAsset;
  final String? fontFamily;
  final VoidCallback? onImageTap; // Callback for image tap
  final Color? iconColor; // Color for the icon
  final Color? textColor; // Color for the text
  final Color? imageColor; // Color for the image (tint)

  const CstAppbarWithtextimage({
    Key? key,
    required this.title,
    this.icon,
    this.imageAsset,
    required this.fontFamily,
    required this.onImageTap,
    this.iconColor,  // Optional icon color
    this.textColor,  // Optional text color
    this.imageColor, // Optional image color (tint)
  }) : super(key: key);
  String get userId => SharedPref.getUserId();

  @override
  Widget build(BuildContext context) {

    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;



    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space between elements
      children: [
        GestureDetector(
          onTap: () {
            if (onImageTap != null) {
              onImageTap!();
            } else {
              Navigator.pop(context);
            }
          },
          child: icon != null
              ? Icon(
            icon,
            color: isDarkMode ?FitnessColor.white : FitnessColor.colorTextThird,
          )
              : const SizedBox(width: 24),
        ),
        Expanded(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: fontFamily,
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color:  isDarkMode ?FitnessColor.white : FitnessColor.colorTextThird,
            ),
          ),
        ),
        GestureDetector(
          onTap: onImageTap,
          child: imageAsset != null
              ? SizedBox(
            width: 24,
            height: 24,
            child: userId == null || userId.isEmpty ? const SizedBox.shrink():  Image.asset(
              imageAsset!,
              width: 24,
              height: 24,

            ),
          )
              : const SizedBox(width: 24), // Empty space if no image provided
        ),
      ],
    );
  }
}

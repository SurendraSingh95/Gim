import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX for navigation
import '../colors.dart';

class CustomTextWidget extends StatelessWidget {
  final String title;
  final IconData? icon;
  final String? imageAsset;
  final String? fontFamily;
  final VoidCallback? onTap;

  const CustomTextWidget({
    Key? key,
    required this.title,
    this.icon,
    this.imageAsset,
    required this.fontFamily,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Get.theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          icon != null
              ? Icon(
            icon,
            color: FitnessColor.colorTextThird,
          )
              : imageAsset != null
              ? Image.asset(
            imageAsset!,
            width: 9,
            height: 13,
            color: Colors.white,
          )
              : const SizedBox(width: 24),

          Text(
            title,
            style: TextStyle(
              fontFamily: fontFamily,
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color:isDarkMode? FitnessColor.white: FitnessColor.colorTextThird,
            ),
          ),
        ],
      ),
    );
  }
}

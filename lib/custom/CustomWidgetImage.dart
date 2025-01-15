import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../colors.dart';

class CustomWidgetImage extends StatelessWidget {
  final String title;
  final IconData? icon;
  final String? imageAsset;
  final String? fontFamily;
  final VoidCallback? onImageTap; // Callback for image tap
  final VoidCallback? onTextTap; // Callback for text tap


  const CustomWidgetImage({
    Key? key,
    required this.title,
    this.icon,
    this.imageAsset,
    required this.fontFamily,
    this.onImageTap,
    this.onTextTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // Use MediaQuery to get the screen size
    final screenSize = MediaQuery.of(context).size;

    // Default to 10% of the screen height if no height is provided
    // final buttonHeight = height ?? screenSize.height * 0.07;

    // Default to 80% of the screen width if no width is provided
    // final buttonWidth = width ?? MediaQuery.of(context).size.width / 1.1;//screenSize.width * 0.9;



    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: onImageTap,
          child: imageAsset != null ?Image.asset(
                imageAsset!,
                width: screenSize.width * 0.08,//40, // Adjust width as needed
                height: screenSize.height * 0.06,//60, // Adjust height as needed
              )
            : icon != null
                ? Icon(
                    icon,
                    color: FitnessColor.colorTextThird,
                  )
                : SizedBox(width: 24), // Empty space if no image/icon provided
        ),
        // Title on the right
        GestureDetector(
          onTap: onTextTap,
          child: Container(
            height: screenSize.height * 0.04,//40,
            width: screenSize.width * 0.2,//80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: FitnessColor.colorTextThird,
              border: Border.all(
                width: 2.0, // Adjust border width as needed
              ),
            ),
            child: Center(
              child: Text(
                textAlign: TextAlign.center,
                title,
                style: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: 10, // Adjust font size as needed
                  fontWeight: FontWeight.bold,
                  color: FitnessColor.colorBg1,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

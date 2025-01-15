import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final String text;
  final Color borderColor;
  final Color fillColor;
  final Color textColor;
  final String? imageAsset;
  final String? fontFamily;

  CustomContainer({
    required this.text,
    required this.borderColor,
    required this.fillColor,
    required this.textColor,
    required this.imageAsset,
    required this.fontFamily,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding:EdgeInsets.symmetric(vertical: 15,horizontal: 15),
      height: MediaQuery.of(context).size.height* 0.07,
      width: MediaQuery.of(context).size.width / 1.1,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: fillColor,
        border: Border.all(
          color: borderColor,
          width: 1.0, // Adjust border width as needed
        ),
      ),

      child: Row(
       crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // SizedBox(width: 12,),
          if (imageAsset != null) // Only display image if imageAsset is provided
            Padding(
              padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width /10),
              child: Image.asset(
                imageAsset!,
                width: 24,//MediaQuery.of(context).size.width/10,
                height: 24,
               // color: textColor, // Apply textColor to image
              ),
            ),
          Expanded(
            child: Center(
              child: Padding(
                padding:  EdgeInsets.only(right:  MediaQuery.of(context).size.width /8),
                child: Text(
                  text,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 14.0, // Adjust font size as needed
                    fontWeight: FontWeight.bold,
                    fontFamily: fontFamily
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
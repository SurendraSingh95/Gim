
// Flutter imports:
import 'package:fitness/colors.dart';
import 'package:fitness/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

// Package imports:

// Project imports:

import 'package:flutter/material.dart';

Widget myShimmer({double height = 80}) {
  return SafeArea(
    child: Builder(
      builder: (context) {
        final isDarkMode = Theme.of(context).brightness == Brightness.dark;

        final baseColor = isDarkMode ? FitnessColor.primary.withOpacity(0.4) : FitnessColor.primary.withOpacity(0.4);
        final highlightColor = isDarkMode ? FitnessColor.white.withOpacity(0.4) : FitnessColor.white.withOpacity(0.4);

        return Shimmer.fromColors(
          baseColor: baseColor,
          highlightColor: highlightColor,
          enabled: true,
          child: ListView.builder(
            padding: const EdgeInsets.only(top: 10),
            itemCount: 10,
            shrinkWrap: true,
            itemBuilder: (context, index) => Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                  height: height,
                  decoration: BoxDecoration(
                    color: baseColor, // Match container background with baseColor
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}

Widget myShimmer1({double height = 40}) {
  return SafeArea(
    child: Builder(
      builder: (context) {
        final isDarkMode = Theme.of(context).brightness == Brightness.dark;

        final baseColor = isDarkMode ? FitnessColor.primary.withOpacity(0.4) : FitnessColor.primary.withOpacity(0.4);
        final highlightColor = isDarkMode ? FitnessColor.white.withOpacity(0.4) : FitnessColor.white.withOpacity(0.4);

        return Shimmer.fromColors(
          baseColor: baseColor,
          highlightColor: highlightColor,
          enabled: true,
          child: ListView.builder(
            padding: const EdgeInsets.only(top: 10),
            itemCount: 2,
            shrinkWrap: true,
            itemBuilder: (context, index) => Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                  height: height,
                  width: 120,
                  decoration: BoxDecoration(
                    color: baseColor, // Match container background with baseColor
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}

Widget myShimmer2() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [

      const SizedBox(height: 10),
      Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.black,
        child: Text(
          "Loading...",
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
      ),
    ],
  );
}


Widget myHorizontalShimmer({double height = 80, double width = 150}) {
  return Shimmer.fromColors(
    baseColor:  FitnessColor.primary.withOpacity(0.4),
    highlightColor:  FitnessColor.primary.withOpacity(0.2),
    enabled: true,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      itemCount: 10,
      itemBuilder: (context, index) => Container(
        width: width,
        margin: const EdgeInsets.only(right: 10),
        height: height,
        decoration: BoxDecoration(
          color:  FitnessColor.primary,
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    ),
  );
}

// Shimmer loader widget
Widget imageLoaderShimmer({double height = 2.0, double width = double.infinity}) {
  return SafeArea(
    child: Builder(
      builder: (context) {
        final isDarkMode = Theme.of(context).brightness == Brightness.dark;

        final baseColor = isDarkMode ? FitnessColor.white : FitnessColor.white.withOpacity(0.4);
        final highlightColor = isDarkMode ? FitnessColor.white.withOpacity(0.6) : FitnessColor.white.withOpacity(0.6);

        return Shimmer.fromColors(
          baseColor: baseColor,
          highlightColor: highlightColor,
          enabled: true,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
            height: height,
            width: width,
            decoration: BoxDecoration(
              color: baseColor,
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        );
      },
    ),
  );
}


/*Widget myShimmerGrid({double ratio = 1})  {
  return SafeArea(
    child: Shimmer.fromColors(
      baseColor: CoboColor.primary1.withOpacity(0.4),
      highlightColor: CoboColor.primary1.withOpacity(0.2),
      enabled: true,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: ratio,
        ),
        itemCount: 4,
        itemBuilder: (context, index) => Container(
          decoration: BoxDecoration(
            color: CoboColor.primary,
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    ),
  );
}*/

Widget myShimmerGrid({double ratio = 1}) {
  return SafeArea(
    child: Shimmer.fromColors(
      baseColor: FitnessColor.primary.withOpacity(0.4),
      highlightColor: FitnessColor.primary.withOpacity(0.2),
      enabled: true,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 5.0,
          crossAxisSpacing: 5.0,
          childAspectRatio: 2.5 / 3.0,
        ),
        itemCount: 4,
        itemBuilder: (context, index) => Container(
          decoration: BoxDecoration(
            color: FitnessColor.primary,
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    ),
  );
}


Widget myObjectShimmer(
    {double height = 80,
    double width = double.infinity,
    double borderRadius = 30}) {return Shimmer.fromColors(
    baseColor:  FitnessColor.primary.withOpacity(0.4),
    highlightColor:  FitnessColor.primary.withOpacity(0.2),
    enabled: true,
    child: Container(
      width: width,
      height: height,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
      decoration: BoxDecoration(
        color:  FitnessColor.primary,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    ),
  );}

Widget myObjectShimmerFullScreen(BuildContext context) {

  return Shimmer.fromColors(
    baseColor:  FitnessColor.primary.withOpacity(0.4),
    highlightColor:  FitnessColor.primary.withOpacity(0.2),
    enabled: true,
    child: Container(
      height: Constants.screen.height,
      decoration: BoxDecoration(
        color:  FitnessColor.primary,
        borderRadius: BorderRadius.circular(
            10),
      ),
    ),
  );
}

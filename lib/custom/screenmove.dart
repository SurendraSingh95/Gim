import 'package:fitness/Screens/question_answer_screen.dart';
import 'package:fitness/onbordingpage/onboardingScreen.dart';
import 'package:flutter/cupertino.dart';

class ScreenMove{


Route createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const QuestionAnswerScreen(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, -1.0); // Start from top
      const end = Offset.zero; // End at center
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
}
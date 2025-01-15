
import 'package:fitness/Api%20Services1/api_helper_methods.dart';
import 'package:fitness/Api%20Services1/api_services.dart';
import 'package:fitness/Model/get_member_ship_plan_model.dart';
import 'package:fitness/Model/get_profile_model.dart';
import 'package:fitness/Model/get_question_model.dart';
import 'package:fitness/Model/get_traniner_model.dart';

import 'package:fitness/utils/shared_preferences.dart';

import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';


// Project imports:

class QuestionController extends GetxController {

   /// get user id
   String get _userId => SharedPref.getUserId();
   String get languageCode => SharedPref.getLanguageToPrefs();
   String get userId => _userId;

   ///declaration of variables
   RxBool isLoading = false.obs;

   /// api services and helper methods instance
   ApiServices apiServices = ApiServices();
   ApiBaseHelper apiBaseHelper = ApiBaseHelper();


   GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

   ///api urls
   String get getQuestionURL => apiServices.getQuestion;
   String get getTrainerURL => apiServices.trainer;

   ///home data lists
   RxList<QuestionList> questionList = <QuestionList>[].obs;
   RxList<TrainerList> trainerList = <TrainerList>[].obs;

   ///get question list
   getQuestionApi() async {
      isLoading.value = true;
      dynamic response = await apiBaseHelper.getAPICall(Uri.parse(getQuestionURL),langCode:languageCode.toString());
      questionList.value = GetQuestionsModel.fromJson(response).data;
      isLoading.value = false;
   }


   ///get trainer list
   getTrainerApi() async {
    await Future.delayed(Duration.zero);
      try {
        isLoading.value = true;
        dynamic response = await apiBaseHelper.getAPICall(Uri.parse(getTrainerURL),langCode:languageCode.toString());
        trainerList.value = GetTrainerModel.fromJson(response).data;
        print("sdadadas${trainerList.value.first.title}");
      } on Exception catch (e) {
         print("axssadas$e");
      }

      isLoading.value = false;
   }


   @override
   Future<void> refresh() async {

   }

}

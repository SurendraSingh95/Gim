
// Flutter imports:
import 'dart:developer';
import 'dart:io';


import 'package:fitness/Api%20Services1/api_helper_methods.dart';
import 'package:fitness/Api%20Services1/api_services.dart';
import 'package:fitness/Controllers/Auth%20Controllers/login_controller.dart';
import 'package:fitness/Model/SettingModel/get_privacy_policy_model.dart';
import 'package:fitness/Model/SettingModel/get_terms_condition_model.dart';
import 'package:fitness/Model/get_member_ship_plan_model.dart';
import 'package:fitness/Model/get_profile_model.dart';
import 'package:fitness/Screens/home_screen.dart';
import 'package:fitness/post/PostScreen.dart';
import 'package:fitness/utils/Session.dart';
import 'package:fitness/utils/shared_preferences.dart';
import 'package:fitness/utils/utils.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';


// Project imports:

class SettingController extends GetxController {

   /// get user id
   String get _userId => SharedPref.getUserId();
   String get userLoginId => SharedPref.getUserLoginId();

   ///  cart item count
   RxInt cartItemTotalCount = 0.obs;

   ///declaration of variables
   RxBool isLoading = false.obs;

   /// api services and helper methods instance
   ApiServices apiServices = ApiServices();
   ApiBaseHelper apiBaseHelper = ApiBaseHelper();

   String get languageCode => SharedPref.getLanguageToPrefs();
   GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();


   ///api urls
   String get privacyPolicyURL => apiServices.privacyPolicy;
   String get termsConditionURL => apiServices.termsCondition;

   String get userId => _userId;

   ///home data lists
   RxList<PrivacyData> privacyData = <PrivacyData>[].obs;
   RxList<TermsData> termsData = <TermsData>[].obs;

   ///get setting api
   privacyApi() async {
      isLoading.value = true;
      dynamic response = await apiBaseHelper.getAPICall(Uri.parse(privacyPolicyURL),langCode:languageCode.toString() );
      privacyData.value = GetPrivacyPolicyModel.fromJson(response).data!;
      isLoading.value = false;
   }
   termsAndConditionApi() async {
      isLoading.value = true;
      dynamic response = await apiBaseHelper.getAPICall(Uri.parse(termsConditionURL),langCode:languageCode.toString());
      termsData.value = GetTermsAndConditionModel.fromJson(response).data!;
      isLoading.value = false;
   }


   @override
   Future<void> refresh() async {
      privacyApi();
   }

}

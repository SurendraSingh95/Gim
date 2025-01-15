
// Flutter imports:
import 'dart:convert';
import 'dart:developer';
import 'dart:io';


import 'package:fitness/Api%20Services1/api_helper_methods.dart';
import 'package:fitness/Api%20Services1/api_services.dart';
import 'package:fitness/utils/shared_preferences.dart';
import 'package:flutter/material.dart';


// Package imports:
import 'package:get/get.dart';


// Project imports:

class CustomerHomeController extends GetxController {

   /// get user id
   String get _userId => SharedPref.getUserId();
   String get userLoginId => SharedPref.getUserLoginId();

   ///  cart item count
   RxInt cartItemTotalCount = 0.obs;

   ///declaration of variables
   RxBool isLoading = false.obs;
   RxBool isLoading1 = false.obs;
   RxInt sliderIndex = 0.obs;
   var passwordVisible = false.obs;
   TextEditingController searchProductController = TextEditingController();

   RxString currentLocationText = ''.obs;
   RxString address = ''.obs;
   RxString city = ''.obs;


   /// api services and helper methods instance
   ApiServices apiServices = ApiServices();
   ApiBaseHelper apiBaseHelper = ApiBaseHelper();


   GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

   ///api urls
   String get profileURl => apiServices.profile;



   ///home data lists

   /*RxList<ProfileData> profileData = <ProfileData>[].obs;


   ///get profile  api
   getProfileApi() async {
      isLoading.value = true;
      try {
         dynamic response = await apiBaseHelper.postAPICall(Uri.parse(profileURl), {"login_id":userLoginId.toString()});
         profileData.value = ProfileModel.fromJson(response).data!;
         isLoading.value = false;
      } on Exception catch (e) {
         log('error $e');
      }

   }*/

   ///handle password visibility
   void togglePasswordVisibility() {
      passwordVisible.value = !passwordVisible.value;
   }

 /*  /// update Profile image Api
   uploadProfileApi(images) async {
      if (images.path.isEmpty) {
         Utils.mySnackBar(
             title: "Select Image",
             msg: "Please upload an image");
         return null;
      }

      Utils.showLoader();
      try {
         List<File> imageList = [images];
         final response = await apiBaseHelper.postMultipartAPICall(
            Uri.parse(uploadProfileImageURL),
            {
               "login_id":userLoginId.toString(),
            },
            fileKey: 'profile_image',
            files: imageList,
         );
         Get.back();
         if (response["status"] == false) {
            Utils.mySnackBar(
                title: "Error Found",
                msg: response["message"] ?? "Something went wrong, please try again");
         } else {
            Get.back();
            getProfileApi();
            Utils.mySnackBar(
                title: "Success",
                msg: response["message"], duration: const Duration(seconds: 2));
         }
      } on Exception catch (e) {
          Get.back();
         Utils.mySnackBar(
             title: "Error",
             msg: "An exception occurred: ${e.toString()}");
      }
   }*/

   @override
   Future<void> refresh() async {



   }

}

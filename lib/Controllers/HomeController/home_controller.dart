
// Flutter imports:
import 'dart:developer';
import 'dart:io';


import 'package:fitness/Api%20Services1/api_helper_methods.dart';
import 'package:fitness/Api%20Services1/api_services.dart';
import 'package:fitness/Controllers/Auth%20Controllers/login_controller.dart';
import 'package:fitness/Model/Trainer%20Model/get_trainer_all_video_model.dart';
import 'package:fitness/Model/Trainer%20Model/get_trainer_details_model.dart';
import 'package:fitness/Model/Trainer%20Model/get_trainer_video_model.dart';
import 'package:fitness/Model/get_details_model.dart';
import 'package:fitness/Model/get_member_ship_plan_model.dart';
import 'package:fitness/Model/get_my_plan.dart';
import 'package:fitness/Model/get_profile_model.dart';
import 'package:fitness/Model/get_vedio_home_model.dart';
import 'package:fitness/Screens/home_screen.dart';
import 'package:fitness/auth/LoginScreen.dart';
import 'package:fitness/auth/sign_out_screen.dart';
import 'package:fitness/post/PostScreen.dart';
import 'package:fitness/utils/shared_preferences.dart';
import 'package:fitness/utils/utils.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';


// Project imports:

class HomeController extends GetxController {

   /// get user id
   String get _userId => SharedPref.getUserId();
   String get languageCode => SharedPref.getLanguageToPrefs();
   String get trainerId => SharedPref.getTrainerToPrefs();
   String get userLoginId => SharedPref.getUserLoginId();


   ///  cart item count
   RxInt cartItemTotalCount = 0.obs;

   ///declaration of variables
   RxBool isLoading = false.obs;
   RxBool isLoading1 = false.obs;
   RxBool isLoadingProfile = false.obs;
   RxBool isLoading2 = false.obs;
   RxBool isLoadingVideo = false.obs;
   RxBool isLoadingDetails = false.obs;
   RxInt sliderIndex = 0.obs;
   var passwordVisible = false.obs;
   final nameController = TextEditingController();
   final phoneController = TextEditingController();
   final emailController = TextEditingController();
   /// api services and helper methods instance
   ApiServices apiServices = ApiServices();
   ApiBaseHelper apiBaseHelper = ApiBaseHelper();


   GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

   ///api urls
   String get profileURl => apiServices.profile;
   String get myPlanURl => apiServices.myPlan;
   String get uploadProfileImageURL => apiServices.uploadProfile;
   String get getPlanURL => apiServices.gePlan;
   String get getVideoURL => apiServices.geVideo;
   String get purchasePlanURL => apiServices.purchasePlan;
   String get deleteAccountURL => apiServices.deleteAccount;
   String get homeDetailsURL => apiServices.homeDetails;
   String get trainerWisePlanURL => apiServices.trainerWisePlan;
   String get trainerDetailsURL => apiServices.trainerDetails;

   String get userId => _userId;

   ///home data lists
   RxList<ProfileData> profileData = <ProfileData>[].obs;
   RxList<PlanData> planData = <PlanData>[].obs;
   RxList<TrainerVideoList> trainerVideoList = <TrainerVideoList>[].obs;
   RxList<UserList> userList = <UserList>[].obs;
   RxList<DetailsData> detailsData = <DetailsData>[].obs;


   /// plan api
   RxList<VideoPlanList> videoPlanList = <VideoPlanList>[].obs;
   /// trainer details
   RxList<TarinerData> tarinerData = <TarinerData>[].obs;

   ///get profile  api
   getProfileApi() async {
      print("------Surendra-----------------");
      isLoadingProfile.value = true;
      try {
         dynamic response = await apiBaseHelper.postAPICall(Uri.parse(profileURl),langCode:languageCode.toString() , {"user_id":userId.toString()});
         profileData.value = GetProfileModel.fromJson(response).data!;
         if (profileData.value != null) {
            profileData = profileData.value.obs;
            // profileImage.value = profileData.value?.image ?? '';
            nameController.text = profileData.value.first.name ?? '';
            phoneController.text = profileData.value.first.phone ?? '';
            emailController.text = profileData.value.first.email ?? '';
            isLoadingProfile.value = false;
         } else {
            Utils.mySnackBar(
                title: 'Something went wrong',
                msg: 'please check your internet connection and try again');
         }


      } on Exception catch (e) {
         log('error $e');
      }

   }

   ///get plans list
   getMemberShipPlan() async {
      isLoading.value = false;
      dynamic response = await apiBaseHelper.getAPICall(Uri.parse(getPlanURL),langCode:languageCode.toString());
      planData.value = GetMemberShipPlanModel.fromJson(response).data;
      isLoading.value = false;
   }

   ///get trainer all video
   getVideoList(String? planId) async {
    isLoadingVideo.value = true;
      dynamic response = await apiBaseHelper.postAPICall(Uri.parse(getVideoURL),langCode:languageCode.toString(),{"plan_id":planId});
      trainerVideoList.value = GetTrainerVideoListModel.fromJson(response).data;
      isLoadingVideo.value = false;

   }

   /// update Profile image Api
   uploadProfileApi(image) async {
      Utils.showLoader();
      try {
         List<File> imageList = [];
         if (image != null) {
            imageList = [image];
         }

         final response = await apiBaseHelper.postMultipartAPICall(
            Uri.parse(uploadProfileImageURL),
            {
               "user_id": userId.toString(),
                  "name": nameController.text,
               "phone": phoneController.text,
            },
            fileKey: 'profile_image',
            files: imageList,
         );

         Get.back();
         if (response["success"] == false) {
            Utils.mySnackBar(
                title: "Error Found",
                msg: response["message"] ?? "Something went wrong, please try again");
         } else {
            Get.back();
            getProfileApi();
            Utils.mySnackBar(
                title: "Success",
                msg: response["message"], duration: const Duration(seconds: 2));
            Get.off(() => const SignOutScreen());
         }
      } on Exception catch (e) {
         Get.back();
         Utils.mySnackBar(
             title: "Error",
             msg: "An exception occurred: ${e.toString()}");
      } finally {
         Future.delayed(const Duration(seconds: 5), () {
            if (Get.isDialogOpen ?? false) {
               Get.back();
            }
         });
      }
   }


   /// plan purchase api
   purchasePlanApi(String? planId,amount) async {

      try {
         Utils.showLoader();
         final response = await apiBaseHelper.postAPICall(Uri.parse(purchasePlanURL),langCode:languageCode.toString() ,  {
            "user_id":userId.toString(),
            "membership_plan_id":planId.toString(),
            "amount":amount.toString(),
         });

         Get.back();
         if (response["success"] == false) {
            Utils.mySnackBar(
               title: "Error Found",
               msg: response["message"] ?? "Something went wrong. Please try again.",
            );
         } else {
            Utils.mySnackBar(title: "Success", msg:response["message"]);
            trainerWisePlanApi();

         }
      } catch (error) {
         Get.back();
         Utils.mySnackBar(
            title: "Error",
            msg: error.toString(),
         );
      } finally {
         Future.delayed(const Duration(seconds: 5), () {
            if (Get.isDialogOpen ?? false) {
               Get.back();
            }
         });
      }
   }

   /// delete account
   Future<void> deleteAccountApi() async {
      try {
         Utils.showLoader();
         final response = await apiBaseHelper.postAPICall(Uri.parse(deleteAccountURL),langCode:languageCode.toString() ,  {
            "id":userId.toString(),
         });

         Get.back();
         if (response["error"] == false) {
            Utils.mySnackBar(
               title: "Error Found",
               msg: response["message"] ?? "Something went wrong. Please try again.",
            );
         } else {
            Utils.mySnackBar(title: "Success", msg: "User delete successfully");
            Get.to(() => const LoginScreen());
         }
      } catch (error) {
         Get.back();
         Utils.mySnackBar(
            title: "Error",
            msg: error.toString(),
         );
      } finally {
         Future.delayed(const Duration(seconds: 5), () {
            if (Get.isDialogOpen ?? false) {
               Get.back();
            }
         });
      }
   }

   ///get plan  api
   myPlanApi() async {
      isLoading1.value = true;
         dynamic response = await apiBaseHelper.postAPICall(Uri.parse(myPlanURl),langCode:languageCode.toString(),{"user_id":userId.toString()});
      userList.value = GetPlansModel.fromJson(response).user;
      isLoading1.value = false;

   }


   ///get trainer Wise Plan Api
   trainerWisePlanApi() async {
      isLoading2.value = true;
      dynamic response = await apiBaseHelper.postAPICall(Uri.parse(trainerWisePlanURL),langCode:languageCode.toString(),{"user_id":userId.toString(),"trainer_id":trainerId.toString()});
      videoPlanList.value = GetVideoPlanModel.fromJson(response).data;
      isLoading2.value = false;
   }


   ///get trainer details Api
   trainerDetailsApi() async {
      isLoading2.value = true;
      dynamic response = await apiBaseHelper.postAPICall(Uri.parse(trainerDetailsURL),langCode:languageCode.toString(),{"trainer_id":trainerId.toString()});
      tarinerData.value = GetTrainerDetailsModel.fromJson(response).data;
      isLoading2.value = false;
   }


   /// home Details Api
   homeDetailsApi(String?id) async {
      try {
         isLoadingDetails.value = true;
         dynamic response = await apiBaseHelper.postAPICall(Uri.parse(homeDetailsURL), {"id":id.toString()});
         GetDetailsModel getDetailsModel = GetDetailsModel.fromJson(response);
         detailsData.value = getDetailsModel.data;
         isLoadingDetails.value = false;
      } catch (error) {
         print("Error occurred: $error");
      } finally {
         isLoadingDetails.value = false;
      }
   }



   @override
   Future<void> refresh() async {
      getMemberShipPlan();
   }

}

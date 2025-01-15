// Package imports:

import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static SharedPreferences? prefs;

  ///get instance of the shared preferences
  static Future<void> getInstance() async {
    prefs = await SharedPreferences.getInstance();
  }

  //Set preferences
  ///set user logged in or not and user id in local
  static setLoginAndUserId(String userId) {
    prefs!.setBool("isLoggedIn", true);
    prefs!.setString("userId", userId);
  }

  //Set preferences
  ///set user logged in or not and user id in local
  static setLoginAndUserType(String userType) {
    prefs!.setString("userType", userType);
  }



  static setLanguageToPrefs(String languageCode) async {
     prefs?.setString('languageCode', languageCode);
  }


  static setTrainerIdPrefs(String trainerId) async {
    prefs?.setString('trainerId', trainerId);
  }

  static setTrainerImagePrefs(String trainerImage) async {
    prefs?.setString('trainerImage', trainerImage);
  }

  ///set user logged in or not and login id in local
  static setLoginId(String userLoginID) {
    prefs!.setString("userLogin", userLoginID);
  }





  ///set user logged out
  static setLogOut() {
    prefs!.setBool("isLoggedIn", false);
    prefs!.setString("userId", '');
    prefs!.setString("userType", '');
  }

  ///set first time as false
  static setFirstAsFalse() {
    prefs!.setBool("isFirstTime", false);
  }

  ///set cart item count
  static setCartItemCount(int count) {
    prefs!.setInt("cart_item_count", count);
  }

  //get preferences
  ///set first time as false
  static bool getFirstTime() {
    bool? isFirst = prefs!.getBool("isFirstTime");
    return isFirst ?? true;
  }

  ///get user logged in or not
  static bool getLogin() {
    bool? login = prefs!.getBool("isLoggedIn");
    return login ?? false;
  }

  ///get user logged in or not
    static String getUserId() {
    String? userId = prefs!.getString("userId");
    return userId ?? "";
  }

  /// get Language Code
  static String getLanguageToPrefs()  {
    String? languageCode = prefs!.getString("languageCode");
    return languageCode ?? "en";
  }

  /// get trainer id
  static String getTrainerToPrefs()  {
    String? trainerId = prefs!.getString("trainerId");
    return trainerId ?? "";
  }


  /// get trainer image
  static String getTrainerImagePrefs()  {
    String? trainerImage = prefs!.getString("trainerImage");
    return trainerImage ?? "";
  }



  static Future<void> initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  ///get user logged in or not
  static String getUserLoginId() {
    String? userLoginId = prefs!.getString("userLogin");
    return userLoginId ?? "";
  }

  ///get cart item count
  static int getCartItemCount() {
    final int? count = prefs!.getInt("cart_item_count");
    return count ?? -1;
  }
}

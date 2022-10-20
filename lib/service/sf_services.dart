import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefServices {
  //keys

  static String userLoggedInKey = "LOGGEDINKEY";
  static String userNameKey = "USERNAMEKEY";
  static String userEmailKey = "USEREMAILKEY";

  //saving data

  Future<bool?> setUserLoggedInStatus({required bool isLoggedIn}) async {
    SharedPreferences sf = await SharedPreferences.getInstance();

    return sf.setBool(userLoggedInKey, isLoggedIn);
  }

  Future<bool?> setUserName({required String userName}) async {
    SharedPreferences sf = await SharedPreferences.getInstance();

    return sf.setString(userNameKey, userName);
  }

  Future<bool?> setUserEmail({required String userEmail}) async {
    SharedPreferences sf = await SharedPreferences.getInstance();

    return sf.setString(userEmailKey, userEmail);
  }

  //getting data

  //  // status

  static Future<bool?> getUserLoggedInStatus() async {
    SharedPreferences sf = await SharedPreferences.getInstance();

    return sf.getBool(userLoggedInKey);
  }

  //  // username

  static Future<String?> getUserName() async {
    SharedPreferences sf = await SharedPreferences.getInstance();

    return sf.getString(userNameKey);
  }

  //  // useremail

  static Future<String?> getUserEmail() async {
    SharedPreferences sf = await SharedPreferences.getInstance();

    return sf.getString(userEmailKey);
  }
}

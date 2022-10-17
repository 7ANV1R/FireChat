import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefServices {
  //keys

  static String userLoggedInKey = "LOGGEDINKEY";
  static String userName = "USERNAMEKEY";
  static String userEmail = "USEREMAILKEY";

  //saving data

  //getting data

  static Future<bool?> getUserLoggedInStatus() async {
    SharedPreferences sf = await SharedPreferences.getInstance();

    return sf.getBool(userLoggedInKey);
  }
}

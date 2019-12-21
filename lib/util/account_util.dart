

import 'package:shared_preferences/shared_preferences.dart';
const cookieKey="cookie";
class AccountUtil{

  static getCookie () async {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    return prefs.getString(cookieKey);
  }


}
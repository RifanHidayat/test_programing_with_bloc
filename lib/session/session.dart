import 'package:shared_preferences/shared_preferences.dart';

class Session {
  void storeSave({var stores, var isLogin}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setString("stores", stores);
    sharedPreferences.setString("is_login", isLogin);
  }

  void logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }
}

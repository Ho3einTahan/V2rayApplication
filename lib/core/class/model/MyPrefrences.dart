import 'package:shared_preferences/shared_preferences.dart';

class MyPreferences {
  static Future<SharedPreferences> initPrefrences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences;
  }

  static writeUserIsLogin({required bool isLogin}) async {
    final preferences = await initPrefrences();
    preferences.setBool('isLogin', isLogin);
  }

  static Future<bool> readUserIsLogin() async {
    final preferences = await initPrefrences();
    return preferences.getBool('isLogin') ?? false;
  }

  static writePhoneNumberUser({required String phoneNumber}) async {
    final preferences = await initPrefrences();
    preferences.setString('phoneNumber', phoneNumber);
  }

  static Future<String> readPhoneNumberUser() async {
    final preferences = await initPrefrences();
    return preferences.getString('phoneNumber') ?? '';
  }
}

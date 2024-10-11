import 'package:shared_preferences/shared_preferences.dart';

class LocalData {
  // static Future<LoginPlatform> getLoginPlatform() async{
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   int platform = prefs.getInt('login_platform') ?? 0;
  //   if( platform < LoginPlatform.values.length || platform >= LoginPlatform.values.length) {
  //     return LoginPlatform.none;
  //   }
  //   return LoginPlatform.values[platform];
  // }

  // static void setLoginPlatform(LoginPlatform loginPlatform) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setInt('login_platform', loginPlatform.index);
  // }

  static Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? '';
  }

  static void setToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }
}

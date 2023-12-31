import 'package:shared_preferences/shared_preferences.dart';

class UserAuth {
  // save user name
  Future<void> setUser(String name) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('name', name);
  }

  // get user name
  static Future<String?> currentUser() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('name');
  }

  // logout
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('name');
  }

  // check if user is logged in
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString('name');
    return name != null;
  }
}

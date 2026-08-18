import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  // factory SharedPref {
  //   return preferences;
  // }

  // SharedPref._internal();

  // static final SharedPref preferences = SharedPref._internal();

  static late SharedPreferences sharedPreferences;

  ///Below method is to initialize the SharedPreference instance.
  static Future<dynamic> instantiatePreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  ///Below method is to return the SharedPreference instance.
  static SharedPreferences getPreferenceInstance() {
    return sharedPreferences;
  }

  ///Below method is to set the string value in the SharedPreferences.
  static Future<dynamic> setString(String key, String stringValue) async {
    await sharedPreferences.setString(key, stringValue);
  }

  ///Below method is to get the string value from the SharedPreferences.
  static String? getString(String key) {
    return sharedPreferences.getString(key);
  }

  ///Below method is to set the boolean value in the SharedPreferences.
  static Future<dynamic> setBoolean({
    required String key,
    required bool value,
  }) async {
    await sharedPreferences.setBool(key, value);
  }

  ///Below method is to get the boolean value from the SharedPreferences.
  static bool? getBoolean(String key) {
    return sharedPreferences.getBool(key);
  }

  static List<String>? getList(String key) {
    return sharedPreferences.getStringList(key);
  }

  static Future<dynamic> setList(String key, List<String> value) {
    return sharedPreferences.setStringList(key, value);
  }

  ///Below method is to set the double value in the SharedPreferences.
  static Future<dynamic> setDouble(String key, double doubleValue) async {
    await sharedPreferences.setDouble(key, doubleValue);
  }

  ///Below method is to set the double value from the SharedPreferences.
  static double? getDouble(String key) {
    return sharedPreferences.getDouble(key);
  }

  ///Below method is to set the int value in the SharedPreferences.
  static Future<dynamic> setInt(String key, int intValue) async {
    await sharedPreferences.setInt(key, intValue);
  }

  ///Below method is to get the int value from the SharedPreferences.
  static int? getInt(String key) {
    return sharedPreferences.getInt(key);
  }

  ///Below method is to remove the received preference.
  static Future<dynamic> removePreference(String key) async {
    await sharedPreferences.remove(key);
  }

  ///Below method is to check the availability of the received preference .
  static bool containPreference(String key) {
    if (sharedPreferences.get(key) == null) {
      return false;
    } else {
      return true;
    }
  }

  ///Below method is to clear the SharedPreference.
  static Future<dynamic> clearPreferences() async {
    await sharedPreferences.clear();
  }
}

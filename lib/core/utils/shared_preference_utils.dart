import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtils {
  static Future<void> setStringValue(
      {required String key, required String value}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  static Future<void> setIntValue(
      {required String key, required int value}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(key, value);
  }

  static Future<int?> getIntValue({required String key}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key);
  }

  static Future<String?> getStringValue({required String key}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static Future<void> setBoolValue(
      {required String key, required bool value}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  static Future<bool?> getBoolValue({required String key}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    log("PREFS = ${prefs}");
    return prefs.getBool(key);
  }

  static Future<void> removeValue({required String key}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(key)) {
      await prefs.remove(key);
    }
  }

  static Future<void> clearAll() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}

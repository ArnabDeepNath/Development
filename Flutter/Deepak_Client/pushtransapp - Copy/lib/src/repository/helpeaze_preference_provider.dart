import 'package:shared_preferences/shared_preferences.dart';

class PreferenceProvider {
  static late SharedPreferences prefs;

  static Future<PreferenceProvider> getInstance() async {
    prefs = await SharedPreferences.getInstance();
    return PreferenceProvider();
  }

  void storeStringPreference(String key, String value) {
    prefs.setString(key, value);
  }

  String getStringPreference(String key) {
    return prefs.getString(key) ?? '';
  }

  void storeBoolPreference(String key, bool value) {
    prefs.setBool(key, value);
  }

  bool getBoolPreference(String key) {
    return prefs.getBool(key) ?? false;
  }

  Future<bool> clearPreferenceData() {
    return prefs.clear();
  }
}

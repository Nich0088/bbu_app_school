import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static const String authorizeTokenData = "authorize.token.data";
  static const String loginResultData = "user.profile.data";
  static const String userTypeData = "user.type.data";
  static const String universityBranchData = "university.branch.data";

  static SharedPreferences? _prefs;

  static Future<SharedPreferences> init() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs!;
  }

  static Future<void> storeData({String? key, dynamic value}) async {
    if (value.runtimeType == String) {
      await _prefs!.setString(key!, value);
    } else if (value.runtimeType == int) {
      await _prefs!.setInt(key!, value);
    } else if (value.runtimeType == bool) {
      await _prefs!.setBool(key!, value);
    } else if (value.runtimeType == double) {
      await _prefs!.setDouble(key!, value);
    } else {
      _prefs!.setStringList(key!, value);
    }
  }

  static Future<int?> getIntValue({String? key}) async {
    return _prefs!.getInt(key!);
  }

  static Future<String?> getStringValue({String? key}) async {
    return _prefs!.getString(key!);
  }

  static Future<bool?> getBooleanValue({String? key}) async {
    return _prefs!.getBool(key!);
  }

  static Future<double?> getDoubleValue({String? key}) async {
    return _prefs!.getDouble(key!);
  }

  static Future<void> clearLocalData() async {
    await _prefs?.remove(LocalStorage.loginResultData);
    await _prefs?.remove(LocalStorage.authorizeTokenData);
    await _prefs?.remove(LocalStorage.userTypeData);
    await _prefs?.remove(LocalStorage.universityBranchData);
  }
}

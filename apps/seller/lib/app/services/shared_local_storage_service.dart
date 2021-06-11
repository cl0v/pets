import 'package:shared_preferences/shared_preferences.dart';
import 'package:commons/commons.dart';

class SharedLocalStorageService implements ILocalStorage {
  @override
  Future delete(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }

  @override
  Future get(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get(key);
  }

  @override
  Future put(String key, dynamic value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final type = value.runtimeType;
    if (type is String) return prefs.setString(key, value);
    if (type is int) return prefs.setInt(key, value);
    if (type is bool) return prefs.setBool(key, value);
    if (type is double) return prefs.setDouble(key, value);
    if (type is List<String>) return prefs.setStringList(key, value);
  }
}

class Prefs {
  static Future delete(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }

  static Future get(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get(key);
  }

  static Future put(String key, dynamic value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    switch (value.runtimeType) {
      case String:
        return prefs.setString(key, value);
      case bool:
        return prefs.setBool(key, value);
      case int:
        return prefs.setInt(key, value);
      case double:
        return prefs.setDouble(key, value);
      case List:
        return prefs.setStringList(key, value);
    }
    return null;
  }
}

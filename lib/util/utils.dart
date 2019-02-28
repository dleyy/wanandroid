import 'package:shared_preferences/shared_preferences.dart';

class Utils {
  static save(String key, dynamic value) async {
    SharedPreferences pre = await SharedPreferences.getInstance();
    if (value is String) {
      pre.setString(key, value);
    } else if (value is bool) {
      pre.setBool(key, value);
    } else if (value is List) {
      pre.setStringList(key, value);
    }
  }

  static get(String key) async {
    SharedPreferences pre = await SharedPreferences.getInstance();
    return pre.get(key);
  }
}
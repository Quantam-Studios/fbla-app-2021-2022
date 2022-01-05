import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SharedPref {
  read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString(key) != null) {
      return json.decode(prefs.getString(key) ?? 'Missing');
    } else {
      print('read($key) Failed');
      return 'Failed';
    }
  }

  save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  test(String key) async {
    final prefs = await SharedPreferences.getInstance();
    print(json.decode(prefs.getString(key) ?? 'Missing').toString());
  }
}

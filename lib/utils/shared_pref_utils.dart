import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> setToPreference(String name, dynamic value) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setString(name, json.encode(value));
}

Future<dynamic> getFromPreference(String name) async {
  print('i am 000->$name');
  SharedPreferences pref = await SharedPreferences.getInstance();
  String? result = pref.getString(name);
  print('i am 00->$result');
  return result != null ? json.decode(result) : null;
}

Future<void> clearPref({String? keyName}) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  keyName == null ? pref.clear() : pref.remove(keyName);
}

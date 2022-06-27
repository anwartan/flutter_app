import 'dart:ffi';

import 'package:shared_preferences/shared_preferences.dart';

class CustomSharedPreferences {

  static const String keyValue = "value";
  static const String keyExampleModel = "exampleModel";
  static const String keyUserValue = 'USER';

  Future<SharedPreferences> getPreferences() async =>
      await SharedPreferences.getInstance();

  Future<bool> setValue(String keyValue,String value) async {
    return (await getPreferences()).setString(keyValue, value);
  }
  Future<bool> setAuthValue(String value) async{
    return (await getPreferences()).setString(keyUserValue, value);
  }

  Future<String?> getValue(String keyValue) async => (await getPreferences()).getString(keyValue);

  Future<String?> getAuthValue() async => (await getPreferences()).getString(keyUserValue);

  Future<bool> removeAuth() async => (await getPreferences()).remove(keyUserValue);
}
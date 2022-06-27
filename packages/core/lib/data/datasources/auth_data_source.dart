import 'dart:convert';

import 'package:core/core.dart';
import 'package:core/data/models/auth_model.dart';


abstract class AuthDataSource {
  Future<bool> login(AuthModel authModel);
  Future<bool> logout();
  Future<AuthModel?> currentUser();
}

class AuthDataSourceImpl extends AuthDataSource{
  final CustomSharedPreferences customSharedPreferences;

  AuthDataSourceImpl({required this.customSharedPreferences});

  @override
  Future<bool> login(AuthModel authModel) {
    return customSharedPreferences.setAuthValue(json.encode(authModel.toJson()));
  }

  @override
  Future<bool> logout() {
    return customSharedPreferences.removeAuth();

  }
  @override
  Future<AuthModel?> currentUser() async {

    final json =  (await customSharedPreferences.getAuthValue());
    if(json!=null){
      return Future.value(AuthModel.fromJson(jsonDecode(json)));
    }
    return Future.value(null);
  }

}
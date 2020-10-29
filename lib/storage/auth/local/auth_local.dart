import 'package:orim/model/auth/auth.dart';
import 'package:orim/model/infologin/info_login.dart';

abstract class AuthLocal {
  Future<bool> saveAuthToStorage({AuthModel authModel});
  Future<bool> removeAuthAtStorage();
  Future<AuthModel> getAuth();

  Future<bool> saveInfoLoginAtStorage({InfoLogin infoLogin});
  Future<bool> saveStatusLogin({bool logged});
  Future<bool> readStatusLogin();
  Future<void> saveRememberLogin({bool remembered});
  Future<bool> readRememberLogin();
  Future<bool> removeInfoLoginAtStorage();
  Future<InfoLogin> getInfoLoginToStorage();
}
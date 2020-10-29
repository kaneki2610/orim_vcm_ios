import 'package:orim/model/auth/auth.dart';
import 'package:orim/model/info_after_login.dart';
import 'package:orim/model/infologin/info_login.dart';

abstract class AuthRepo {
  Future<InfoAfterLogin> login({ String username, String password, String deviceId });
  Future<bool> logout();

  Future<AuthModel> getAuth();
  Future<bool> saveAuth({AuthModel model});
  Future<bool> removeAuth();

  Future<bool> saveInfoLogin({ String username, String password});
  Future<bool> saveStatusLogin({bool checked});
  Future<bool> readStatusLogin();
  Future<void> saveStatusRememberLogin({bool checked});
  Future<bool> readStatusRememberLogin();
  Future<InfoLogin> getInfoLogin();
  Future<bool> removeInfoLogin();
}
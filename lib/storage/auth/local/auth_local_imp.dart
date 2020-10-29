import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orim/model/auth/auth.dart';
import 'package:orim/model/infologin/info_login.dart';
import 'package:orim/storage/auth/local/auth_local.dart';
import 'package:orim/utils/storage/storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalImp implements AuthLocal {

  Storage storage;
  final String keyAuth = 'auth';
  final String keyInfoLogin = 'infoLogin';
  final String isChecked = 'login';
  final String isRemember = 'remembered';


  @override
  Future<bool> saveAuthToStorage({AuthModel authModel}) async {
    return await storage.writeObject(keyAuth, authModel.toJson());
  }

  @override
  Future<bool> saveStatusLogin({bool logged}) async{
    final prefs = await SharedPreferences.getInstance();
    final key = isChecked;
    final value = logged;
    return await prefs.setBool(key, value);
  }
  @override
  Future<bool> readStatusLogin() async{
    final prefs = await SharedPreferences.getInstance();
    final key = isChecked;
    final value = prefs.getBool(key) ?? false;
    return value;
  }

  //
  @override
  Future<void> saveRememberLogin({bool remembered}) async{
    Map<String, dynamic> map = Map.from({
      isRemember: remembered
    });
    await storage.writeObject(isRemember, map);
  }
  @override
  Future<bool> readRememberLogin() async {
    try {
      final Map<String, dynamic> map = await storage.readObject(isRemember);
      if (map != null) {
        if (map[isRemember] is bool) {
          final bool res = map[isRemember] as bool;
          return res;
        }
      }
      return false;
    } catch (err) {
      print(err);
      return false;
    }
  }
  @override
  Future<AuthModel> getAuth() async {
    Map<String, dynamic> json;
    try {
      json = await storage.readObject(keyAuth);
    } catch (err) {
      return null;
    }
    if (json != null) {
      return AuthModel.fromJson(json);
    } else {
      return null;
    }
  }

  @override
  Future<InfoLogin> getInfoLoginToStorage() async {
    Map<String, dynamic> map = await storage.readObject(keyInfoLogin);
    if (map != null) {
      return InfoLogin.fromJson(map);
    } else {
      return null;
    }
  }

  @override
  Future<bool> saveInfoLoginAtStorage({InfoLogin infoLogin}) async {
    return await storage.writeObject(keyInfoLogin, infoLogin.toJson());
  }

  @override
  Future<bool> removeAuthAtStorage() async {
    return await storage.delete(keyAuth);
  }

  @override
  Future<bool> removeInfoLoginAtStorage() async {
    return await storage.delete(keyInfoLogin);
  }
}

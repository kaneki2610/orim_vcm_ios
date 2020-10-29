import 'package:orim/model/user_info_data/user_info_data.dart';
import 'package:orim/storage/user_info/local/user_info_local.dart';
import 'package:orim/utils/storage/storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserInfoLocalImp implements UserInfoLocal {

  Storage storage;
  final String keyInfoUser = "user";
  final String keyInfoResident = "resident";
  final String saveAccountUser = 'save_account_user';

  @override
  Future<bool> saveInfoUser({UserInfoData userInfoData}) async {
    return await storage.writeObject(keyInfoUser, userInfoData.toJson());
  }

  @override
  Future<bool> saveInfoResident({ResidentInfoData residentInfoData}) async {
    // TODO: implement saveInfoResident
    return await storage.writeObject(keyInfoResident, residentInfoData.toJson());
  }

  @override
  Future<UserInfoData> loadInfoUser() async {
    Map<String, dynamic> json;
    try {
      json = await storage.readObject(keyInfoUser);
    } catch (err) {
      return null;
    }
    if (json != null) {
      return UserInfoData.fromJson(json);
    } else {
      return null;
    }
  }

  @override
  Future<ResidentInfoData> loadInfoResident() async {
    Map<String, dynamic> json;
    try {
      json = await storage.readObject(keyInfoResident);
    } catch (err) {
      return null;
    }
    if (json != null) {
      return ResidentInfoData.fromJson(json);
    } else {
      return null;
    }
  }

  @override
  Future<bool> saveUserAccount({String idUser}) async {
    final prefs = await SharedPreferences.getInstance();
    final key = saveAccountUser;
    final value = idUser;
    return await prefs.setString(key, value);
  }

  @override
  Future<String> getIdUserAccount() async {
    final prefs = await SharedPreferences.getInstance();
    final key = saveAccountUser;
    final value = prefs.getString(key) ?? "";
    return value;
  }

}

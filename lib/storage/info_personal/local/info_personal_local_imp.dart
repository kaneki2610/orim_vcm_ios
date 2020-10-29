import 'package:flutter/cupertino.dart';
import 'package:orim/model/personal_info/personal_info.dart';
import 'package:orim/storage/info_personal/local/info_personal_local.dart';
import 'package:orim/utils/storage/storage.dart';

class InfoPersonalLocalImp implements InfoPersonalLocal {

  Storage storage;
  final String keyUserInfoPersonal = 'userInfo';

  @override
  Future<bool> saveInfoUserPersonal({PersonalInfoModel personalInfo}) async {
    return await storage.writeObject(
      keyUserInfoPersonal, personalInfo.toJson());
  }

  @override
  Future<bool> removeInfoUserPersonal() async {
    return await storage.delete(keyUserInfoPersonal);
  }

  @override
  Future<PersonalInfoModel> getInfoUserPersonal() async {
    Map<String, dynamic> json;
    try {
      json = await storage.readObject(
        keyUserInfoPersonal);
    } catch (err) {
      return null;
    }
    if (json != null) {
      return PersonalInfoModel.fromJson(json);
    } else {
      return null;
    }
  }

}
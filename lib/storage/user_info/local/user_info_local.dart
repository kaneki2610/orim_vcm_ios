import 'package:orim/model/user_info_data/user_info_data.dart';

abstract class UserInfoLocal {
  Future<bool> saveInfoUser({UserInfoData userInfoData});
  Future<bool> saveInfoResident({ResidentInfoData residentInfoData});
  Future<UserInfoData> loadInfoUser();
  Future<ResidentInfoData> loadInfoResident();
  Future<bool> saveUserAccount({String idUser});
  Future<String> getIdUserAccount();
}
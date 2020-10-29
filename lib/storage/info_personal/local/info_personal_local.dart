import 'package:orim/model/personal_info/personal_info.dart';

abstract class InfoPersonalLocal {
  Future<bool> saveInfoUserPersonal({PersonalInfoModel personalInfo});
  Future<PersonalInfoModel> getInfoUserPersonal();
  Future<bool> removeInfoUserPersonal();
}
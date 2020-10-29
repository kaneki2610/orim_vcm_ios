import 'package:orim/model/personal_info/personal_info.dart';

abstract class InfoPersonalRepo {
  Future<PersonalInfoModel> getInfoUserPersonal();
  Future<bool> saveInfoPersonal({PersonalInfoModel model});

  Future<bool> removeInfoPersonal();
}
import 'package:orim/model/personal_info/personal_info.dart';
import 'package:orim/repositories/info_personal/info_personal_repo.dart';
import 'package:orim/storage/info_personal/local/info_personal_local.dart';

class InfoPersonalRepoImp implements InfoPersonalRepo {

  InfoPersonalLocal infoPersonalLocal;

  @override
  Future<PersonalInfoModel> getInfoUserPersonal() async {
    PersonalInfoModel personalInfoModel =
        await infoPersonalLocal.getInfoUserPersonal();
    return personalInfoModel;
  }

  @override
  Future<bool> saveInfoPersonal({PersonalInfoModel model}) async {
    return await infoPersonalLocal.saveInfoUserPersonal(personalInfo: model);
  }

  @override
  Future<bool> removeInfoPersonal() async {
    return await infoPersonalLocal.removeInfoUserPersonal();
  }
}

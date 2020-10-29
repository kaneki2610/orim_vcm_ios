import 'package:orim/base/viewmodel.dart';
import 'package:orim/model/personal_info/personal_info.dart';
import 'package:orim/repositories/info_personal/info_personal_repo.dart';

class UserInfoPersonalViewModel extends BaseViewModel<PersonalInfoModel> {

  InfoPersonalRepo infoPersonalRepo;

  Future<PersonalInfoModel> getUserInfo() async {
    if (data != null) {
      return data;
    }
    try {
      data = await infoPersonalRepo.getInfoUserPersonal();
    } catch (err) {
      print(err);
      data = null;
    }
    return data;
  }

  void reset() async {
    await infoPersonalRepo.removeInfoPersonal();
    data = null;
  }

  Future<bool> saveInfoPersonal({PersonalInfoModel model}) async {

    if(model == null){
      model = PersonalInfoModel(name: "", phoneNumber: "");
    }
    data = model;
      await infoPersonalRepo.saveInfoPersonal(model: model);
    return true;
  }
}

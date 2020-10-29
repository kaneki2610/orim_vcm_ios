import 'package:orim/base/base_reponse.dart';
import 'package:orim/entities/change_password/change_pass_model.dart';
import 'package:orim/repositories/change_pass/change_pass_repo.dart';
import 'package:orim/storage/user_info/remote/change_password/change_pass_remote.dart';

class ChangePassImp implements ChangePassRepo {
  ChangePasswordRemote changePasswordRemote;

  @override
  Future<bool> changePassword({String password, String token}) async {
    bool isUpdateSuccess = false;
    ResponseObject<ChangePassModel> changePassResponse;
    changePassResponse = await changePasswordRemote.changePassword(
        password: password, token: token);
    if (changePassResponse.isSuccess()) {
      if (changePassResponse.data.status == 1) {
        print(
            "----------password ${changePassResponse.data.password}  ${changePassResponse.data.username}");
        isUpdateSuccess = true;
      } else {
        isUpdateSuccess = false;
      }
    } else {
      isUpdateSuccess = false;
    }
    return isUpdateSuccess;
  }
}

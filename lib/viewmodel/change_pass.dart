
import 'package:orim/base/viewmodel.dart';
import 'package:orim/model/auth/auth.dart';
import 'package:orim/repositories/auth/auth_repo.dart';
import 'package:orim/repositories/change_pass/change_pass_repo.dart';

class ChangePasswordViewModel extends BaseViewModel {
  ChangePassRepo changePassRepo;
  AuthRepo authRepo;

  Future<bool> changePassword({String password}) async {
    AuthModel auth = await authRepo.getAuth();
    return await changePassRepo.changePassword(password: password, token: auth?.token);
  }
}
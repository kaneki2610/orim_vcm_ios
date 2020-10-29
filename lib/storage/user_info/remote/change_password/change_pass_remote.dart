import 'package:orim/base/base_reponse.dart';
import 'package:orim/entities/change_password/change_pass_model.dart';

abstract class ChangePasswordRemote {
  Future<ResponseObject<ChangePassModel>> changePassword({String password, String token});
}
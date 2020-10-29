import 'package:orim/base/base_reponse.dart';
import 'package:orim/entities/create_account/create_account_model.dart';

abstract class CreateAccountRemote {
  Future<ResponseObject<CreateAccountModel>> createAccount({String phone, String name, String organizationId});
}
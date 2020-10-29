import 'package:orim/base/base_reponse.dart';
import 'package:orim/entities/create_account/create_account_model.dart';
import 'package:orim/model/organization_permission/organization_permisstion.dart';

abstract class UserRemote {
  Future<ResponseObject<OrganizationModel>> createOrganization({String areaCode});
  Future<ResponseObject<bool>> updateAccount({String idUser, String fullname, String password});
  Future<ResponseObject<CreateAccountModel>> getInfoResident(
      {String phone});
}

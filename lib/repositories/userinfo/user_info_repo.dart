import 'package:orim/base/base_reponse.dart';
import 'package:orim/entities/create_account/create_account_model.dart';
import 'package:orim/model/organization_permission/organization_permisstion.dart';
import 'package:orim/model/user_info_data/user_info_data.dart';

abstract class UserInfoRepo {
  Future<bool> saveInfo(String name, String identify, String phone,
      String enterprise, String address);

  Future<UserInfoData> loadInfo();

  Future<bool> saveInfoResident(String name, String identify, String phone,
      String enterprise, String address);

  Future<ResidentInfoData> loadInfoResident();

  Future<ResponseObject<CreateAccountModel>> createAccount(String phone,
      String name, String organizationId);

  Future<bool> saveUserAccount({String idUser});

  Future<String> getIdUserAccount();

  Future<ResponseObject<OrganizationModel>> createOrganization(
      {String areaCode});

  Future<ResponseObject<bool>> updateAccount(
      {String idUser, String fullname, String password});

  Future<ResponseObject<CreateAccountModel>> getInfoResident({String phone});
}
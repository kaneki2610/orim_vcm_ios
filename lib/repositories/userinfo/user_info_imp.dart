import 'package:orim/base/base_reponse.dart';
import 'package:orim/entities/create_account/create_account_model.dart';
import 'package:orim/model/organization_permission/organization_permisstion.dart';
import 'package:orim/model/user_info_data/user_info_data.dart';
import 'package:orim/repositories/userinfo/user_info_repo.dart';
import 'package:orim/storage/user_info/local/user_info_local.dart';
import 'package:orim/storage/user_info/remote/create_account/create_account_remote.dart';
import 'package:orim/storage/user_info/remote/user_remote.dart';

class UserInfoImp implements UserInfoRepo {
  UserInfoLocal userInfoLocal;
  CreateAccountRemote createAccountRemote;
  UserRemote userRemote;


  @override
  Future<bool> saveInfo(String name, String identify, String phone,
      String enterprise, String address) async {
    var temp = UserInfoData(
        name: name,
        phone: phone,
        identify: identify,
        enterprise: enterprise,
        address: address);
    return await userInfoLocal.saveInfoUser(userInfoData: temp);
  }

  @override
  Future<bool> saveInfoResident(String name, String identify, String phone, String enterprise, String address) async {
    var temp = ResidentInfoData(
        name: name,
        phone: phone,
        identify: identify,
        enterprise: enterprise,
        address: address);
    return await userInfoLocal.saveInfoResident(residentInfoData: temp);
  }

  @override
  Future<UserInfoData> loadInfo() async {
    return await userInfoLocal.loadInfoUser();
  }

  @override
  Future<ResidentInfoData> loadInfoResident() async {
    // TODO: implement loadInfoResident
    return await userInfoLocal.loadInfoResident();
  }

  @override
  Future<ResponseObject<CreateAccountModel>> createAccount(String phone, String name, String organizationId) async {
    ResponseObject<CreateAccountModel> response;
    response = await createAccountRemote.createAccount(phone: phone, name:name, organizationId: organizationId);
//    if(response.isSuccess()) {
//      if (response.data.status == 0) {
//        isCreateAccountSuccess = true;
//      } else {
//        isCreateAccountSuccess = false;
//      }
//    } else {
//      isCreateAccountSuccess = false;
//    }
    return response;
  }

  @override
  Future<String> getIdUserAccount() async {
    return await userInfoLocal.getIdUserAccount();
  }

  @override
  Future<bool> saveUserAccount({String idUser}) async {
    return await userInfoLocal.saveUserAccount(idUser: idUser);
  }

  @override
  Future<ResponseObject<OrganizationModel>> createOrganization({String areaCode}) {
      return this.userRemote.createOrganization(areaCode: areaCode);
  }

  @override
  Future<ResponseObject<bool>> updateAccount({String idUser, String fullname, String password}) async {
   return await this.userRemote.updateAccount(idUser: idUser, fullname: fullname, password: password);
  }

  @override
  Future<ResponseObject<CreateAccountModel>> getInfoResident({String phone}) async {
    return await this.userRemote.getInfoResident(phone: phone);
  }
}

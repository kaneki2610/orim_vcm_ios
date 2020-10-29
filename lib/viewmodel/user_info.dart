import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:orim/base/base_reponse.dart';
import 'package:orim/base/viewmodel.dart';
import 'package:orim/entities/create_account/create_account_model.dart';
import 'package:orim/model/organization_permission/organization_permisstion.dart';
import 'package:orim/model/user_info_data/user_info_data.dart';
import 'package:orim/repositories/userinfo/user_info_repo.dart';

class UserInfoViewModel extends BaseViewModel<UserInfoData> {
  UserInfoRepo userInfoRepo;

  Future<void> loadData() async {
    print('data != null');
    if (data == null) {
      try {
        data = await userInfoRepo.loadInfo();
      } catch (err) {
        print('err $err');
      }
    }
  }

  Future<bool> saveInfo(String name, String identify, String phone,
      String enterprise, String address) async {
    return await userInfoRepo.saveInfo(
        name, identify, phone, enterprise, address);
  }

  Future<ResponseObject<CreateAccountModel>> createAccount(
      String phone, String name, String organizationId) async {
    return await userInfoRepo.createAccount(phone, name, organizationId);
  }

  // save account user
  Future<bool> saveAccount(String idUser) async {
    return userInfoRepo.saveUserAccount(idUser: idUser);
  }

  Future<String> isSavedAccount() async {
    return userInfoRepo.getIdUserAccount();
  }

  Future<bool> createUserAccount(
      String phone, String name, String areaCode, bool isUpdate) async {
    String userId = await this.userInfoRepo.getIdUserAccount();
    if (isUpdate) {
      this.saveAccount("");
      userId = "";
    }
    if (userId == "") {
      ResponseObject<OrganizationModel> org =
          await this.createOrganization(areaCode: areaCode);
      if (org.isSuccess()) {
        ResponseObject<CreateAccountModel> res =
            await this.createAccount(phone, name, org.data.id);
        if ((res.data?.idUser != null && res.data?.idUser != "")) {
          this.saveAccount(res.data.idUser);
          return true;
        } else if (res.data.isExistAccount()){
          ResponseObject<CreateAccountModel> res = await this.getInfoResident(phone: phone);
          if(res.isSuccess()){
            if(res.isSuccess()){
              if ((res.data?.idUser != null && res.data?.idUser != "")) {
                userId = res.data.idUser;
                this.saveAccount(res.data.idUser);
                ResponseObject<bool> responseObject = await this
                    .updateAccount(idUser: userId, fullname: name, password: "Vnpt@123");
                return responseObject.isSuccess()
                    ? responseObject.data
                    : responseObject.isSuccess();
              }
            }
            return false;
          }
        }else{
          return false;
        }
      } else {
        return false;
      }
    } else {
      ResponseObject<bool> responseObject = await this
          .updateAccount(idUser: userId, fullname: name, password: "Vnpt@123");
      return responseObject.isSuccess()
          ? responseObject.data
          : responseObject.isSuccess();
    }
  }

  Future<ResponseObject<OrganizationModel>> createOrganization(
      {String areaCode}) {
    return this.userInfoRepo.createOrganization(areaCode: areaCode);
  }

  Future<ResponseObject<bool>> updateAccount(
      {String idUser, String fullname, String password}) async {
    ResponseObject<bool> responseObject = await this
        .userInfoRepo
        .updateAccount(password: password, idUser: idUser, fullname: fullname);
    return responseObject;
  }

  Future<ResponseObject<CreateAccountModel>> getInfoResident(
      {String phone}) async {
    return await this.userInfoRepo.getInfoResident(phone: phone);
  }

  void reset() {
    data = null;
  }
}

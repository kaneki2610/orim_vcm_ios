import 'package:flutter/cupertino.dart';
import 'package:orim/base/viewmodel.dart';
import 'package:orim/config/app_config.dart';
import 'package:orim/model/auth/auth.dart';
import 'package:orim/model/device_vcm/deviceId_vcm_request.dart';
import 'package:orim/model/info_after_login.dart';
import 'package:orim/model/infologin/info_login.dart';
import 'package:orim/repositories/auth/auth_repo.dart';
import 'package:orim/repositories/department/department_repo.dart';
import 'package:orim/repositories/info_personal/info_personal_repo.dart';
import 'package:orim/services/notification.dart';

class AuthViewModel extends BaseViewModel<AuthModel> {
  AuthRepo authRepo;
  DepartmentRepo departmentRepo;
  NotificationService notificationService = NotificationService.getInstance();

  Future<InfoAfterLogin> login({String username, String password}) async {
    String tokenVcm = await notificationService.tokenVcm;
    DeviceVcmRequest deviceVcmRequest = DeviceVcmRequest(deviceId: tokenVcm, plushKey: AppConfig.apiKeyVcm);
    final InfoAfterLogin response = await authRepo.login(
        username: username,
        password: password,
        deviceId: await notificationService.token,
        deviceIdVcm: deviceVcmRequest);
    if (response != null) {
      data = response.authModel;
//      if (saveCache) {
//        await saveInfoLoginLocal(username,password);
//      }
      await authRepo.saveAuth(model: response.authModel);
      await departmentRepo.saveOwnerDepartments(
          accountId: response.authModel.accountId, list: response.departments);
    }
    return response;
  }

  Future<InfoLogin> getInfoLogin() async {
    return await authRepo.getInfoLogin();
  }

  // save info login to local
  Future<bool> saveInfoLoginLocal(String username, String password) async {
    return await authRepo.saveInfoLogin(username: username, password: password);
  }

  // save status  login
  Future<bool> saveStatus(bool status) async {
    return authRepo.saveStatusLogin(checked: status);
  }

  //read status login
  Future<bool> readStatus() async {
    return authRepo.readStatusLogin();
  }

  // save status remember login
  Future<void> saveStatusRemember(bool status) async {
    return authRepo.saveStatusRememberLogin(checked: status);
  }

  //read status remember login
  Future<bool> readStatusRemember() async {
    return authRepo.readStatusRememberLogin();
  }

  Future<bool> logout({bool forceLogout = false}) async {
    AuthModel authModel = await authRepo.getAuth();
    bool res = false;
    if (!forceLogout) {
      res = await authRepo.logout();
      if (res) {
        data = null;
//        await authRepo.removeInfoLogin();
        await departmentRepo.removeOwnerDepartment(
            accountId: authModel.accountId);
      }
    } else {
      res = true;
      data = null;
      //await authRepo.removeInfoLogin();
      await authRepo.removeAuth();
      await departmentRepo.removeOwnerDepartment(
          accountId: authModel.accountId);
    }
    return res;
  }

  Future<AuthModel> getAuth() async {
    if (data != null) {
      return data;
    } else {
      data = await authRepo.getAuth();
    }
    if(data == null){

    }else{

    }
    return data;
  }

  Future<bool> removeAuth() async {
    this.data = null;
    return await authRepo.removeAuth();
  }

}

import 'package:orim/base/base_reponse.dart';
import 'package:orim/entities/logout/logout_request.dart';
import 'package:orim/entities/logout/logout_response.dart';
import 'package:orim/entities/signin/sign_in_request.dart';
import 'package:orim/entities/signin/sign_in_response.dart';
import 'package:orim/model/auth/auth.dart';
import 'package:orim/model/department/department.dart';
import 'package:orim/model/device_vcm/deviceId_vcm_request.dart';
import 'package:orim/model/info_after_login.dart';
import 'package:orim/model/infologin/info_login.dart';
import 'package:orim/model/personal_info/personal_info.dart';
import 'package:orim/repositories/auth/auth_repo.dart';
import 'package:orim/storage/auth/local/auth_local.dart';
import 'package:orim/storage/auth/remote/auth_remote.dart';

class AuthImp implements AuthRepo {
  AuthLocal authLocal;
  AuthRemote authRemote;

  AuthModel _authModel;

  @override
  Future<InfoAfterLogin> login(
      {String username, String password, String deviceId, DeviceVcmRequest deviceIdVcm}) async {
    final SignInRequest request = SignInRequest(
        userName: username, password: password, deviceId: deviceId, deviceVcmRequest: deviceIdVcm);

    ResponseObject<SignInModel> signInResponse = await authRemote.login(request: request);

    if(signInResponse.isSuccess()) {
      if(signInResponse.data != null){
        final _personalInfoModel = await _saveInfoUser(signInResponse.data);
        final _departments = _saveInfoDepartment(signInResponse.data);
        if(_departments.length > 0) {
          _personalInfoModel.departmentName = _departments[0].name;
        }
        _authModel = _saveInfoAuth(signInResponse.data);
        return InfoAfterLogin(
            authModel: _authModel,
            departments: _departments,
            personalInfoModel: _personalInfoModel);
      }

    } else {
      return null;
    }
  }

  @override
  Future<AuthModel> getAuth() async {
    if (_authModel == null) {
      _authModel = await authLocal.getAuth();
    }
    return _authModel;
  }

  @override
  Future<bool> saveInfoLogin({String username, String password}) async {
    final InfoLogin infoLogin =
        InfoLogin(username: username, password: password);
    return await authLocal.saveInfoLoginAtStorage(infoLogin: infoLogin);
  }

  @override
  Future<bool> saveStatusLogin({bool checked}) async{
    // TODO: implement saveStatusLogin
    return await authLocal.saveStatusLogin(logged: checked);
  }
  @override
  Future<bool> readStatusLogin() {
    // TODO: implement readStatusLogin
    return authLocal.readStatusLogin();
  }
  @override
  Future<InfoLogin> getInfoLogin() async {
    return await authLocal.getInfoLoginToStorage();
  }

  @override
  Future<void> saveStatusRememberLogin({bool checked}) {
    // TODO: implement saveStatusRememberLogin
    return authLocal.saveRememberLogin(remembered: checked);
  }
  @override
  Future<bool> readStatusRememberLogin() {
    // TODO: implement readStatusRememberLogin
    return authLocal.readRememberLogin();
  }

  @override
  Future<bool> logout() async {
    AuthModel authModel = _authModel ?? await authLocal.getAuth();
    LogoutRequest request = LogoutRequest();
    LogoutResponse logoutResponse =
        await authRemote.logout(request: request, token: authModel.token);
    if (logoutResponse.succeed) {
      bool remove = await authLocal.removeAuthAtStorage();
      print("Removed: " + remove.toString());
//      await removeInfoLogin();
//     await _infoPersonalLocal.removeInfoUserPersonal();
      return true;
    } else {
      if (logoutResponse.errors != null) {
        String error = '';
        for (final err in logoutResponse.errors) {
          error = error + '$err,';
        }
        throw 'logout error $error';
      } else {
        throw 'unknown';
      }
    }
  }

  Future<PersonalInfoModel> _saveInfoUser(SignInModel signInModel) async {
    return PersonalInfoModel(
      id: signInModel.personalInformation?.id,
      name: signInModel.fullName,
      email: signInModel.personalInformation?.email ?? "",
      address: signInModel.personalInformation?.address ?? "",
      phoneNumber: signInModel.personalInformation?.phoneNumber ?? "",
      loginName: signInModel.userName
    );
  }

  AuthModel _saveInfoAuth(SignInModel signInModel) {
    return AuthModel(
        token: signInModel.token,
        accountId: signInModel.accountId,
        username: signInModel.userName,
        fullName: signInModel.fullName);
  }

  List<DepartmentModel> _saveInfoDepartment(SignInModel signInModel) {
    return signInModel.infoDepartment
        .map((item) => DepartmentModel(
              code: item.code,
              id: item.id,
              name: item.name,
              area: item.organization?.area ?? signInModel.organization?.area ?? null
            ))
        .toList();
  }

  @override
  Future<bool> removeAuth() async {
    this._authModel = null;
    return await authLocal.removeAuthAtStorage();
  }

  @override
  Future<bool> removeInfoLogin() async {
    return await authLocal.removeInfoLoginAtStorage();
  }

  @override
  Future<bool> saveAuth({AuthModel model}) async {
    _authModel = model;
      await authLocal.saveAuthToStorage(authModel: model);
    return true;
  }
}

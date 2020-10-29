import 'package:flutter/material.dart';
import 'package:orim/base/bloc.dart';
import 'package:orim/base/subject.dart';
import 'package:orim/config/strings_resource.dart';
import 'package:orim/model/info_after_login.dart';
import 'package:orim/model/user_info_data/user_info_data.dart';
import 'package:orim/navigator_service.dart';
import 'package:orim/pages/signin/sign_in_view.dart';
import 'package:orim/viewmodel/permission.dart';
import 'package:orim/viewmodel/user_info.dart';
import 'package:orim/viewmodel/user_info_personal.dart';
import 'package:provider/provider.dart';
import '../../model/infologin/info_login.dart';

class SignInBloc extends BaseBloc {
  SignInBloc({@required BuildContext context, @required SignInView view})
      : super(context: context) {
    this.view = view;
  }

  SignInView view;

  BehaviorSubject<bool> _rememberPassSubject = BehaviorSubject(value: false);

  Stream<bool> get rememberPasswordObserver => _rememberPassSubject.stream;

  TextEditingController usernameController = TextEditingController();
  FocusNode usernameFocusNode = FocusNode();

  BehaviorSubject<String> _usernameError = BehaviorSubject();

  Stream<String> get usernameErrorObserver => _usernameError.stream;

  TextEditingController passwordController = TextEditingController();
  FocusNode passwordFocusNode = FocusNode();

  BehaviorSubject<String> _passwordError = BehaviorSubject();

  Stream<String> get passwordErrorObserver => _passwordError.stream;

  UserInfoViewModel _userInfoViewModel;
  UserInfoPersonalViewModel _userInfoPersonalViewModel;
  PermissionViewModel _permissionViewModel;

  @override
  void updateDependencies(BuildContext context) {
    _permissionViewModel = Provider.of<PermissionViewModel>(context);
    _userInfoPersonalViewModel =
        Provider.of<UserInfoPersonalViewModel>(context);
    _userInfoViewModel = Provider.of<UserInfoViewModel>(context);
    super.updateDependencies(context);
  }

  onChangeRememeberPassword(bool value) async {
    if (_rememberPassSubject.value != value) {
      _rememberPassSubject.value = value;
    }
  }

  bool checkValid() {
    String username = usernameController.text.trim();
    String password = passwordController.text.trim();
    bool result = true;
    if (username.isEmpty || username.length == 0) {
      _usernameError
          .addError(StringResource.getText(context, 'sign_in_username_blank'));
      result = result && false;
    }
    if (password.isEmpty || password.length == 0) {
      _passwordError
          .addError(StringResource.getText(context, 'sign_in_password_blank'));
      result = result && false;
    }
    return result;
  }

  Future<bool> submit() async {
    if (checkValid()) {
      String username = usernameController.text.trim();
      String password = passwordController.text.trim();
      InfoAfterLogin resAuth;
      resAuth = await authViewModel.login(username: username, password: password);

      if (resAuth != null) {
        await _userInfoPersonalViewModel.saveInfoPersonal(
            model: resAuth.personalInfoModel);
        _userInfoViewModel.data = UserInfoData(
          name: resAuth.authModel.fullName,
          phone: resAuth.personalInfoModel.phoneNumber,
          identify: resAuth.personalInfoModel.id,
          enterprise: "",
          address: resAuth.personalInfoModel.address,
        );
        authViewModel.saveStatus(true);

        authViewModel.saveStatusRemember(_rememberPassSubject.value);

        await authViewModel.saveInfoLoginLocal(username, password);
        await _permissionViewModel.getPermission();
        return true;
      } else {
        authViewModel.saveStatus(false);
      }
    }
    return false;
  }

  Future<void> login() async {
    await this.view.showLoading();
    final bool res = await this.submit();
    await this.view.hideLoading();
    if (res) {
      this.gotoHome();
    } else {
      this.view.showLoginFail();
    }
  }

  Future<bool> checkLogin() async {
    return await authViewModel.readStatus();
  }

  Future<InfoLogin> getUserLogin() async {
    InfoLogin _info;
    _info = await authViewModel.getInfoLogin();
    return _info;
  }

  Future<void> rememberLogin() async {
    final bool isRememberLogin = await authViewModel.readStatusRemember();
    if (isRememberLogin) {
      InfoLogin infoLogin;
      try {
        infoLogin = await authViewModel.getInfoLogin();
      } catch (err) {
        print(err);
      }
      if (infoLogin != null) {
        try {
          usernameController.text = infoLogin.username;
          passwordController.text = infoLogin.password;
          _rememberPassSubject.value = true;
        } catch (err) {
          print(err);
        }
      }
    }
  }

  Future<bool> checkRemember() async {
    return await authViewModel.readStatusRemember();
  }

  @override
  void dispose() {
    usernameController.dispose();
    usernameFocusNode.dispose();
    passwordController.dispose();
    passwordFocusNode.dispose();
    _rememberPassSubject.close();
    _usernameError.close();
    _passwordError.close();
  }

  void gotoHome() {
    NavigatorService.gotoHome(context);
  }

}

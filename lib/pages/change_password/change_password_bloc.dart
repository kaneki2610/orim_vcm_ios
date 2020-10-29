import 'dart:async';
import 'package:orim/config/enum_packages/enum_change_password.dart';
import 'package:orim/config/strings_resource.dart';
import 'package:orim/model/infologin/info_login.dart';
import 'package:orim/navigator_service.dart';
import 'package:orim/pages/change_password/change_password_view.dart';
import 'package:orim/viewmodel/change_pass.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:orim/base/bloc.dart';
import 'package:orim/base/subject.dart';

class ChangePasswordBloc extends BaseBloc {
  ChangePasswordBloc(
      {@required BuildContext context, @required ChangePasswordView view})
      : super(context: context) {
    this.view = view;
  }

  ChangePasswordViewModel changePasswordViewModel;
  ChangePasswordView view;
  BehaviorSubject<String> _passwordSubject = BehaviorSubject();

  Stream<String> get passwordStream => _passwordSubject.stream;

  BehaviorSubject<String> _confirmPasswordSubject = BehaviorSubject();

  Stream<String> get confirmPasswordStream => _confirmPasswordSubject.stream;

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  Stream<bool> get submitStream => Rx.combineLatest2(
      passwordStream,
      confirmPasswordStream,
      (pass, confirmPass) => (pass != "" && confirmPass != ""));

  @override
  void updateDependencies(BuildContext context) {
    super.updateDependencies(context);
    changePasswordViewModel = Provider.of<ChangePasswordViewModel>(context);
  }

  void onChangePassword(String value) {
    this._passwordSubject.value = value;
  }

  void onChangeConfirmPassword(String value) {
    this._confirmPasswordSubject.value = value;
  }

  bool handleMappingPassword(String newPass, String confirmPass) {
    if (newPass != confirmPass) {
      return false;
    }
    return true;
  }

  void handleUpdateInfoRememberLogin(String password) async {
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
          await authViewModel.saveInfoLoginLocal(infoLogin.username, password);
        } catch (err) {
          print(err);
        }
      }
    }
  }

  Future<int> _changePass() async {
    int status;
    bool isChangePassSuccess = false;
    String pass = this.passwordController.text.trim();
    String passConfirm = this.confirmPasswordController.text.trim();
    if (!this.handleMappingPassword(pass, passConfirm)) {
      status = ChangePasswordEnum.not_match;
    } else if (pass.length < 6 && passConfirm.length < 6) {
      status = ChangePasswordEnum.least_character;
    } else {
      try {
        isChangePassSuccess = await this
            .changePasswordViewModel
            .changePassword(password: passConfirm);
        if (isChangePassSuccess) {
          this.handleUpdateInfoRememberLogin(passConfirm);
          status = ChangePasswordEnum.update_success;
        } else {
          status = ChangePasswordEnum.update_failed;
        }
      } catch (err) {
        print(err.toString());
        return ChangePasswordEnum.update_failed;
      }
    }
    return status;
  }

  void submit() async {
    this.view.showLoading();
    final int status = await this._changePass();
    String msg = await this._handleUpdatePassWordStatus(status);
    this.view.hideLoading();
    await this.view.showToastWithMessage(msg);
  }

  Future<String> _handleUpdatePassWordStatus(int status) async {
    String value = "";
    switch (status) {
      case ChangePasswordEnum.not_match:
        value = StringResource.getText(context, "update_pass_not_match");
        break;
      case ChangePasswordEnum.least_character:
        value = StringResource.getText(context, "update_pass_least_character");
        break;
      case ChangePasswordEnum.update_success:
        value = StringResource.getText(context, "update_pass_success");
        await this.backThePreviousPage();
        break;
      case ChangePasswordEnum.update_failed:
        value = StringResource.getText(context, "update_pass_failed");
        break;
    }
    return value;
  }

  Future<void> backThePreviousPage() async {
    if (NavigatorService.back(context)) {
      NavigatorService.popToRoot(context);
    }
  }

  @override
  void dispose() {
    this._passwordSubject.close();
    this._confirmPasswordSubject.close();
  }
}

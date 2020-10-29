import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:orim/base/presenter.dart';
import 'package:orim/config/strings_resource.dart';
import 'package:orim/navigator_service.dart';
import 'package:orim/observer/force_logout.dart';
import 'package:orim/viewmodel/auth.dart';
import 'package:orim/viewmodel/helper.dart';
import 'package:orim/viewmodel/permission.dart';
import 'package:orim/viewmodel/user_info.dart';
import 'package:orim/viewmodel/user_info_personal.dart';
import 'package:provider/provider.dart';

abstract class BaseBloc implements BasePresenter {
  BuildContext _context;
  AuthViewModel _authViewModel;
  PermissionViewModel _permissionViewModel;
  UserInfoPersonalViewModel _userInfoPersonalViewModel;
  UserInfoViewModel _userInfoViewModel;
  HelperViewModel _helperViewModel;
  ForceLogoutObserver _logoutObserver;

  BaseBloc({@required BuildContext context})
      : assert(context != null),
        _context = context;

  BuildContext get context => _context;

  AuthViewModel get authViewModel => _authViewModel;

  HelperViewModel get helperViewModel => _helperViewModel;

  PermissionViewModel get permissionViewModel => _permissionViewModel;

  ForceLogoutObserver get logoutObserver => _logoutObserver;

  UserInfoPersonalViewModel get userInfoPersonalViewModel =>
      _userInfoPersonalViewModel;

  UserInfoViewModel get userInfoViewModel => _userInfoViewModel;

  void updateDependencies(BuildContext context) {
    this._context = context;
    _authViewModel = Provider.of(context);
    _permissionViewModel = Provider.of(context);
    _userInfoPersonalViewModel = Provider.of(context);
    _userInfoViewModel = Provider.of(context);
    _helperViewModel = Provider.of(context);
    _logoutObserver = Provider.of(context);
  }

  Future<void> forceLogout() async {
    Fluttertoast.showToast(msg: StringResource.getText(context, 'expired'));
    final bool res = await _authViewModel.logout(forceLogout: true);
    if (res) {
      _permissionViewModel.resetMenu();
      _userInfoPersonalViewModel.reset();
    }
//    _userInfoViewModel.reset();
    NavigatorService.gotoHome(context);
  }

  void observerLogout() {
    this.logoutObserver.dataObserver.value = true;
  }

  StreamSubscription<bool> listenerLogoutObserver(Function(bool) onchange) {
    if (onchange != null) {
      this.logoutObserver.listener(onDataChange: onchange);
    }
  }

  void dispose();
}

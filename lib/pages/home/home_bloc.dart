import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:orim/base/bloc.dart';
import 'package:orim/base/subject.dart';
import 'package:orim/config/enum_packages/enum_action_notification.dart';
import 'package:orim/config/enum_packages/enum_tab_index.dart';
import 'package:orim/model/auth/auth.dart';
import 'package:orim/model/notification/notification.dart' as Model;
import 'package:orim/model/personal_info/personal_info.dart';
import 'package:orim/navigator_service.dart';
import 'package:orim/pages/home/home_view.dart';
import 'package:orim/pages/home/tab/handle_complain/handle_complain_bloc.dart';
import 'package:orim/pages/home/tab/history/history_page.dart';
import 'package:orim/pages/home/tab/history/mobx/history_mobx.dart';
import 'package:orim/pages/issue_administration_detail/issue_administration_detail_page.dart';
import 'package:orim/pages/send_complain/send_complain_page.dart';
import 'package:orim/services/notification.dart';
import 'package:orim/viewmodel/handle_complain.dart';
import 'package:orim/viewmodel/notification.dart';
import 'package:provider/provider.dart';

class HomeBloc extends BaseBloc {
  HomeBloc({BuildContext context, HomeView view, TickerProvider vsync})
      : _view = view,
        super(context: context) {
    int pageDefault = 2;
    pageController = PageController(initialPage: pageDefault, keepPage: true);
    _pageSelected = PublishSubject<int>(value: pageDefault);
  }

  final HomeView _view;
  bool _isShowPopupLogout = false;
  final NotificationService _notificationService =
      NotificationService.getInstance();

  PageController pageController;
  PublishSubject<int> _pageSelected;

  Stream<int> get pageSelectedObservable => _pageSelected.stream;

  get selectedIndex => _pageSelected.value;

  BehaviorSubject<bool> _userLoginSubject = BehaviorSubject();

  Stream<bool> get loginObserver => _userLoginSubject.stream;

  Stream<StateTab> get stateTab =>
      Rx.combineLatest2(loginObserver, pageSelectedObservable,
          (bool isLogin, int page) {
        return StateTab(isLogin: isLogin, page: page);
      });

  StreamSubscription userSubsciption;
  HandleComplainViewModel _handleComplainViewModel;
  NotificationViewModel _notificationViewModel;
  StreamSubscription _logoutSubscription;

  @override
  void updateDependencies(BuildContext context) {
    // TODO: implement updateDependencies
    super.updateDependencies(context);
    _handleComplainViewModel = Provider.of(context);
    this._notificationViewModel = Provider.of<NotificationViewModel>(context);
  }

  void changeTab(int index) {
    pageController.jumpToPage(index);
//    pageController.animateToPage(index, duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    _pageSelected.value = index;
  }

  @override
  void dispose() {
    userSubsciption?.cancel();
    _pageSelected.close();
    pageController.dispose();
    this._logoutSubscription?.cancel();
  }



  void gotoIntro() {
    NavigatorService.gotoIntro(context);
  }

  void gotoChangePassword() {
    NavigatorService.popToRoot(context);
    this.changeTab(TabIndexEnum.ChangePassword);
  }

  void gotoRouteWithName(String routeName) {
    switch (routeName) {
      case SendComplainPage.routeName:
        NavigatorService.gotoSendComplain(context, arguments: null);
        break;
      case HistoryPage.routeName:
        NavigatorService.gotoHistory(context);
        break;
      default:
        Fluttertoast.showToast(msg: 'no route define in drawer');
    }
  }

  Future<void> logout() async {
    await _view.showLoading();
    try {
      await this.reloadDataLogOut();
      _view.showMessageWhenLogoutSucceed();
      await _view.hideLoading();
      NavigatorService.gotoHome(context);
    } catch (err) {
      await _view.hideLoading();
      await this.resetAfterLogout();
    }
  }

  Future<void> resetAfterLogout() async {
    authViewModel.saveStatus(false);
    permissionViewModel.resetMenu();
    permissionViewModel.deletePermissionLocal();
    userInfoPersonalViewModel.reset();
    this.authViewModel.removeAuth();
    _notificationViewModel.removeAllNotification();
  }
  Future<void> reloadDataLogOut() async {
    bool res;
    res = await authViewModel.logout();
    this.resetAfterLogout();
  }

  void initListener() {
    userSubsciption = userInfoPersonalViewModel.listener(
        onDataChange: (PersonalInfoModel data) {
      if (data != null) {
        if (_userLoginSubject.value != true) {
          _userLoginSubject.value = true;
          _pageSelected.value = 2;
        }
      } else {
        if (_userLoginSubject.value != false) {
          _userLoginSubject.value = false;
          _pageSelected.value = 2;
        }
      }
    });
    this._logoutSubscription =
        this.listenerLogoutObserver(this._showPopupLogout);
  }

  void _showPopupLogout(bool status) {
    if (this._isShowPopupLogout == false) {
      this._view.showPopupTokenExpired(() {
        this._isShowPopupLogout = false;
        this.resetAfterLogout();
        NavigatorService.popToRoot(context);
        this.changeTab(TabIndexEnum.Home);
      });

    }
    this._isShowPopupLogout = true;
  }

  Future<void> getInfoUser() async {
    try {
      await userInfoPersonalViewModel.getUserInfo();
    } catch (err) {
      print(err);
    }
  }

  listenNotification() {
    print('listenNotification');
    //_notificationService.requestNotificationPermissions();
    _notificationService.listenNotification(
        onNotification: (Model.Notification notification) async {
      if (notification != null) {
        print('onNotification $notification');
        this._notificationViewModel.saveNotification(notification);
        AuthModel auth = await authViewModel.getAuth();
        if (auth != null) {
          print("auth ---- ${auth.fullName}");
          _view.showNotification(notification: notification);
        }
        _notificationService.removeNotification();
      }
    });
  }

  Future<AuthModel> getAuth() async {
    AuthModel auth = await authViewModel.getAuth();
    return auth;
  }

  void handleAction({Model.Notification notification}) async {
    var action = notification.action;
    AuthModel auth = await authViewModel.getAuth();
    if (auth != null) {
      HandleComplainType index = HandleComplainType.approved;
      switch (action.toLowerCase()) {
        case EnumActionNotification.ASSIGNED_EXECUTE:
          index = HandleComplainType.handling;
          this.gotoHandleComplain(index); // đi vào tab xử lý
          break;
        case EnumActionNotification.ASSIGNED_SUPPORT: // đi vào tab phân công
          index = HandleComplainType.assigned;
          this.gotoHandleComplain(index);
          break;
        case EnumActionNotification.NEWS: // đi vào trang tin tức
          NavigatorService.gotoBrowser(context, url: notification.url);
          break;
        case EnumActionNotification
            .ADMINMONITOR: // đi vào trang chi tiết quản trị
          if (notification.idIssue != null && notification.idIssue != "") {
            this.goDetailIssueAdminDetail(notification.idIssue);
          }
          break;
        case EnumActionNotification
            .ISSUE_SEND: // đi vào trang các phản ánh đã gửi
          AuthModel auth = await this.getAuth();
          if (auth == null) {
            this.gotoHistorySendComplain();
          } else {
            this.gotoHistoryLoginSendComplain();
          }
          break;
        default:
          index = HandleComplainType.approved; // đi vào tab phê duyệt
          this.gotoHandleComplain(index);
          break;
      }
    }
  }

  void gotoHandleComplain(HandleComplainType indexTab) {
    NavigatorService.popToRoot(context);
    this._handleComplainViewModel.changeHandleComplainTab(indexTab);
    this.changeTab(TabIndexEnum.HandleComplain);
  }

  void gotoHomeUser() {
    NavigatorService.popToRoot(context);
    this.changeTab(TabIndexEnum.Home);
  }

  void gotoHistorySendComplain() {
    NavigatorService.popToRoot(context);
    this.changeTab(TabIndexEnum.HistorySendComplain);
  }

  void gotoUpdatePassword() {
    NavigatorService.gotoUpdatePassword(context);
  }

  void gotoEmployerInfo() {
    NavigatorService.gotoEmployerInfo(context);
  }

  void gotoHistoryLoginSendComplain() {
    HistoryPageLoginArgument argument =
        HistoryPageLoginArgument(historyMobx: HistoryMobx());
    NavigatorService.gotoHistoryLogin(context, argument: argument);
  }

  void gotoInfoUser() {
    NavigatorService.popToRoot(context);
    this.changeTab(TabIndexEnum.Info);
  }

  void gotoLoginInfoUser() {
    NavigatorService.gotoInfoLogin(context);
  }

  void goDetailIssueAdminDetail(String idIssue) {
    IssueAdministrationDetailArguments arguments =
        IssueAdministrationDetailArguments(idIssue: idIssue);
    print(arguments.idIssue);
    NavigatorService.gotoIssueAdminDetail(context, argument: arguments);
  }
}

class StateTab {
  bool isLogin;
  int page;

  StateTab({this.isLogin, this.page});
}

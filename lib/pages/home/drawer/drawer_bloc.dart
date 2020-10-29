import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orim/base/bloc.dart';
import 'package:orim/base/subject.dart';
import 'package:orim/config/drawer_menu_config.dart';
import 'package:orim/config/imgs_resource.dart';
import 'package:orim/model/menu_item.dart';
import 'package:orim/model/permission/permission.dart';
import 'package:orim/model/personal_info/personal_info.dart';
import 'package:orim/pages/change_password/change_password_page.dart';
import 'package:orim/pages/employer_info/employer_info_page.dart';
import 'package:orim/pages/home/tab/administration/administration_page.dart';
import 'package:orim/pages/home/tab/dashboard/dashboard_page.dart';
import 'package:orim/pages/home/tab/handle_complain/handle_complain_child.dart';
import 'package:orim/pages/home/tab/history/history_page.dart';
import 'package:orim/pages/intro/intro_page.dart';
import 'package:orim/pages/send_complain/send_complain_page.dart';
import 'package:orim/viewmodel/permission.dart';
import 'package:orim/viewmodel/user_info_personal.dart';
import 'package:provider/provider.dart';

class DrawerBloc extends BaseBloc {
  DrawerBloc({@required BuildContext context}) : super(context: context) {
    List<MenuItem> list = [];
    for (final menu in defaultMenus) {
      list.add(MenuItem.clone(menu));
    }
    _menusSubject.value = list;
  }

  PermissionViewModel _permissionViewModel;
  UserInfoPersonalViewModel _userInfoPersonalViewModel;

  BehaviorSubject<List<MenuItem>> _menusSubject = BehaviorSubject();

  Stream<List<MenuItem>> get menuObserver => _menusSubject.stream;
  StreamSubscription _subscriptionMenu;

  BehaviorSubject<PersonalInfoModel> _personalSubject = BehaviorSubject();

  Stream<PersonalInfoModel> get personalInfoObserver => _personalSubject.stream;
  StreamSubscription _subscriptionUserInfo;

  @override
  void updateDependencies(BuildContext context) {
    super.updateDependencies(context);
    _permissionViewModel = Provider.of<PermissionViewModel>(context);
    _userInfoPersonalViewModel =
        Provider.of<UserInfoPersonalViewModel>(context);
  }

  void listenDataChange() {
    _subscriptionMenu = _permissionViewModel.listener(
        onDataChange: (List<PermissionModel> permissionModels) {
      if (permissionModels != null && permissionModels.length > 0) {
        final List<MenuItem> menus = _menusSubject.value;
        for (final menu in menus) {
          final permissions = permissionModels
              .where((permission) => permission.code == menu.code);
          if (permissions.length > 0) {
            menu.visible = true;
          }
        }
        _menusSubject.value = menus.where((e) => e.visible == true).toList();
      } else {
        List<MenuItem> list = [];
        for (final menu in defaultMenus) {
          list.add(MenuItem.clone(menu));
        }
        _menusSubject.value = list;
      }
    });
    _subscriptionUserInfo = _userInfoPersonalViewModel.listener(
        onDataChange: (PersonalInfoModel personalInfoModel) {
      print('${personalInfoModel != null}');
      _personalSubject.value = personalInfoModel;
    });
  }

  @override
  void dispose() {
    _subscriptionMenu?.cancel();
    _subscriptionUserInfo?.cancel();
    _menusSubject.close();
    _personalSubject.close();
  }
}

List<MenuItem> defaultMenus = [
  // Báo sự kiện
  MenuItem(
    icon: ImageResource.send_menu,
    name: 'send_complain_menu',
    code: DrawerMenuConfig.baosukien_menu_app,
    visible: true,
    routeName: SendComplainPage.routeName,
  ),
  // Thông tin người dân
  MenuItem(
    icon: ImageResource.info_menu,
    name: 'info_menu',
    code: DrawerMenuConfig.thongtinnguoidan_menu_app,
    visible: true,
  ),
  // Các sự kiện đã gửi
  MenuItem(
    icon: ImageResource.list_complain_menu,
    name: 'list_complain_menu',
    code: DrawerMenuConfig.cacsukiendagui_menu_app,
    visible: true,
    routeName: HistoryPage.routeName,
  ),
//    // Mobile App
//    MenuItem(
//      icon: ImageResource.list_complain_menu,
//      name: 'mobile_app_menu',
//      code: 'Mobile_menu_app',
//    ),
  // Phân công
  MenuItem(
      icon: ImageResource.assigned_menu,
      name: 'assigned_menu',
      code: DrawerMenuConfig.phancong_menu_app,
      visible: false,
      routeName: HandleComplainChild.routeAssignName),
  // Xử lý
  MenuItem(
      icon: ImageResource.process_menu,
      name: 'process_menu',
      code: DrawerMenuConfig.xuly_menu_app,
      visible: false,
      routeName: HandleComplainChild.routeHandleName),
  // Phê duyệt
  MenuItem(
    icon: ImageResource.approval_menu,
    name: 'approval_menu',
    code: DrawerMenuConfig.pheduyet_menu_app,
    visible: false,
    routeName: HandleComplainChild.routeApprovedName
),
  // dashboard
  MenuItem(
    icon: ImageResource.dashboard_menu,
    name: 'dashboard_menu',
    code: DrawerMenuConfig.dashboard_menu_app,
    routeName: DashboardPage.routeName,
    visible: false,
  ),
  // quản trị
  MenuItem(
    icon: ImageResource.administrator_menu,
    name: 'administrator_menu',
    code: DrawerMenuConfig.quantri_menu_app,
    routeName: AdministrationPage.routeName,
    visible: false,
  ),
  // thông tin nhân viên
  MenuItem(
    icon: ImageResource.info_officer_menu,
    name: 'info_officer_menu',
    code: DrawerMenuConfig.thongtinnhanvien_menu_app,
    visible: false,
    routeName: EmployerInfoPage.routeName
  ),
  // đổi mật khẩu
  MenuItem(
    icon: ImageResource.change_password_menu,
    name: 'change_password_menu',
    code: DrawerMenuConfig.doimatkhau_menu_app,
    visible: false,
    routeName: ChangePasswordPage.routeName,
  ),
  // Đăng xuất
  MenuItem(
    icon: ImageResource.logout_menu,
    name: 'logout_menu',
    code: DrawerMenuConfig.dangxuat_menu_app,
    routeName: "",
    visible: false,
  ),
  // lịch sử thông báo
//    MenuItem(
//      icon: ImageResource.notification_menu,
//      name: 'notification_menu',
//      code: 'thongbao_menu_app',
//    ),
  MenuItem(
    icon: ImageResource.user_manual_menu,
    name: 'manual_menu',
    code: DrawerMenuConfig.huongdan_menu_app,
    visible: true,
    routeName: IntroPage.routeName,
  )
];

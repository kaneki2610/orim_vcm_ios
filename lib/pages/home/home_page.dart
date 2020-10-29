import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:orim/base/page.dart';
import 'package:orim/components/loading.dart';
import 'package:orim/config/drawer_menu_config.dart';
import 'package:orim/config/enum_packages/enum_action_notification.dart';
import 'package:orim/config/strings_resource.dart';
import 'package:orim/model/auth/auth.dart';
import 'package:orim/model/notification/notification.dart' as Model;
import 'package:orim/navigator_service.dart';
import 'package:orim/pages/home/home_bloc.dart';
import 'package:orim/pages/home/home_view.dart';
import 'package:orim/pages/home/tab/administration/administration_page.dart';
import 'package:orim/pages/home/tab/all/all_page.dart';
import 'package:orim/pages/home/tab/contact/contact_page.dart';
import 'package:orim/pages/home/tab/dashboard/dashboard_page.dart';
import 'package:orim/pages/home/tab/handle_complain/handle_complain.dart';
import 'package:orim/pages/home/tab/handle_complain/handle_complain_child.dart';
import 'package:orim/pages/home/tab/handle_complain/mobx/handle_complain_mobx.dart';
import 'package:orim/pages/home/tab/history/history_page.dart';
import 'package:orim/pages/home/tab/history/mobx/history_mobx.dart';
import 'package:orim/pages/home/tab/info/info_page.dart';
import 'package:orim/pages/home/tab/map/map_page.dart';
import 'package:orim/pages/home/tab/map_officer/map_page_officer.dart';
import 'package:orim/pages/home/tab/notification/notification_page.dart';
import 'package:orim/utils/alert_dialog.dart';
import 'package:orim/utils/open_url.dart';

import 'drawer/drawer.dart';

class MyHomePage extends StatefulWidget {
  static const routeName = 'home';

  final HistoryMobx _historyMobx = HistoryMobx();
  final ComplainMobx _complainMobx = ComplainMobx();

  @override
  _MyHomePageState createState() {
    List<ItemPager> listItemPager = [
      ItemPager(
          widget: const AllPage(),
          icon: Icons.list,
          labelKey: AllPage.routeName,
          appBar: const AllPageTabbar()),
      ItemPager(
          widget: HistoryPage(
            mobx: _historyMobx,
          ),
          icon: Icons.history,
          labelKey: HistoryPage.routeName,
          appBar: HistoryPageTabbar(
            mobx: _historyMobx,
          )),
      ItemPager(
          widget: const MapPage(),
          icon: Icons.home,
          labelKey: MapPage.routeName,
          appBar: const MapPageTabbar()),
      ItemPager(
          widget: const ContactPage(),
          icon: Icons.headset,
          labelKey: ContactPage.routeName,
          appBar: const ContactPageTabbar()),
      ItemPager(
          widget: const InfoPage(false),
          icon: Icons.info,
          labelKey: InfoPage.routeName,
          appBar: const InfoPageTabbar()),
    ];
    List<ItemPager> listItemPagerAfterLogin = [
      ItemPager(
          widget: HandleComplainPage(
            mobx: this._complainMobx,
          ),
          icon: Icons.group_work,
          labelKey: HandleComplainPage.routeName,
          appBar: HandleComPlainTab(
            mobx: this._complainMobx,
          )),
//      ItemPager(
//        widget: OperationPage(),
//        icon: Icons.group_work,
//        labelKey: OperationPage.routeName,
//        appBar: OperatorPageTabbar(),
//      ),
      ItemPager(
          widget: const DashboardPage(),
          icon: Icons.dashboard,
          labelKey: DashboardPage.routeName,
          appBar: const DashboardPageTabbar()),
      ItemPager(
          widget: const MapOfficerPage(),
          icon: Icons.home,
          labelKey: MapOfficerPage.routeName,
          appBar: const MapOfficerTabbar()),
      ItemPager(
          widget: const AdministrationPage(),
          icon: Icons.people,
          labelKey: AdministrationPage.routeName,
          appBar: const AdministationTabbar()),
      ItemPager(
          widget: const NotificationPage(),
          icon: Icons.notifications,
          labelKey: NotificationPage.routeName,
          appBar: const NotificationTabbar()),
    ];
    return _MyHomePageState(
        listItemPager: listItemPager,
        listItemPagerAfterLogin: listItemPagerAfterLogin);
  }

  void dispose() {
    _historyMobx.dispose();
    _complainMobx.dispose();
  }

  void resetMobx() {
    _historyMobx.reset();
    _complainMobx.reset();
  }
}

class _MyHomePageState extends BaseState<HomeBloc, MyHomePage>
    with SingleTickerProviderStateMixin
    implements HomeView {
  _MyHomePageState({this.listItemPager, this.listItemPagerAfterLogin});

  final List<ItemPager> listItemPager;
  final List<ItemPager> listItemPagerAfterLogin;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void initBloc() {
    bloc = HomeBloc(context: context, view: this, vsync: this);
  }

  @override
  void onPostFrame() {
    super.onPostFrame();
    //this.bloc.checkUpdateApp();
    bloc.initListener();
    bloc.listenNotification();
    bloc.listenNotificationVCM();
    bloc.getInfoUser();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc?.updateDependencies(context);
  }

  @override
  void dispose() {
    widget.dispose();
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: bloc.stateTab,
      builder: (context, AsyncSnapshot<StateTab> snapshot) {
        if (snapshot.hasData) {
          if (listItemPager.length > 0 || listItemPager.length > 0) {
            final int page =
                snapshot.hasData ? snapshot.data.page : bloc.selectedIndex;
            final bool isLogin =
                snapshot.hasData ? snapshot.data.isLogin : false;
            final List<ItemPager> list =
                isLogin ? listItemPagerAfterLogin : listItemPager;
            return Scaffold(
              key: _scaffoldKey,
              appBar: list[page].appBar,
              backgroundColor: Colors.grey[200],
              drawer: Drawer(
                // Add a ListView to the drawer. This ensures the user can scroll
                // through the options in the drawer if there isn't enough vertical
                // space to fit everything.
                child: DrawerContent(
                  onClickItemMenu: _onClickItemMenu,
                ),
              ),
              body: SafeArea(
                child: PageView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) => PageStorage(
                    bucket: list[index].bucket,
                    key: PageStorageKey<String>(list[index].labelKey),
                    child: list[index].widget,
                  ),
                  controller: bloc.pageController,
                  physics: NeverScrollableScrollPhysics(),
                ),
              ),
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: page,
                selectedItemColor: Theme.of(context).primaryColor,
                unselectedItemColor: Colors.grey,
                showUnselectedLabels: true,
                showSelectedLabels: true,
                unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
                selectedLabelStyle: TextStyle(fontWeight: FontWeight.w500),
                type: BottomNavigationBarType.fixed,
                onTap: _onSelectTab,
                items: list
                    .map((item) => BottomNavigationBarItem(
                          icon: Icon(item.icon),
                          title: Text(
                              StringResource.getText(context, item.labelKey)),
                        ))
                    .toList(),
              ),
//              bottomNavigationBar: FFNavigationBar(
//                theme: FFNavigationBarTheme(
//                  barBackgroundColor: Colors.white,
//                  selectedItemBackgroundColor: Theme.of(context).primaryColor,
//                  selectedItemIconColor: Colors.white,
//                  selectedItemLabelColor: Colors.black,
//                ),
//                selectedIndex: page,
//                onSelectTab: _onSelectTab,
//                items: list
//                    .map((item) => FFNavigationBarItem(
//                          iconData: item.icon,
//                          label: StringResource.getText(context, item.labelKey),
//                        ))
//                    .toList(),
//              ),
            );
          } else {
            return Container(
              child: Center(
                child: Loading(),
              ),
            );
          }
        } else {
          return Container(
            child: Center(
              child: Loading(),
            ),
          );
        }
      },
    );
  }

  Future<void> _onClickItemMenu({String routeName, String code}) async {
    switch (code) {
      case DrawerMenuConfig.dangxuat_menu_app:
        _logout();
        break;
      case DrawerMenuConfig.baosukien_menu_app:
        this.bloc.gotoHomeUser();
        break;
      case DrawerMenuConfig.thongtinnguoidan_menu_app:
        AuthModel auth = await this.bloc.getAuth();
        if (auth == null) {
          this.bloc.gotoInfoUser();
        } else {
          this.bloc.gotoLoginInfoUser();
        }
        break;
      case DrawerMenuConfig.huongdan_menu_app:
        this.bloc.gotoIntro();
        break;
      case DrawerMenuConfig.cacsukiendagui_menu_app:
        AuthModel auth = await this.bloc.getAuth();
        if (auth == null) {
          this.bloc.gotoHistorySendComplain();
        } else {
          this.bloc.gotoHistoryLoginSendComplain();
        }
        break;
      case DrawerMenuConfig.doimatkhau_menu_app:
        this.bloc.gotoUpdatePassword();
        break;
      case DrawerMenuConfig.thongtinnhanvien_menu_app:
        this.bloc.gotoEmployerInfo();
        break;

      default:
        _navigate(routeName);
    }
  }

  void _logout() {
    AlertDialogBuilder(
            context: context,
            title: StringResource.getText(context, 'logout_title_warning'),
            content: StringResource.getText(context, 'logout_content_warning'))
        .show(cancelable: true, actions: <Widget>[
      AlertDialogBuilder.button(
          text: StringResource.getText(context, 'no'),
          onPress: () => NavigatorService.back(context)),
      AlertDialogBuilder.button(
          text: StringResource.getText(context, 'yes'), onPress: logout)
    ]);
  }

  void _navigate(String routeName) async {
    switch (routeName) {
      case HandleComplainChild.routeAssignName:
        this.bloc.handleAction(
            notification: Model.Notification(
                action: EnumActionNotification.ASSIGNED_SUPPORT));
        break;
      case HandleComplainChild.routeHandleName:
        this.bloc.handleAction(
            notification: Model.Notification(
                action: EnumActionNotification.ASSIGNED_EXECUTE));
        break;
      case HandleComplainChild.routeApprovedName:
        this.bloc.handleAction(
            notification: Model.Notification(
                action: EnumActionNotification.APPROVE_EXECUTE));
        break;
      default:
        AuthModel auth = await this.bloc.getAuth();
        int index = -1;
        index = (auth == null ? listItemPager : listItemPagerAfterLogin)
            .indexWhere((item) => item.labelKey == routeName);
        if (index > -1) {
          // is tab
          bloc.changeTab(index);
        } else {
          // is page
          bloc?.gotoRouteWithName(routeName);
        }
        break;
    }
  }

  Future<void> logout() async {
    if (NavigatorService.back(context)) {
      await bloc.logout();
    }
  }

  @override
  Future<bool> hideLoading() async {
    return await progressDialogLoading.hide();
  }

  @override
  Future<bool> showLoading() async {
    return await progressDialogLoading.show();
  }

  @override
  void showMessageWhenLogoutFailed(String msg) {
    Fluttertoast.showToast(
        msg: StringResource.getText(context, 'logout_failed - $msg'));
  }

  @override
  void showMessageWhenLogoutSucceed() {
    Fluttertoast.showToast(
        msg: StringResource.getText(context, 'logout_succeed'));
  }

  void _onSelectTab(int index) {
    widget.resetMobx();
    bloc.changeTab(index);
  }

  @override
  void showMessageWhenLogoutTimeout() {
    Fluttertoast.showToast(msg: StringResource.getText(context, 'time_out'));
  }

  @override
  void showNotification({Model.Notification notification}) {
    AlertDialogBuilder(
            context: context,
            content: notification.content,
            title: notification.title)
        .show(cancelable: false, actions: [
      AlertDialogBuilder.button(
          text: StringResource.getText(context, 'skip'),
          onPress: () => NavigatorService.back(context)),
      AlertDialogBuilder.button(
        text: StringResource.getText(context, 'next'),
        onPress: () {
          if (NavigatorService.back(context)) {
          }
          bloc.handleAction(notification: notification);
        },
      ),
    ]);
  }

  @override
  void showUpdateApp(String url) {
      AlertDialogBuilder(
              context: context,
              content: StringResource.getText(context, "update_app_title"),
              title: StringResource.getText(context, "update_app_content"))
          .show(cancelable: false, actions: [
        AlertDialogBuilder.button(
            text: StringResource.getText(context, 'skip'),
            onPress: () => NavigatorService.back(context)),
        AlertDialogBuilder.button(
          text: StringResource.getText(context, 'agree'),
          onPress: () {
            if (NavigatorService.back(context)) {
              Web.openUrl(url: url);
            }
          },
        ),
      ]);
  }

  @override
  void showPopupTokenExpired(Function callback) {
    AlertDialogBuilder(
            context: context,
            content: StringResource.getText(context, "expired"),
            title: StringResource.getText(context, "information"))
        .show(cancelable: false, actions: [
      AlertDialogBuilder.button(
          text: StringResource.getText(context, 'agree'),
          onPress: () {
            if (callback != null) {
              callback();
            }
            NavigatorService.back(context);
          }),
    ]);
  }
}

class ItemPager {
  final Widget widget;
  final IconData icon;
  final String labelKey; // key from resource string
  final PreferredSizeWidget appBar;
  final PageStorageBucket bucket = PageStorageBucket();

  ItemPager({this.widget, this.icon, this.labelKey, @required this.appBar});
}

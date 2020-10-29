import 'dart:async';

import 'package:flutter/material.dart';
import 'package:orim/base/bloc.dart';
import 'package:orim/base/subject.dart';
import 'package:orim/config/drawer_menu_config.dart';
import 'package:orim/config/strings_resource.dart';
import 'package:orim/model/permission/permission.dart';
import 'package:orim/viewmodel/handle_complain.dart';
import 'package:provider/provider.dart';

import 'handle_complain_child.dart';
import 'mobx/handle_complain_mobx.dart';

enum HandleComplainType {
  assigned,
  handling,
  approved,
}

class HandleComPlainPageBloc extends BaseBloc {
  List<Widget> tabs = [];

  List<Widget> tabViews = [];

  int currentIndex = 0;
  TabController tabController;
  ComplainMobx _complainMobx;
  HandleComplainViewModel _handleComplainViewModel;
  StreamSubscription _subscriptionTab;
  BehaviorSubject<bool> _updateViewSubject = BehaviorSubject();

  Stream<bool> get streamUpdateView => _updateViewSubject.stream;

  HandleComPlainPageBloc(BuildContext context, ComplainMobx mobx)
      : this._complainMobx = mobx,
        super(context: context);

  listenDataChange(SingleTickerProviderStateMixin ticker) {
    if (this.permissionViewModel != null) {
      this.permissionViewModel.listener(
          onDataChange: (List<PermissionModel> permissionModels) {
        this.createTab(ticker);
        this.listenTapChange();
      });
    }
  }

  createTab(SingleTickerProviderStateMixin ticker) {
    if (this.permissionViewModel != null &&
        this.permissionViewModel.data != null &&
        this.permissionViewModel.data.length > 0) {
      bool isProcess =
          this.checkShowTabWithPermission(DrawerMenuConfig.xuly_menu_app);
      bool isAssign =
          this.checkShowTabWithPermission(DrawerMenuConfig.phancong_menu_app);
      bool isApprove =
          this.checkShowTabWithPermission(DrawerMenuConfig.pheduyet_menu_app);
      if (isAssign) {
        this.tabViews.add(HandleComplainChild(
          type: HandleComplainType.assigned,
          mobx: this._complainMobx,
        ));
        this.tabs.add(Tab(
          text: StringResource.getText(context, 'handle_complain_assigned'),
        ));
      }
      if (isProcess) {
        this.tabViews.add(HandleComplainChild(
              type: HandleComplainType.handling,
              mobx: this._complainMobx,
            ));
        this.tabs.add(Tab(
              text: StringResource.getText(context, 'handle_complain_handling'),
            ));
      }
      if (isApprove) {
        this.tabViews.add(HandleComplainChild(
              type: HandleComplainType.approved,
              mobx: this._complainMobx,
            ));
        this.tabs.add(Tab(
              text: StringResource.getText(context, 'handle_complain_approved'),
            ));
      }
      this.createTabController(ticker);
      this._updateViewSubject.value = this.tabs.length > 0;
    }
  }

  bool checkShowTabWithPermission(String code) {
    bool isShow = false;
    for (var per in this.permissionViewModel.data) {
      if (per.code == code) {
        isShow = true;
        break;
      }
    }
    return isShow;
  }

  @override
  void updateDependencies(BuildContext context) {
    // TODO: implement updateDependencies
    super.updateDependencies(context);
    _handleComplainViewModel = Provider.of(context);
  }

  void listenTapChange() {
    _subscriptionTab = _handleComplainViewModel.listener(
        onDataChange: (HandleComplainType type) {
      int index = 0;
      switch (type) {
        case HandleComplainType.assigned:
          index = 0;
          break;
        case HandleComplainType.handling:
          index = 1;
          break;
        case HandleComplainType.approved:
          index = 2;
          break;
      }
      if (index < this.tabs.length) {
        this.tabController.animateTo(index,
            duration: Duration(milliseconds: 200), curve: Curves.ease);
      }
    });
  }

  void createTabController(SingleTickerProviderStateMixin ticker) {
    this.tabController = TabController(vsync: ticker, length: this.tabs.length);
    this.tabController.addListener(() {
      if (this.currentIndex != this.tabController.index) {
        this.currentIndex = this.tabController.index;
        this._complainMobx.indexCurrentTab = this.currentIndex;
      }
    });
  }

  @override
  void dispose() {
    this.tabController.dispose();
    _updateViewSubject.close();
  }
}

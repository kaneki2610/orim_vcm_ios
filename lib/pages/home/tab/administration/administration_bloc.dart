import 'package:flutter/material.dart';
import 'package:orim/base/bloc.dart';
import 'package:orim/base/subject.dart';
import 'package:orim/config/enum_packages/enum_administration_permission.dart';
import 'package:orim/config/enum_packages/enum_administration_tab.dart';
import 'package:orim/config/strings_resource.dart';
import 'package:orim/model/permission/permission.dart';
import 'package:orim/pages/home/tab/administration/administration_view.dart';
import 'package:orim/pages/home/tab/administration/administration_child.dart';

class AdministrationBloc extends BaseBloc {
  final List<Widget> tabs = [];
  final List<Widget> tabViews = [];
  TabController tabController;
  final AdministrationView _view;
  SingleTickerProviderStateMixin _ticker;
  BehaviorSubject<bool> _updateViewSubject = BehaviorSubject();

  Stream<bool> get streamUpdateView => _updateViewSubject.stream;

  AdministrationBloc(
      {BuildContext context,
      AdministrationView view,
      SingleTickerProviderStateMixin ticker})
      : _view = view,
        this._ticker = ticker,
        super(context: context) {}

  @override
  void updateDependencies(BuildContext context) {
    super.updateDependencies(context);
  }

  listenDataChange() {
    if (this.permissionViewModel != null) {
      this.permissionViewModel.listener(
          onDataChange: (List<PermissionModel> permissionModels) {
        this.createTab();
      });
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

  createTab() {
    if (this.permissionViewModel != null &&
        this.permissionViewModel.data != null &&
        this.permissionViewModel.data.length > 0) {
      bool isDashboard =
          this.checkShowTabWithPermission(EnumAdminPermission.Dashboard);
      bool isApprove =
          this.checkShowTabWithPermission(EnumAdminPermission.Approve);

      if (isDashboard || isApprove) {
        this.tabViews.add(AdministrationChildPage(
              type: EnumAdministrationTab.Assigned,
            ));
        this.tabs.add(
              Tab(
                text: StringResource.getText(
                    context, 'administration_assigned_title'),
              ),
            );
      }
      if (isDashboard || !isApprove) {
        this.tabViews.add(AdministrationChildPage(
              type: EnumAdministrationTab.Handled,
            ));
        this.tabs.add(
              Tab(
                text: StringResource.getText(
                    context, 'administration_handled_title'),
              ),
            );
      }
      if (isDashboard || isApprove) {
        this.tabViews.add(AdministrationChildPage(
              type: EnumAdministrationTab.Approved,
            ));
        this.tabs.add(Tab(
              text: StringResource.getText(
                  context, 'administration_approved_title'),
            ));
      }
      if (isApprove) {
        this.tabViews.add(AdministrationChildPage(
              type: EnumAdministrationTab.DoneAssignSupport,
            ));
        this.tabs.add(
              Tab(
                text: StringResource.getText(
                    context, 'administration_done_assign_support_title'),
              ),
            );
      }
      if (!isDashboard || !isApprove) {
        this.tabViews.add(AdministrationChildPage(
              type: EnumAdministrationTab.ReportSupport,
            ));
        this.tabs.add(
              Tab(
                text: StringResource.getText(
                    context, 'administration_report_support_title'),
              ),
            );
      }
      if (isDashboard) {
        this.tabViews.add(AdministrationChildPage(
              type: EnumAdministrationTab.Assign,
            ));
        this.tabViews.add(AdministrationChildPage(
              type: EnumAdministrationTab.Handle,
            ));
        this.tabViews.add(AdministrationChildPage(
              type: EnumAdministrationTab.Approve,
            ));
        this.tabs.add(
              Tab(
                text: StringResource.getText(
                    context, 'administration_assign_title'),
              ),
            );
        this.tabs.add(
              Tab(
                text: StringResource.getText(
                    context, 'administration_handle_title'),
              ),
            );
        this.tabs.add(Tab(
              text: StringResource.getText(
                  context, 'administration_approve_title'),
            ));
      }
      this.tabController =
          TabController(vsync: this._ticker, length: this.tabs.length);
      this._updateViewSubject.value = this.tabs.length > 0;
    }
  }

  @override
  void dispose() {
    this.tabController?.dispose();
    this._updateViewSubject.close();
  }
}

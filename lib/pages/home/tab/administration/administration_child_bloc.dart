import 'package:flutter/material.dart';
import 'package:orim/base/base_reponse.dart';
import 'package:orim/base/bloc.dart';
import 'package:orim/base/subject.dart';
import 'package:orim/config/enum_packages/enum_administration_tab.dart';
import 'package:orim/config/enum_packages/enum_assign.dart';
import 'package:orim/config/enum_packages/enum_issue.dart';
import 'package:orim/model/issue/issue.dart';
import 'package:orim/model/pagination/pagination_model.dart';
import 'package:orim/navigator_service.dart';
import 'package:orim/pages/issue_administration_detail/issue_administration_detail_page.dart';
import 'package:orim/viewmodel/issue_administration.dart';
import 'package:orim/viewmodel/issue_root_administration.dart';
import 'package:provider/provider.dart';

import 'administration_child_view.dart';

class AdministrationChildBloc extends BaseBloc {
  PaginationModel paginationModel;
  BehaviorSubject<List<IssueModel>> _issueSubject = BehaviorSubject();

  Stream<List<IssueModel>> get streamComplains => _issueSubject.stream;
  List<IssueModel> issues = [];
  List<int> liststatus;
  List<int> listAssignStatus;
  List<int> listStatusReview;
  AdministrationChildView _view;

  EnumAdministrationTab type;
  IssueiRootAdminViewModel issueiAdminRootViewModel;
  IssueiAdminViewModel issueiAdminViewModel;
  bool isRootAdmin = false;

  AdministrationChildBloc({BuildContext context, EnumAdministrationTab type, AdministrationChildView view})
      : this.type = type, this._view = view,
        super(context: context) {
    this.paginationModel = PaginationModel();
    switch (this.type) {
      case EnumAdministrationTab.Assigned:
        if (this.isRootAdmin) {
          this.liststatus = [
            IssueStatusEnum.HandlingStart, //11
            IssueStatusEnum.ExecuteAssign, //12
            IssueStatusEnum.ApprovedComplete, // 14
            IssueStatusEnum.RecycleIssue, // 34
            IssueStatusEnum.OutOfBound, // 44
          ];
        } else {
          this.listAssignStatus = EnumAssignStatus.EXECUTED;
          this.listStatusReview = [
            IssueStatusEnum.HandlingStart,
            IssueStatusEnum.SupportRequirements,
          ];
        }
        break;
      case EnumAdministrationTab.Handled:
        if (this.isRootAdmin) {
          this.liststatus = [
            IssueStatusEnum.ExecuteCompleted, //13
            IssueStatusEnum.RecycleIssueNotify, //33
            IssueStatusEnum.OutOfBoundNotify //43
          ];
        } else {
          this.listAssignStatus = EnumAssignStatus.EXECUTED;
          this.listStatusReview = [
            IssueStatusEnum.ExecuteAssign,
            IssueStatusEnum.SupportExecuteAssign,
          ];
        }
        break;
      case EnumAdministrationTab.Approved:
        if (this.isRootAdmin) {
          this.liststatus = [
            IssueStatusEnum.ApprovedComplete, //14
            IssueStatusEnum.RecycleIssue, //34
            IssueStatusEnum.OutOfBound //44
          ];
        } else {
          this.listAssignStatus = EnumAssignStatus.EXECUTED;
          this.listStatusReview = [
            IssueStatusEnum.ExecuteCompleted,
            IssueStatusEnum.RecycleIssueNotify,
            IssueStatusEnum.OutOfBoundNotify,
          ];
        }

        break;
      case EnumAdministrationTab.Assign:
        if (this.isRootAdmin) {
          this.liststatus = [
            IssueStatusEnum.HandlingStart, //11
            IssueStatusEnum.ExecuteAssign //12
          ];
        } else {
          this.listAssignStatus = EnumAssignStatus.NO_EXECUTE;
          this.liststatus = [
            IssueStatusEnum.HandlingStart,
            IssueStatusEnum.SupportRequirements,
          ];
        }
        break;
      case EnumAdministrationTab.Handle:
        if (this.isRootAdmin) {
          this.liststatus = [
            IssueStatusEnum.ExecuteAssign, //12
          ];
        } else {
          this.listAssignStatus = EnumAssignStatus.NO_EXECUTE;
          this.liststatus = [
            IssueStatusEnum.SupportExecuteAssign,
            IssueStatusEnum.ExecuteAssign,
          ];
        }

        break;
      case EnumAdministrationTab.Approve:
        if (this.isRootAdmin) {
          this.liststatus = [
            IssueStatusEnum.ExecuteCompleted, //13
            IssueStatusEnum.RecycleIssueNotify, //33
            IssueStatusEnum.OutOfBoundNotify //43
          ];
        } else {
          this.listAssignStatus = EnumAssignStatus.NO_EXECUTE;
          this.liststatus = [
            IssueStatusEnum.ExecuteCompleted,
            IssueStatusEnum.RecycleIssueNotify,
            IssueStatusEnum.OutOfBoundNotify,
          ];
        }

        break;
      case EnumAdministrationTab.DoneAssignSupport:
        if (this.isRootAdmin) {
          this.liststatus = [
            IssueStatusEnum.SupportExecuteAssign, //22
          ];
        } else {
          this.listAssignStatus = EnumAssignStatus.EXECUTED;
          this.listStatusReview = [
            IssueStatusEnum.SupportDeptAssign,
          ];
        }

        break;
      case EnumAdministrationTab.ReportSupport:
        if (this.isRootAdmin) {
          this.liststatus = [
            IssueStatusEnum.ExecuteCompletedSuport, //23
          ];
        } else {
          this.listAssignStatus = EnumAssignStatus.EXECUTED;
          this.listStatusReview = [
            IssueStatusEnum.SupportExecuteAssign,
          ];
        }

        break;
    }
  }

  @override
  void updateDependencies(BuildContext context) {
    super.updateDependencies(context);
    this.issueiAdminRootViewModel =
        Provider.of<IssueiRootAdminViewModel>(context);
    this.issueiAdminViewModel = Provider.of<IssueiAdminViewModel>(context);
  }

  void listenDataChange() {}

  Future<void> getIssues() async {
    List<IssueModel> res = [];
    ResponseListNew<IssueModel> response;
    if (this.isRootAdmin) {
      response = await this
          .issueiAdminRootViewModel
          .getIssuesWithStatusRootAdmin(
              listStatus: this.liststatus,
              paginationModel: this.paginationModel);
    } else {
      response = await this.issueiAdminViewModel.getIssuesWithStatus(
          listStatus: this.liststatus,
          listAssignStatus: this.listAssignStatus,
          listStatusReview: this.listStatusReview,
          paginationModel: this.paginationModel);
    }
    if (response.isSuccess()) {
      res = response.datas;
      this.issues = this.paginationModel.addData(this.issues, response.datas);
      this._issueSubject.value = this.issues;
    } else if (response.isExpired()) {
      this.observerLogout();
    } else {
      this._issueSubject.addError("");
      this._view.showPopupError(response.msg);
    }
  }

  void onRefresh() async {
    this.paginationModel.refreshOffset();
    await this.getIssues();
    return;
  }

  void onLoading() async {
    this.paginationModel.onLoadMore(this.issues.length);
    await this.getIssues();
    return;
  }

  goDetailComplain(IssueModel model) {
    IssueAdministrationDetailArguments arguments =
        IssueAdministrationDetailArguments(issue: model);
    NavigatorService.gotoIssueAdminDetail(context, argument: arguments);
  }

  @override
  void dispose() {
    this._issueSubject.close();
  }
}

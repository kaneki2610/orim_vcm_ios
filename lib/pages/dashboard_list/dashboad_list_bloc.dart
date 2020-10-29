import 'package:flutter/cupertino.dart';
import 'package:orim/base/base_reponse.dart';
import 'package:orim/base/bloc.dart';
import 'package:orim/base/subject.dart';
import 'package:orim/config/enum_packages/dashboard_list_type.dart';
import 'package:orim/config/enum_packages/enum_issue.dart';
import 'package:orim/config/strings_resource.dart';
import 'package:orim/model/issue/issue.dart';
import 'package:orim/model/pagination/pagination_model.dart';
import 'package:orim/pages/issue_administration_detail/issue_administration_detail_page.dart';
import 'package:orim/viewmodel/issue_root_administration.dart';
import 'package:provider/provider.dart';

import '../../navigator_service.dart';

class DashboardListBloc extends BaseBloc {
  BehaviorSubject<List<IssueModel>> _issueSubject = BehaviorSubject();

  Stream<List<IssueModel>> get streamComplains => _issueSubject.stream;
  List<IssueModel> issues = [];
  IssueiRootAdminViewModel issueiAdminRootViewModel;
  List<int> liststatus;
  DashboardListEnum type;
  String kindOfTime;
  String areaCodeStatic;
  PaginationModel paginationModel;

  DashboardListBloc(BuildContext context, DashboardListEnum type, {String kindOfTime, String areaCodeStatic}):super(context:context){
    this.paginationModel = PaginationModel();
    this.type = type;
    this.kindOfTime = kindOfTime;
    this.areaCodeStatic = areaCodeStatic;
    if(this.type == DashboardListEnum.PROCESSED){
      this.liststatus = [IssueStatusEnum.ApprovedComplete, IssueStatusEnum.RecycleIssue, IssueStatusEnum.OutOfBound,];
    }else{
      this.liststatus = [IssueStatusEnum.HandlingStart, IssueStatusEnum.ExecuteAssign, IssueStatusEnum.ExecuteCompleted,
        IssueStatusEnum.RecycleIssueNotify, IssueStatusEnum.OutOfBoundNotify, IssueStatusEnum.SupportRequirements,
        IssueStatusEnum.SupportDeptAssign, IssueStatusEnum.SupportExecuteAssign, IssueStatusEnum.ExecuteCompletedSuport,];
    }
  }

  @override
  void updateDependencies(BuildContext context) {
    this.issueiAdminRootViewModel =
        Provider.of<IssueiRootAdminViewModel>(context);
  }

  String getTitle(){
    return StringResource.getText(context, this.type == DashboardListEnum.PROCESSING ? "dashboard_list_title_process" : "dashboard_list_title_processed");
  }

  Future<void> getIssues() async {
    ResponseListNew<IssueModel> res = await this
        .issueiAdminRootViewModel
        .getIssuesWithStatusRootAdmin(listStatus: this.liststatus, areaCodeStatic: this.areaCodeStatic, kindOfTime: this.kindOfTime, paginationModel: this.paginationModel);
    if(res !=null) {
      this.issues = this.paginationModel.addData(this.issues, res.datas);
      this._issueSubject.value = this.issues;
    } else {
     this._issueSubject.value = [];
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
    IssueAdministrationDetailArguments arguments = IssueAdministrationDetailArguments(
        issue : model
    );
    NavigatorService.gotoIssueAdminDetail(context, argument: arguments);
  }

  @override
  void dispose() {
    this._issueSubject.close();
  }
}

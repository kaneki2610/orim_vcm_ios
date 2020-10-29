import 'package:flutter/cupertino.dart';
import 'package:orim/base/base_reponse.dart';
import 'package:orim/base/bloc.dart';
import 'package:orim/base/subject.dart';
import 'package:orim/model/issue/issue.dart';
import 'package:orim/model/process.dart';
import 'package:orim/pages/issue_map/issue_map_page.dart';
import 'package:orim/pages/issue_process/issue_process_page.dart';
import 'package:orim/utils/time_util.dart';
import 'package:orim/viewmodel/issue.dart';
import 'package:orim/viewmodel/issue_process.dart';
import 'package:provider/provider.dart';

import '../../navigator_service.dart';

class IssueAdministrationDetailBloc extends BaseBloc {
  static final keyAssign = "keyAssign";
  static final keyHandle = "keyHandle";
  static final keyAssignSupport = "keyAssignSupport";
  static final keySupport = "keySupport";

  IssueModel issue;
  IssueProcessViewModel issueProcessViewModel;

  BehaviorSubject<Map<String, IssueProcessModel>> _processSubject =
      BehaviorSubject();

  Stream<Map<String, IssueProcessModel>> get processStream =>
      _processSubject.stream;

  BehaviorSubject<bool> _issueSubject = BehaviorSubject();

  Stream<bool> get issueStream => _issueSubject.stream;

  Map<String, IssueProcessModel> processStatus = Map();

  IssueProcessModel get assignModel => processStatus[keyAssign];

  IssueProcessModel get handleModel => processStatus[keyHandle];

  IssueProcessModel get assignSupportModel => processStatus[keyAssignSupport];

  IssueProcessModel get supportModel => processStatus[keySupport];
  IssueViewModel _issueViewModel;
  String idIssue = "";

  IssueAdministrationDetailBloc(
    BuildContext context,
    this.issue,
      this.idIssue,
  ) : super(context: context);

  @override
  void updateDependencies(BuildContext context) {
    super.updateDependencies(context);
    issueProcessViewModel = Provider.of<IssueProcessViewModel>(context);
    _issueViewModel = Provider.of<IssueViewModel>(context);
  }

  Future<void> getStatusProcess() async {
    final ResponseListNew<IssueProcessModel> response =
        await issueProcessViewModel.getProcesses(issueId: this.issue?.id ?? this.idIssue);
    var ls = [];
    if(response.isSuccess()){
      ls = response.datas;
    }else if(response.isExpired()){
      this.observerLogout();
    }
    IssueProcessModel assign;
    IssueProcessModel handle;
    IssueProcessModel assignSupport;
    IssueProcessModel support;

    for (var step in ls) {
      String time = "";
      if (step.time != null) {
        time = TimeUtil.convertStringToTextDate(step.time) +
            " " +
            TimeUtil.convertStringToTextTime(step.time);
      }
      if (step.status == 12) {
        assign = step;
        assign.time = time;
        this.processStatus[keyAssign] = assign;
      } else if (step.status == 13) {
        handle = step;
        handle.time = time;
        this.processStatus[keyHandle] = handle;
      } else if (step.status == 22) {
        assignSupport = step;
        assignSupport.time = time;
        this.processStatus[keyAssignSupport] = assignSupport;
      } else if (step.status == 23) {
        support = step;
        support.time = time;
        this.processStatus[keySupport] = support;
      }
    }
    this._processSubject.value = this.processStatus;
  }

  Future<void> getIssue() async {
    if (this.issue == null) {
      ResponseListNew <IssueModel> res = await _issueViewModel.getIssueByIds([this.idIssue]);
      if(res.isSuccess()){
        if (res.datas.length > 0) {
          this.issue = res.datas.first;
          this._issueSubject.value = true;
        } else {
          this._issueSubject.addError("");
        }
      }else{
        this._issueSubject.addError("");
      }
    }
  }

  gotoProcessView() {
    showIssueProcess(context, issueId: issue.id);
  }

  gotoMap() {
    IssueMapPageArguments arguments = IssueMapPageArguments(
        location: issue.location, position: issue.position);
    NavigatorService.showModalIssueMap(context, arguments: arguments);
  }

  @override
  void dispose() {}
}

import 'package:flutter/cupertino.dart';
import 'package:orim/base/base_reponse.dart';
import 'package:orim/base/bloc.dart';
import 'package:orim/base/subject.dart';
import 'package:orim/model/process.dart';
import 'package:orim/viewmodel/issue_process.dart';
import 'package:provider/provider.dart';

import 'issue_process_view.dart';

class IssueProcessBloc extends BaseBloc {
  IssueProcessBloc(
      {BuildContext context, IssueProcessView view, String issueId})
      : issueId = issueId,
        view = view,
        super(context: context);

  final String issueId;
  final IssueProcessView view;

  IssueProcessViewModel issueProcessViewModel;

  BehaviorSubject<List<IssueProcessModel>> _issueProcessSubject =
      BehaviorSubject();

  Stream<List<IssueProcessModel>> get issueProcessObserver =>
      _issueProcessSubject.stream;

  @override
  void updateDependencies(BuildContext context) {
    super.updateDependencies(context);
    issueProcessViewModel = Provider.of<IssueProcessViewModel>(context);
  }

  Future<void> loadProcess() async {
    ResponseListNew<IssueProcessModel> res =
        await issueProcessViewModel.getProcesses(issueId: issueId);
    if (res.isSuccess()) {
      _issueProcessSubject.value = res.datas;
    }else if (res.isExpired()) {
      this.observerLogout();
    } else {
      view.showMessage(msg: res.msg);
      _issueProcessSubject.addError("");
    }
  }

  @override
  void dispose() {
    _issueProcessSubject.close();
  }
}

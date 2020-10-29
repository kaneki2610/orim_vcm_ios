import 'package:flutter/material.dart';
import 'package:orim/base/bloc.dart';
import 'package:orim/model/issue/issue.dart';
import 'package:orim/navigator_service.dart';
import 'package:orim/pages/home/tab/operating/operating_view.dart';
import 'package:orim/pages/issue_need_assign_execute_detail/issue_need_assign_execute_detail_page.dart';
import 'package:orim/viewmodel/department_support.dart';
import 'package:orim/viewmodel/issue_need_assign.dart';
import 'package:orim/viewmodel/officer.dart';
import 'package:orim/viewmodel/report_spam.dart';
import 'package:provider/provider.dart';

class OperatingBloc extends BaseBloc {
  OperatingBloc({BuildContext context, OperatingView view})
      : _view = view,
        super(context: context);

  final OperatingView _view;
  IssueNeedAssignViewModel issueNeedAssignViewModel;
  OfficerViewModel officerViewModel;
  DepartmentSupportViewModel departmentSupportViewModel;
  ReportSpamViewModel reportSpamViewModel;

  @override
  void updateDependencies(BuildContext context) {
    issueNeedAssignViewModel = Provider.of<IssueNeedAssignViewModel>(context);
    officerViewModel = Provider.of<OfficerViewModel>(context);
    departmentSupportViewModel = Provider.of<DepartmentSupportViewModel>(context);
    reportSpamViewModel = Provider.of<ReportSpamViewModel>(context);
  }

  Future<void> getIssues() async {

  }

  Future<void> getOfficer() async {
//    final List<OfficerModel> officers = await officerViewModel.getOfficers();
//    print(officers.length);
  }

  @override
  void dispose() {

  }
}

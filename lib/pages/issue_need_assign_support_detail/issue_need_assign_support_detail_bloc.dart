import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:orim/base/base_reponse.dart';
import 'package:orim/base/bloc.dart';
import 'package:orim/base/subject.dart';
import 'package:orim/config/strings_resource.dart';
import 'package:orim/model/issue/issue.dart';
import 'package:orim/model/officer.dart';
import 'package:orim/navigator_service.dart';
import 'package:orim/pages/issue_map/issue_map_page.dart';
import 'package:orim/pages/issue_process/issue_process_page.dart';
import 'package:orim/viewmodel/assign_support.dart';
import 'package:orim/viewmodel/officer.dart';
import 'package:provider/provider.dart';

import 'issue_need_assign_support_detail_page.dart';
import 'issue_need_assign_support_detail_view.dart';

class IssueNeedAssignSupportDetailBloc extends BaseBloc {
  IssueNeedAssignSupportDetailBloc(
      {BuildContext context,
      IssueNeedAssignSupportDetailView view,
      IssueNeedAssignSupportDetailPageArguments arguments})
      : _view = view,
        model = arguments.model,
        super(context: context);

  final IssueNeedAssignSupportDetailView _view;
  final IssueModel model;

  List<OfficerModel> officers = [];
  OfficerViewModel officerViewModel;
  AssignSupportViewModel assignSupportViewModel;

  BehaviorSubject<OfficerModel> _officer = BehaviorSubject<OfficerModel>();

  Stream<OfficerModel> get officersObserver => _officer.stream;

  final TextEditingController contentAssignController = TextEditingController();
  final FocusNode contentAssignFocusNode = FocusNode();
  BehaviorSubject<String> _contentAssign = BehaviorSubject();

  Stream<String> get contentAssign => _contentAssign.stream;

  StreamSubscription officerListener;

  @override
  void updateDependencies(BuildContext context) {
    super.updateDependencies(context);
    officerViewModel = Provider.of<OfficerViewModel>(context);
    assignSupportViewModel = Provider.of<AssignSupportViewModel>(context);
  }

  Future<void> loadData() {
    initObserver();
    loadOfficers();
  }

  void changeSpecialist({int index}) {
    if (officers != null && officers.length > index) {
      _officer.value = officers[index];
    }
  }

  Future<bool> loadOfficers() async {
    ResponseListNew<OfficerModel> response;
    response = await officerViewModel.getOfficers();
    if(response.isSuccess()) {
      return true;
    } else {
      return false;
    }
  }

  void sendAssign() async {
    if (_dataIsValid()) {
      await _view.showLoading();
      String content = contentAssignController.text.trim();
      OfficerModel officer = _officer.value;
      List<OfficerModel> assignee = List()..add(officer);
      final ResponseObject<bool> res = await assignSupportViewModel.assignSupport(
          issueId: model.id, contentAssign: content, assignee: assignee);
      await _view.hideLoading();
      if (res.isSuccess()) {
        _view.assignSupportSucceed();
        NavigatorService.back(context);
      }else if(res.isExpired()){
        this.observerLogout();
      } else {
        _view.showMessage(msg: res.msg);
      }
    }
  }

  @override
  void dispose() {
    _officer.close();
    contentAssignController.dispose();
    contentAssignFocusNode.dispose();
    _contentAssign.close();
    officerListener.cancel();
  }

  bool _dataIsValid() {
    OfficerModel officer = _officer.value;
    String content = contentAssignController.text.trim();
    if (officer == null) {
      _view.showMessageOfficerMissing();
      return false;
    }
    if (content == null || content.length == 0) {
      _contentAssign.addError(StringResource.getText(
          context, 'issue_need_assign_select_no_content_assign'));
      return false;
    } else {
      _contentAssign.value = null;
    }
    return true;
  }

  void initObserver() {
    officerListener = officerViewModel.listener(onDataChange: (data) {
      officers = data;
    });
  }

  void viewLocation() {
    IssueMapPageArguments arguments = IssueMapPageArguments(
        location: model.location, position: model.position);
    print('position: ${model.position.longitude} - ${model.position.latitude}');
    NavigatorService.showModalIssueMap(context, arguments: arguments);
  }

  void viewProcess() {
    showIssueProcess(context, issueId: model.id);
  }
}

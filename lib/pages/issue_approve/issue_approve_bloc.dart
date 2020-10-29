import 'package:flutter/cupertino.dart';
import 'package:orim/base/base_reponse.dart';
import 'package:orim/base/bloc.dart';
import 'package:orim/base/subject.dart';
import 'package:orim/config/enum_packages/enum_issue.dart';
import 'package:orim/config/strings_resource.dart';
import 'package:orim/entities/send_approved/send_approved_response.dart';
import 'package:orim/model/issue/issue.dart';
import 'package:orim/navigator_service.dart';
import 'package:orim/pages/issue_map/issue_map_page.dart';
import 'package:orim/pages/issue_process/issue_process_page.dart';
import 'package:orim/viewmodel/send_info_approve.dart';
import 'package:provider/provider.dart';

import 'issue_approve_page.dart';
import 'issue_approve_view.dart';

class IssueApproveBloc extends BaseBloc {
  IssueApproveBloc(
      {BuildContext context,
      IssueApproveView view,
      IssueApprovePageArgument argument})
      : model = argument.model,
        _view = view,
        super(context: context);

  final IssueApproveView _view;
  final IssueModel model;

  SendInfoApproveViewModel sendInfoApproveViewModel;

  TextEditingController contentAssignController = TextEditingController();
  FocusNode contentAssignFocusNode = FocusNode();

  BehaviorSubject<String> _contentSubject = BehaviorSubject();

  Stream<String> get contentAssign => _contentSubject.stream;

  @override
  void updateDependencies(BuildContext context) {
    super.updateDependencies(context);
    sendInfoApproveViewModel = Provider.of<SendInfoApproveViewModel>(context);
  }

  @override
  void dispose() {
    contentAssignController.dispose();
    contentAssignFocusNode.dispose();
    _contentSubject.close();
  }

  Future<void> loadData() async {}

  viewLocation() {
    IssueMapPageArguments arguments = IssueMapPageArguments(
        location: model.location, position: model.position);
    print('position: ${model.position.longitude} - ${model.position.latitude}');
    NavigatorService.showModalIssueMap(context, arguments: arguments);
  }

  viewProcess() {
    showIssueProcess(context, issueId: model.id);
  }

  submit() async {
    if (_dataIsValid()) {
      await _view.showLoading();
      String content = contentAssignController.text;
      final ResponseObject<bool> res = await sendInfoApproveViewModel
          .updateApprove(issueId: model.id, comment: content);
      await _view.hideLoading();
      if (res.isSuccess()) {
        if (res.data) {
          _view.showApproveSuccess();
          NavigatorService.back(context);
        } else {
          _view.showApproveFailed();
        }
      } else if (res.isExpired()) {
        this.observerLogout();
      } else {
        _view.showMessage(msg: res.msg);
      }
    }
  }

  bool _dataIsValid() {
    switch (model.status) {
      case IssueStatusEnum.SupportDeptAssign:
        if (model.supporters != null && model.supporters.length > 0) {
          _view.showMessage(
              msg:
                  '${StringResource.getText(context, 'unit')} ${model.supporters[0].name} ${StringResource.getText(context, 'no_assign_exe')}');
        }
        return false;
      case IssueStatusEnum.SupportExecuteAssign:
        if (model.supporters != null && model.supporters.length > 0) {
          _view.showMessage(
              msg:
                  '${StringResource.getText(context, 'specialist')} ${model.supporters[0].name} ${StringResource.getText(context, 'no_support_exe')}');
        }
        return false;
      default:
        String content = contentAssignController.text;
        if (content == null || content.isEmpty) {
          _contentSubject.addError(StringResource.getText(
              context, 'issue_approve_no_input_content_approve'));
          return false;
        } else {
          _contentSubject.value = null;
        }
        return true;
    }
  }
}

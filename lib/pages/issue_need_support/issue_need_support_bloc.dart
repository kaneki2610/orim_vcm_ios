import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:orim/base/base_reponse.dart';
import 'package:orim/base/bloc.dart';
import 'package:orim/base/subject.dart';
import 'package:orim/config/strings_resource.dart';
import 'package:orim/model/issue/issue.dart';
import 'package:orim/navigator_service.dart';
import 'package:orim/pages/issue_map/issue_map_page.dart';
import 'package:orim/pages/issue_process/issue_process_page.dart';
import 'package:orim/viewmodel/officer.dart';
import 'package:orim/viewmodel/send_info_support.dart';
import 'package:provider/provider.dart';

import 'issue_need_support_page.dart';
import 'issue_need_support_view.dart';

class IssueNeedSupportBloc extends BaseBloc {
  IssueNeedSupportBloc(
      {BuildContext context,
      IssueNeedSupportArgument arguments,
      IssueNeedSupportView view})
      : model = arguments.model,
        _view = view,
        super(context: context) {
    print('id: ${model.id}');
  }

  final IssueModel model;
  final IssueNeedSupportView _view;
  OfficerViewModel officerViewModel;
  SendInfoSupportViewModel sendInfoSupportViewModel;

  TextEditingController contentAssignController = TextEditingController();
  FocusNode contentAssignFocusNode = FocusNode();

  BehaviorSubject<String> _contentSupportSubject = BehaviorSubject();

  Stream<String> get contentAssign => _contentSupportSubject.stream;

  StreamSubscription officerListener;

  @override
  void dispose() {
    contentAssignFocusNode.dispose();
    contentAssignController.dispose();
    _contentSupportSubject.close();
    officerListener.cancel();
  }

  // ignore: missing_return
  Future<void> loadData() {
    initObserver();
  }

  @override
  void updateDependencies(BuildContext context) {
    super.updateDependencies(context);
    officerViewModel = Provider.of<OfficerViewModel>(context);
    sendInfoSupportViewModel = Provider.of<SendInfoSupportViewModel>(context);
  }

  void initObserver() {

  }

  Future<void> submit() async {
    if (dataIsValid()) {
      await _view.showLoading();
      String content = contentAssignController.text;
      final ResponseObject<bool> res = await sendInfoSupportViewModel.sendInfoSupport(
          issueId: model.id, comment: content);
      await _view.hideLoading();
      if (res.isSuccess()) {
        _view.showMessageSendInfoSupportSuccess();
        NavigatorService.back(context);
      } else if(res.isExpired()){
        this.observerLogout();
      }else {
        _view.showMessageSendInfoSupportFailed();
      }
    }
  }

  bool dataIsValid() {
    String content = contentAssignController.text;
    if (content == null || content.isEmpty) {
      _contentSupportSubject.addError(StringResource.getText(context, 'issue_process_no_content_support'));
      return false;
    } else {
      _contentSupportSubject.value = null;
    }
    return true;
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

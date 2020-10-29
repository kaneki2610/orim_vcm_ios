import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:orim/base/base_reponse.dart';
import 'package:orim/base/bloc.dart';
import 'package:orim/base/subject.dart';
import 'package:orim/config/enum_packages/enum_group_responsible.dart';
import 'package:orim/config/strings_resource.dart';
import 'package:orim/model/department/department.dart';
import 'package:orim/model/issue/issue.dart';
import 'package:orim/model/officer.dart';
import 'package:orim/navigator_service.dart';
import 'package:orim/pages/issue_map/issue_map_page.dart';
import 'package:orim/pages/issue_process/issue_process_page.dart';
import 'package:orim/pages/show_full_gallery/show_full_meida.dart';
import 'package:orim/viewmodel/assign_execute.dart';
import 'package:orim/viewmodel/department_assign_unit.dart';
import 'package:orim/viewmodel/department_support.dart';
import 'package:orim/viewmodel/officer.dart';
import 'package:orim/viewmodel/report_spam.dart';
import 'package:provider/provider.dart';

import 'issue_need_assign_execute_detail_view.dart';

class IssueNeedAssignDetailBloc extends BaseBloc {
  IssueNeedAssignDetailBloc(
      {BuildContext context, IssueModel model, IssueNeedAssignDetailView view})
      : model = model,
        _view = view,
        super(context: context) {
    if (model.officerAssigned.length > 0) {
      officers.add(model.officerAssigned[0]);
      _officer.value = model.officerAssigned[0];
    }
  }

  final IssueModel model;
  final IssueNeedAssignDetailView _view;

  OfficerViewModel officerViewModel;
  DepartmentSupportViewModel departmentSupportViewModel;
  ReportSpamViewModel reportSpamViewModel;
  DepartmentAssignUnitViewModel departmentAssignUnitViewModel;
  AssignExecuteViewModel assignExecuteViewModel;

  List<OfficerModel> officers = [];
  List<DepartmentModel> departmentsSupport = [];
  List<DepartmentModel> departmentsUnit = [];

  BehaviorSubject<Responsible> _responsibleSelected =
      BehaviorSubject<Responsible>(value: Responsible.SPECIALIST);

  Stream<Responsible> get responsibleObserver => _responsibleSelected.stream;

  BehaviorSubject<OfficerModel> _officer = BehaviorSubject<OfficerModel>();

  Stream<OfficerModel> get officersObserver => _officer.stream;

  BehaviorSubject<DepartmentModel> _departmentSupport =
      BehaviorSubject<DepartmentModel>();

  Stream<DepartmentModel> get departmentSupportObserver =>
      _departmentSupport.stream;

  final TextEditingController contentAssignController = TextEditingController();
  final FocusNode contentAssignFocusNode = FocusNode();
  BehaviorSubject<String> _contentAssign = BehaviorSubject();

  Stream<String> get contentAssign => _contentAssign.stream;

  final TextEditingController contentSupportController =
      TextEditingController();
  final FocusNode contentSupportFocusNode = FocusNode();

  BehaviorSubject<DepartmentModel> _departmentUnit = BehaviorSubject();

  Stream<DepartmentModel> get departmentUnitObserver => _departmentUnit.stream;

  StreamSubscription officerListener;

  @override
  void updateDependencies(BuildContext context) {
    super.updateDependencies(context);
    officerViewModel = Provider.of<OfficerViewModel>(context);
    departmentSupportViewModel =
        Provider.of<DepartmentSupportViewModel>(context);
    reportSpamViewModel = Provider.of<ReportSpamViewModel>(context);
    departmentAssignUnitViewModel =
        Provider.of<DepartmentAssignUnitViewModel>(context);
    assignExecuteViewModel = Provider.of<AssignExecuteViewModel>(context);
  }

  Future<void> loadData() async {
    initObserver();
    bool isSuccess = await loadOfficers();
    if(isSuccess){
      bool isSuccessDepart = await loadDepartmentsSupport();
      if(isSuccessDepart){
        loadDepartmentUnit();
      }
    }
  }

  void showImageView(int index) {
    if (model.imageAttachments != null && model.imageAttachments.length > 0) {
      ShowFullMediaArguments arguments = ShowFullMediaArguments(
          medias: model.imageAttachments, positionSelect: index);
      NavigatorService.gotoShowFullGallery(context, arguments: arguments);
    }
  }

  void showVideoView(int index) {
    if (model.videoAttachments != null && model.videoAttachments.length > 0) {
      ShowFullMediaArguments arguments = ShowFullMediaArguments(
          medias: model.videoAttachments, positionSelect: index);
      NavigatorService.gotoShowFullGallery(context, arguments: arguments);
    }
  }

  void changeResponsible(Responsible value) {
    _responsibleSelected.value = value;
  }

  void changeSpecialist({int index}) {
    if (officers != null && officers.length > index) {
      _officer.value = officers[index];
    }
  }

  void changeSupportUnit({int index}) {
    if (departmentsSupport != null && departmentsSupport.length > index) {
      _departmentSupport.value = departmentsSupport[index];
    }
  }

  void removeDepartmentSupport() {
    _departmentSupport.value = null;
  }

  void changeDepartmentUnit({int index}) {
    if (departmentsUnit != null && departmentsUnit.length > index) {
      _departmentUnit.value = departmentsUnit[index];
    }
  }

  Future<void> report() async {
    await _view.showLoading();
    final ResponseObject<bool> res = await reportSpamViewModel.reportSpam(issueId: model.id);
    await _view.hideLoading();
    if (res.isSuccess()) {
      _view.sendReportSucceed();
      _view.back();
    } else if(res.isExpired()){
      this.observerLogout();
    }
    else{
      _view.sendReportFailed();
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

  Future<bool> loadDepartmentsSupport() async {
    ResponseListNew<DepartmentModel> response;
    response = await departmentSupportViewModel.getSupports();
    if (response.isSuccess()) {
      departmentsSupport = response.datas;
      return true;
    } else {
      this._view.showPopUpSupportError();
      print("${response.msg}");
      return false;
    }
  }

  Future<bool> loadDepartmentUnit() async {
    ResponseListNew<DepartmentModel> response;
    response = await departmentAssignUnitViewModel.getDepartments();
    if (response.isSuccess()) {
      departmentsUnit = response.datas;
      return true;
    } else {
      this._view.showPopUpSupportError();
      return false;
    }
  }

  Future<void> sendAssign() async {
    if (_dataIsValid()) {
      Responsible responsible = _responsibleSelected.value;
      switch (responsible) {
        case Responsible.DEPARTMENT:
          await sendAssignDepartment();
          break;
        case Responsible.SPECIALIST:
          await sendAssignSpecialist();
          break;
      }
    }
  }

  bool _dataIsValid() {
    String content = contentAssignController.text;
    Responsible responsible = _responsibleSelected.value;
    switch (responsible) {
      case Responsible.SPECIALIST:
        OfficerModel officer = _officer.value;
        if (officer == null) {
          _view.showErrorNoSelectSpecialist();
          return false;
        }
        break;
      case Responsible.DEPARTMENT:
        DepartmentModel department = _departmentUnit.value;
        if (department == null) {
          _view.showErrorNoSelectDepartment();
          return false;
        }
        break;
    }
    if (content == null || content.length == 0) {
      _contentAssign.addError(StringResource.getText(
          context, 'issue_need_assign_select_no_content_assign'));
      contentAssignFocusNode.requestFocus();
      return false;
    } else {
      _contentAssign.value = '';
      contentAssignFocusNode.unfocus();
    }
    return content != '';
  }

  @override
  void dispose() {
    _responsibleSelected.close();
    _officer.close();
    _departmentSupport.close();
    contentAssignController.dispose();
    contentAssignFocusNode.dispose();
    _contentAssign.close();
    contentSupportController.dispose();
    contentSupportFocusNode.dispose();
    _departmentUnit.close();
    officerListener.cancel();
  }

  Future<void> sendAssignSpecialist() async {
    _view.showLoading();
    String content = contentAssignController.text.trim();
    String contentSupport = contentSupportController.text.trim();
    OfficerModel officer = _officer.value;
    DepartmentModel departmentSupport = _departmentSupport.value;
    List<OfficerModel> assignee = List()..add(officer);
    List<DepartmentModel> supporters = [];
    if (departmentSupport != null) {
      supporters.add(departmentSupport);
    } else {
      contentSupport = '';
      supporters = [];
    }
    final ResponseObject<bool> res =
        await assignExecuteViewModel.assignSpecialistExecute(
            issueId: model.id,
            contentAssign: content,
            supportContentAssign: contentSupport,
            assignee: assignee,
            supporters: supporters);
    if (res.isSuccess()) {
      _view.sendAssignExecuteSuccess();
      _view.hideLoading();
      _view.back();
    } else if (res.isExpired()) {
      this.observerLogout();
    } else {
      _view.hideLoading();
      _view.sendAssignExecuteFailed();
    }
  }

  Future<void> sendAssignDepartment() async {
    _view.showLoading();
    String content = contentAssignController.text;
    DepartmentModel departmentExecute = _departmentUnit.value;
    List<DepartmentModel> assignee = List()..add(departmentExecute);
    final ResponseObject<bool> res =
        await assignExecuteViewModel.assignDepartmentExecute(
            issueId: model.id, contentAssign: content, assignee: assignee);
    if (res.isSuccess()) {
      _view.hideLoading();
      _view.sendAssignExecuteSuccess();
      _view.back();
    } else if (res.isExpired()) {
      this.observerLogout();
    } else {
      _view.hideLoading();
      _view.sendAssignExecuteFailed();
    }
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

class DataAssign {
  Responsible responsible;
}

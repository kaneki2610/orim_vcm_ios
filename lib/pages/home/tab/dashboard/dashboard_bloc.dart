import 'package:flutter/material.dart';
import 'package:orim/base/base_reponse.dart';
import 'package:orim/base/bloc.dart';
import 'package:orim/base/subject.dart';
import 'package:orim/config/drawer_menu_config.dart';
import 'package:orim/config/enum_packages/dashboard_list_type.dart';
import 'package:orim/model/dashboardarea/dashboard_area.dart';
import 'package:orim/model/dashboardarea/dashboard_object.dart';
import 'package:orim/model/dashboardarea/services_area.dart';
import 'package:orim/model/department/department.dart';
import 'package:orim/model/permission/permission.dart';
import 'package:orim/navigator_service.dart';
import 'package:orim/pages/dashboard_list/dashboad_list_page.dart';
import 'package:orim/pages/home/tab/dashboard/dashboard_view.dart';
import 'package:orim/viewmodel/dashboard.dart';
import 'package:provider/provider.dart';


class DashboardBloc extends BaseBloc {
  DashboardBloc({BuildContext context, DashboardView view})
      : _view = view,
        super(context: context);

  DashBoardViewModel _dashBoardViewModel;
  List<DashBoardAreaModel> listModel;
  DashBoardObjectModel _areaObject;
  DashBoardObjectModel get  areaObject => _areaObject;
  final DashboardView _view;

  BehaviorSubject <List<DashBoardAreaModel>> _dashBoardSubject = BehaviorSubject();
  Stream<List<DashBoardAreaModel>> get streamDashBoard => _dashBoardSubject.stream;

  BehaviorSubject <DashBoardObjectModel> _dashBoardTotalSubject = BehaviorSubject();
  Stream<DashBoardObjectModel> get streamTotalDashBoard => _dashBoardTotalSubject.stream;

  BehaviorSubject<String> _kindTimeSubject = BehaviorSubject(value: "year");
  Stream<String> get streamKindOfTime => _kindTimeSubject.stream;

  BehaviorSubject<String> _nameAreaSubject = BehaviorSubject();
  Stream<String> get streamNameArea => _nameAreaSubject.stream;

  BehaviorSubject<DashBoardAreaModel> _sendServicesSubject = BehaviorSubject();
  Stream<DashBoardAreaModel> get chartServices => _sendServicesSubject.stream;

  BehaviorSubject<bool> _enableDasBoardSubject = BehaviorSubject();
  Stream<bool> get enableDasBoardStream => _enableDasBoardSubject.stream;

  @override
  void updateDependencies(BuildContext context) {
    _dashBoardViewModel = Provider.of<DashBoardViewModel>(context);
    super.updateDependencies(context);

  }
  Future<void> onChangeFilterTime(value) async {
    if (_kindTimeSubject.value != value) {
      _kindTimeSubject.value = value;
      this.getTotalAreaDashBoard();
    }
  }

  void changeService(DashBoardAreaModel model){
    print("service area code: " + model.codeArea);
    _sendServicesSubject.value = model;

  }

  void listenDataChange() {
    if (this.permissionViewModel != null) {
      this.permissionViewModel.listener(
          onDataChange: (List<PermissionModel> permissionModels) {
            this.createTab();
          });
    }
  }

  void createTab() {
    if (this.permissionViewModel != null &&
        this.permissionViewModel.data != null &&
        this.permissionViewModel.data.length > 0) {
      bool isDashboard = this.checkShowTabWithPermission(DrawerMenuConfig.dashboard_menu_app);
      if (isDashboard) {
        this._enableDasBoardSubject.value = true;
      } else {
        this._enableDasBoardSubject.value = false;
      }
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

  // get services with number > 0
  List<ServicesAreaModel> getValidServices( DashBoardAreaModel model) {
    List<ServicesAreaModel> listServicesCurrent = new List<ServicesAreaModel>();
    for(int i  = 0; i< model.listService.length;i++) {
      if(model.listService[i].number > 0) {
        listServicesCurrent.add(model.listService[i]);
      }
    }
    return listServicesCurrent;
  }

  void changeHeaderService({DashBoardObjectModel model}){
//    print("service area code: " + model.codeArea);
    DashBoardAreaModel dashBoardAreaModel = new DashBoardAreaModel();
    dashBoardAreaModel.nameArea = model.nameArea;
    dashBoardAreaModel.codeArea =model.codeArea;
    dashBoardAreaModel.sumIssue = model.sumIssue;
    dashBoardAreaModel.processing = model.processing;
    dashBoardAreaModel.processed = model.processed;
    dashBoardAreaModel.listService = model.listService;
    _sendServicesSubject.value = dashBoardAreaModel;

  }
  void goToDashboardList(DashBoardAreaModel model, DashboardListEnum type){
    DashboardListArguments arguments = DashboardListArguments(kindOfTime: this._kindTimeSubject.value, areaCodeStatic: model.codeArea, type: type);
    NavigatorService.gotoDashboardList(context, argument: arguments);
  }

  Future<DashBoardObjectModel> getTotalAreaDashBoard() async {
    ResponseObject<DashBoardObjectModel> response;
    response = await _dashBoardViewModel.getTotalDashBoard(_kindTimeSubject.value);
    List<DepartmentModel> listCode = await _dashBoardViewModel.getAreaDepartmentStatic();
    _nameAreaSubject.value = listCode[0].name;

    if (response.isSuccess()) {
      this._areaObject = response.data;
      this._areaObject.nameArea = _nameAreaSubject.value;
      _dashBoardTotalSubject.value = this._areaObject;
      _dashBoardSubject.value = this._areaObject.listDashBoard;
      this.changeHeaderService(model: _dashBoardTotalSubject.value);
    } else if (response.isExpired()) {
      this.observerLogout();
    } else {
      this._dashBoardTotalSubject.addError("");
      this._view.showPopupError(response.msg);
    }

    return _areaObject;
  }

  int calculatorPercents(int a, int b) {
    if (b > 0) {
      return ((a / b) * 100).round();
    } else {
      return 0;
    }
  }

  @override
  void dispose() {
    _dashBoardSubject.close();
    _dashBoardTotalSubject.close();
  }
}

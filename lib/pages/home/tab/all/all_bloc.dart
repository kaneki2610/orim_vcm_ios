import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:orim/base/base_reponse.dart';
import 'package:orim/base/bloc.dart';
import 'package:orim/config/imgs_resource.dart';
import 'package:orim/config/strings_resource.dart';
import 'package:orim/entities/category/categories_model.dart';
import 'package:orim/model/issue/issue.dart';
import 'package:orim/model/pagination/pagination_model.dart';
import 'package:orim/model/province.dart';
import 'package:orim/model/ward.dart';
import 'package:orim/navigator_service.dart';
import 'package:orim/observer/create_issue.dart';
import 'package:orim/pages/issue_detail/issue_detail_page.dart';
import 'package:orim/viewmodel/issues_area.dart';
import 'package:orim/viewmodel/province_info.dart';
import 'package:orim/viewmodel/ward_info.dart';
import 'package:provider/provider.dart';
import 'package:orim/base/subject.dart';

import 'all_view.dart';

class AllBloc extends BaseBloc {
  AllBloc({BuildContext context, AllView view})
      : this._view = view,
        super(context: context) {
    this.paginationModel = PaginationModel();
    subscriptionFilter = _wardSubject?.listen(onFilterChange);
  }

  PaginationModel paginationModel;
  final AllView _view;
  ProvinceInfoViewModel _provinceInfoViewModel;
  WardInfoViewModel _wardInfoViewModel;
  IssuesAreaViewModel _issuesAreaViewModel;

  List<ProvinceModel> provinces = [];
  int provinceSelected = -1;

  BehaviorSubject<String> _provinceSubject = BehaviorSubject();

  Stream<String> get provinceObserver => _provinceSubject.stream;
  CreateIssueObserver _createIssueObServer;

  List<WardModel> wards = [];
  int wardSelected = 0;

  BehaviorSubject<String> _wardSubject = BehaviorSubject();

  Stream<String> get wardObserver => _wardSubject.stream;

  List<IssueModel> issuesArea;
  List<IssueModel> issues = [];
  BehaviorSubject<List<IssueModel>> _issuesAreaSubject = BehaviorSubject();

  Stream<List<IssueModel>> get issuesAreaObserver => _issuesAreaSubject.stream;
  StreamSubscription<String> subscriptionFilter;

  @override
  void updateDependencies(BuildContext context) {
    super.updateDependencies(context);
    _provinceInfoViewModel = Provider.of<ProvinceInfoViewModel>(context);
    _wardInfoViewModel = Provider.of<WardInfoViewModel>(context);
    _issuesAreaViewModel = Provider.of<IssuesAreaViewModel>(context);
    this._createIssueObServer = Provider.of<CreateIssueObserver>(context);
  }

  @override
  void dispose() {
    subscriptionFilter?.cancel();
    _provinceSubject.close();
    _wardSubject.close();
    _issuesAreaSubject.close();
  }

  listenDataChange() {
    _createIssueObServer.listener(
      onDataChange: (status) {
        this.onRefresh();
      },
    );
  }

  Future<void> getWards() async {
    if (this.helperViewModel.appConfigModel.areaCodeCurrent != "") {
      _wardSubject.value = StringResource.getText(context, 'all_ward');
      try {
        wards.addAll(await _wardInfoViewModel.getWards(
            codeProvince: int.parse(
                this.helperViewModel.appConfigModel.areaCodeCurrent)));
        wards.insert(
            0,
            WardModel(
                code: null, name: StringResource.getText(context, 'all_ward')));
      } catch (err) {
        print(err);
      }
    }
  }

  void updateProvinceSelected(int index) {
    if (provinceSelected != index) {
      provinceSelected = index;
      wardSelected = -1;
      if (provinces.length > provinceSelected) {
        _provinceSubject.value = provinces[provinceSelected].name;
        if (provinceSelected == 0) {
          wardSelected = 0;
          _wardSubject.value = StringResource.getText(context, 'all_ward');
        } else {
          _wardSubject.value = null;
        }
      }
    }
  }

  void updateWardSelected(int index) {
    if (wardSelected != index) {
      wardSelected = index;
      if (wards.length > wardSelected) {
        _wardSubject.value = wards[wardSelected].name;
      }
    }
  }

  Future<void> getIssueArea() async {
    String areaCode = '';
    if (this.helperViewModel.appConfigModel.isDistrict) {
      areaCode = this.helperViewModel.appConfigModel.areaCodeCurrent;
    } else {
      if (wardSelected == 0) {
        areaCode = this.helperViewModel.appConfigModel.areaCodeCurrent;
      } else {
        areaCode = wards[wardSelected].code;
      }
    }
    ResponseListNew<IssueModel> response = await _issuesAreaViewModel
        .getIssueArea(areaCode, this.paginationModel.getPaginationIssueArea());
    if (response.isSuccess()) {
      issuesArea = response.datas;
      if (this.issuesArea.length != 0) {
        this.issues = this.paginationModel.addData(this.issues, issuesArea);
        _issuesAreaSubject.value = this.issues;
      } else {
        _issuesAreaSubject.value = [];
      }
    } else {
      _issuesAreaSubject.addError('no_data_issues_area');
    }
  }

  onFilterChange(_) {
    this.issues.clear();
    _issuesAreaSubject.value = null; // show loading
    getIssueArea();
  }

  bool get disableSelectWard {
    if (this.helperViewModel.appConfigModel.isDistrict) {
      return true;
    }
    return false;
  }

  String getCategoryIcon(String categoryName) {
    String icon = '';
    List<CategoriesModel> categoriesModel = this.helperViewModel.categories;
    for (CategoriesModel obj in categoriesModel) {
      if (obj.name == categoryName) {
        if (obj.icon == "" || obj.icon == null) {
          icon = "";
        } else {
          icon = obj.icon;
        }
        break;
      }
    }
    return icon;
  }

  gotoIssueDetail(IssueModel model) {
    IssueDetailArguments arguments =
        IssueDetailArguments(model: model, isFromHistoryPage: false);
    NavigatorService.gotoDetailIssue(context, arguments: arguments);
  }

  onRefresh() async {
    this.paginationModel.refreshOffset();
    await this.getIssueArea();
    return;
  }

  onLoadMore() async {
    this.paginationModel.onLoadMore(this.issues.length);
    await this.getIssueArea();
    return;
  }
}

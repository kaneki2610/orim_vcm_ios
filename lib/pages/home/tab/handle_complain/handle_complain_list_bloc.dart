import 'package:flutter/cupertino.dart';
import 'package:orim/base/base_reponse.dart';
import 'package:orim/base/bloc.dart';
import 'package:orim/model/pagination/pagination_model.dart';
import 'package:orim/navigator_service.dart';
import 'package:orim/pages/issue_approve/issue_approve_page.dart';
import 'package:orim/pages/issue_need_assign_execute_detail/issue_need_assign_execute_detail_page.dart';
import 'package:orim/pages/issue_need_assign_support_detail/issue_need_assign_support_detail_page.dart';
import 'package:orim/pages/issue_need_execute/issue_need_execute_page.dart';
import 'package:orim/pages/issue_need_support/issue_need_support_page.dart';
import 'package:orim/utils/time_util.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../base/subject.dart';
import '../../../../config/enum_packages/enum_assign.dart';
import '../../../../config/enum_packages/enum_issue.dart';
import '../../../../model/issue/issue.dart';
import '../../../../viewmodel/issue_need_assign.dart';
import 'handle_complain_child_bloc.dart';
import 'handle_complain_list_view.dart';
import 'mobx/handle_complain_mobx.dart';

class HandleComplainListBloc extends BaseBloc {
  BehaviorSubject<List<IssueModel>> _complainsSubject = BehaviorSubject();
  PaginationModel paginationModel;
  Stream<List<IssueModel>> get streamComplains => _complainsSubject.stream;
  ComplainMobx _complainMobx;
  int indexTabParent = 0;
  IssueNeedAssignViewModel issueNeedAssignViewModel;
  HandleComplainListType type;
  List<IssueModel> complainsOrigin = [];
  List<int> listAssignStatus;
  List<int> liststatus;
  String keySearch;
  String dateFilter;
  HandlecomplainListView _view;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  ScrollController scrollController;

  HandleComplainListBloc(BuildContext context, HandleComplainListType type,
      int indexTabParent, ComplainMobx mobx, ScrollController scrollController, HandlecomplainListView view)
      : this.type = type,
        this.indexTabParent = indexTabParent,
        this._complainMobx = mobx,
        this.scrollController = scrollController,
        this._view = view,
        super(context: context) {
    this.paginationModel = PaginationModel();
    if (this.type == HandleComplainListType.assigned_handling) {
      this.liststatus = [
        IssueStatusEnum.HandlingStart, //10
        IssueStatusEnum.SupportRequirements //20
      ];
      this.listAssignStatus = EnumAssignStatus.NO_EXECUTE; //0
    } else if (this.type == HandleComplainListType.assigned_support) {
      this.liststatus = [IssueStatusEnum.SupportDeptAssign]; //21
      this.listAssignStatus = EnumAssignStatus.NO_EXECUTE; //0
    } else if (this.type == HandleComplainListType.handling_handling) {
      this.liststatus = [IssueStatusEnum.ExecuteAssign]; //12
      this.listAssignStatus = EnumAssignStatus.NO_EXECUTE; //0
    } else if (this.type == HandleComplainListType.handling_support) {
      this.liststatus = [IssueStatusEnum.SupportExecuteAssign]; //22
      this.listAssignStatus = EnumAssignStatus.NO_EXECUTE; //0
    } else {
      this.liststatus = [
        IssueStatusEnum.ExecuteCompleted,
        IssueStatusEnum.RecycleIssueNotify,
        IssueStatusEnum.OutOfBoundNotify
      ]; // 13 33 43
      this.listAssignStatus = EnumAssignStatus.NO_EXECUTE; //0
    }
  }

  @override
  void updateDependencies(BuildContext context) {
    super.updateDependencies(context);
    this.issueNeedAssignViewModel = Provider.of<IssueNeedAssignViewModel>(context);
  }

  listenDataChange() {
    this.issueNeedAssignViewModel.listenerSearch(onDataChange: (key) {
      if (this.indexTabParent == this._complainMobx.indexCurrentTab) {
        if (this.keySearch != key) {
          search(key);
        }
      }
    });
    this.issueNeedAssignViewModel.listenerCalendar(onDataChange: (date) {
      if (this.indexTabParent == this._complainMobx.indexCurrentTab) {
        if (date != this.dateFilter) {
          filter(date);
        }
      }
    });
  }

  void refreshOffset() {
    paginationModel.refreshOffset();
  }

  Future<void> getIssues() async {
     ResponseListNew<IssueModel> res = await issueNeedAssignViewModel
        .getIssuesWithStatus(listAssignStatus: this.listAssignStatus, listStatus: this.liststatus, paginationModel: this.paginationModel);
    if(res.isSuccess()) {
      this.complainsOrigin = this.paginationModel.addData(this.complainsOrigin, res.datas);
      if ((this.keySearch != null && this.keySearch != "") ||
          this.dateFilter != null && this.dateFilter != "") {
        this._searchData();
      } else {
        this._complainsSubject.value = this.complainsOrigin;
      }
    } else if(res.isExpired()) {
      this.observerLogout();
    }else{
      this.complainsOrigin = [];
      this._complainsSubject.addError("");
      this._view.showPopupError(res.msg);
    }

  }

  search(String key) {
    this.keySearch = key;
    this._searchData();
  }

  filter(String date) {
    this.dateFilter = date;
    this._searchData();
  }

  _searchData() {
    if (this.complainsOrigin != null) {
      final List<IssueModel> filter = this.complainsOrigin.where((item) {
        bool result = this._checkTime(item) && this._checkKey(item);
        return result;
      }).toList();

      this._complainsSubject.value = filter;
    }
  }

  _checkTime(IssueModel model) {
    if (this.dateFilter == null || this.dateFilter == "") {
      return true;
    }

    var endDate = DateTime.now();
    var startDate = DateTime.parse(
        TimeUtil.convertDdmmyyyToYyyyMMdd(this.dateFilter) + ' 00:00:00.000');
    DateTime currentDate = DateTime.parse(
        TimeUtil.convertDdmmyyyToYyyyMMdd(model.dateText) + ' 00:00:01.000');
    return currentDate.isBefore(endDate) && currentDate.isAfter(startDate);
  }

  bool _checkKey(IssueModel model) {
    if (this.keySearch == null || this.keySearch == "") {
      return true;
    }
    return model.content.toLowerCase().contains(this.keySearch.toLowerCase());
  }

  Future<void> onRefresh() async {
    this.paginationModel.refreshOffset();
    await this.getIssues();
    return;
  }

  void onLoading() async {
    this.paginationModel.onLoadMore(this.complainsOrigin.length);
    await this.getIssues();
    return;
  }

  goDetailComplain(IssueModel model) {
    switch (type) {
      case HandleComplainListType.assigned_handling:
        IssueNeedAssignExecuteDetailPageArguments arguments =
            IssueNeedAssignExecuteDetailPageArguments(model: model);
        NavigatorService.gotoIssueNeedAssignDetail(context,
            arguments: arguments, callBackWhenBack: this.onRefresh);
        break;
      case HandleComplainListType.assigned_support:
        IssueNeedAssignSupportDetailPageArguments arguments =
            IssueNeedAssignSupportDetailPageArguments(model: model);
        NavigatorService.gotoIssueNeedAssignSupportDetail(context,
            arguments: arguments, callBackWhenBack: this.onRefresh);
        break;
      case HandleComplainListType.handling_handling:
        IssueNeedExecuteArgument arguments =
            IssueNeedExecuteArgument(model: model);
        NavigatorService.gotoIssueNeedExecute(context, arguments: arguments);
        break;
      case HandleComplainListType.handling_support:
        IssueNeedSupportArgument arguments =
            IssueNeedSupportArgument(model: model);
        NavigatorService.gotoIssueNeedSupport(context, arguments: arguments, callBackWhenBack: this.onRefresh);
        break;
      case HandleComplainListType.approved:
        IssueApprovePageArgument argument =
            IssueApprovePageArgument(model: model);
        NavigatorService.gotoIssueApprove(context, argument: argument, callBackWhenBack: this.onRefresh);
        break;
      default:
        print('no type');
        break;
    }
  }

  bool isShowResolvedComment(){
    return this.type == HandleComplainListType.approved;
  }

  @override
  void dispose() {
    this.refreshController.dispose();
    this._complainsSubject.close();
  }
}

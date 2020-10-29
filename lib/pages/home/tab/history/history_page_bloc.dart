import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:orim/base/base_reponse.dart';
import 'package:orim/base/subject.dart';
import 'package:orim/base/bloc.dart';
import 'package:orim/config/strings_resource.dart';
import 'package:orim/entities/category/categories_model.dart';
import 'package:orim/model/issue/issue.dart';
import 'package:orim/navigator_service.dart';
import 'package:orim/observer/create_issue.dart';
import 'package:orim/pages/issue_detail/issue_detail_page.dart';
import 'package:orim/utils/progress_dialog_loading.dart';
import 'package:orim/viewmodel/issue.dart';
import 'package:provider/provider.dart';

class HistoryPageBloc extends BaseBloc {
  HistoryPageBloc({BuildContext context}) : super(context: context);
  IssueViewModel _issueViewModel;
  CreateIssueObserver _createIssueObServer ;
  DateTime _date;
  List<IssueModel> _modelsOrigin;

  BehaviorSubject<List<IssueModel>> _issuesSubject = BehaviorSubject();
  Stream<List<IssueModel>> get streamIssues => _issuesSubject.stream;

  BehaviorSubject<String> _dateSubject = BehaviorSubject();
  Stream<String> get streamDate => _dateSubject.stream;

  @override
  void dispose() {
    _issuesSubject.close();
    _dateSubject.close();
  }

  @override
  void updateDependencies(BuildContext context) {
    super.updateDependencies(context);
    _issueViewModel = Provider.of<IssueViewModel>(context);
    _createIssueObServer = Provider.of<CreateIssueObserver>(context);
//    this._issueViewModel.showCalendarSubject.listen((ishow) {
//      this.setToggleCalendar();
//    });
  }

  listenDataChange() {
    _createIssueObServer.listener(onDataChange: (status){
      print("reload history");
      this.getListIssues();
    },);
  }

  getListIssues() {
    _issueViewModel.getIssueIds().then((List<String> ids) async {

      ResponseListNew<IssueModel> res = await _issueViewModel.getIssueByIds(ids);
      if(res.isSuccess()){
        this._modelsOrigin = res.datas;
            _issuesSubject.value = this._modelsOrigin;
      }else{
        _issuesSubject.addError("");
      }
    });
  }

  void gotoDetail(IssueModel issueModel) {
    IssueDetailArguments arguments = IssueDetailArguments(model: issueModel, isFromHistoryPage: true);
    NavigatorService.gotoDetailIssue(context, arguments: arguments).then((res) {
      getListIssues();
    });
  }

  void setToggleCalendar(bool state) {
    if (state) {
      this.setDateSelect(getDateSelect());
    } else {
      this._issuesSubject.value = this._modelsOrigin;
    }
  }

  String getCategoryIcon (String categoryName)  {
    String icon = '';
    List<CategoriesModel> categoriesModel = this.helperViewModel.categories;
    for(CategoriesModel obj in categoriesModel) {
      if(obj.name == categoryName) {
        if(obj.icon == "" || obj.icon == null) {
          icon = "";
        } else {
          icon = obj.icon;
        }
        break;
      }
    }
    return icon;
  }

  getDateSelect() {
    return this._date == null ? new DateTime.now() : this._date;
  }

  setDateSelect(DateTime date) async {
    if (DateTime.now().isBefore(date) && !DateTime.now().isAtSameMomentAs(date)) {
      Fluttertoast.showToast(
          msg: StringResource.getText(context, 'history_date_less_than_current'));
    } else {
      _date = date;
      String startString = DateFormat('dd/MM/yyyy').format(this._date);
      String endString = DateFormat('dd/MM/yyyy').format(DateTime.now());

      _dateSubject.value = startString+ " - " + endString;
      final List<IssueModel> searchModels = await this
          ._issueViewModel
          .searchByDate(this._modelsOrigin, startString);
      _issuesSubject.value = searchModels;
    }
  }
}

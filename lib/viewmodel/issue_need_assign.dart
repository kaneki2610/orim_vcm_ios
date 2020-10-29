import 'dart:async';

import 'package:orim/base/base_reponse.dart';
import 'package:orim/base/subject.dart';
import 'package:orim/base/viewmodel.dart';
import 'package:orim/model/auth/auth.dart';
import 'package:orim/model/department/department.dart';
import 'package:orim/model/issue/issue.dart';
import 'package:orim/model/pagination/pagination_model.dart';
import 'package:orim/repositories/auth/auth_repo.dart';
import 'package:orim/repositories/department/department_repo.dart';
import 'package:orim/repositories/issue_need_assign/issue_need_assign_repo.dart';

class IssueNeedAssignViewModel extends BaseViewModel<List<IssueModel>> {

  PublishSubject<String> _searchObserver = PublishSubject();
  PublishSubject<String> _calendarObserver = PublishSubject();

  IssueNeedAssignRepo issueNeedAssignRepo;
  AuthRepo authRepo;
  DepartmentRepo departmentRepo;

  StreamSubscription<String> listenerSearch(
    {Function(String) onDataChange, Function() onDone, Function onError, bool cancelOnError = false}) {
    return _searchObserver.listen(onDataChange, onDone: onDone,
      onError: onError,
      cancelOnError: cancelOnError);
  }

  StreamSubscription<String> listenerCalendar(
    {Function(String) onDataChange, Function() onDone, Function onError, bool cancelOnError = false}) {
    return _calendarObserver.listen(onDataChange, onDone: onDone,
      onError: onError,
      cancelOnError: cancelOnError);
  }

  setDataSearch(String key) {
    this._searchObserver.value = key;
  }

  setCalendar(String key) {
    this._calendarObserver.value = key;
  }

  Future<ResponseListNew<IssueModel>> getIssuesWithStatus({List<int> listAssignStatus,
    List<int> listStatus, PaginationModel paginationModel}) async {
    AuthModel authModel = await authRepo.getAuth();
    List<DepartmentModel> departments = await departmentRepo
      .getOwnerDepartments(accountId: authModel.accountId);

    ResponseListNew<IssueModel> res =
    await issueNeedAssignRepo.getIssuesWithStatus(
      listAssignStatus: listAssignStatus,
      liststatus: listStatus,
      accountId: authModel.accountId,
      token: authModel.token,
      departmentId: departments[0].id,
      paginationModel: paginationModel);
    return res;
  }

  @override
  void dispose() {
    this._calendarObserver.close();
    this._searchObserver.close();
    super.dispose();
  }
}
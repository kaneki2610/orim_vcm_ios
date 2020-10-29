import 'package:orim/base/base_reponse.dart';
import 'package:orim/base/viewmodel.dart';
import 'package:orim/model/auth/auth.dart';
import 'package:orim/model/department/department.dart';
import 'package:orim/model/issue/issue.dart';
import 'package:orim/model/pagination/pagination_model.dart';
import 'package:orim/repositories/auth/auth_repo.dart';
import 'package:orim/repositories/department/department_repo.dart';
import 'package:orim/repositories/issue_need_assign/issue_need_assign_repo.dart';

class IssueiAdminViewModel extends BaseViewModel<List<IssueModel>> {
  IssueNeedAssignRepo issueNeedAssignRepo;
  AuthRepo authRepo;
  DepartmentRepo departmentRepo;

  Future<ResponseListNew<IssueModel>> getIssuesWithStatus({List<int> listAssignStatus,
    List<int> listStatus, List<int> listStatusReview, PaginationModel paginationModel}) async {
    AuthModel authModel = await authRepo.getAuth();
    List<DepartmentModel> departments = await departmentRepo
        .getOwnerDepartments(accountId: authModel.accountId);

    ResponseListNew<IssueModel> res =
    await issueNeedAssignRepo.getIssuesWithStatus(
        listAssignStatus: listAssignStatus,
        listStatusReview: listStatusReview,
        liststatus: listStatus,
        accountId: authModel.accountId,
        token: authModel.token,
        departmentId: departments[0].id,
        paginationModel: paginationModel);
    return res;
  }

}
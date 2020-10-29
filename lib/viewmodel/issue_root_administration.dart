
import 'package:orim/base/base_reponse.dart';
import 'package:orim/base/viewmodel.dart';
import 'package:orim/model/auth/auth.dart';
import 'package:orim/model/department/department.dart';
import 'package:orim/model/issue/issue.dart';
import 'package:orim/model/pagination/pagination_model.dart';
import 'package:orim/repositories/auth/auth_repo.dart';
import 'package:orim/repositories/department/department_repo.dart';
import 'package:orim/repositories/issue_administration/issue_administration_repo.dart';

class IssueiRootAdminViewModel extends BaseViewModel<List<IssueModel>> {
  IssueAdminRepo issueAdminRepo;
  AuthRepo authRepo;
  DepartmentRepo departmentRepo;

  Future<ResponseListNew<IssueModel>> getIssuesWithStatusRootAdmin({List<int> listStatus, String areaCodeStatic, String kindOfTime, PaginationModel paginationModel}) async {
    AuthModel authModel = await authRepo.getAuth();
    String areaCode = areaCodeStatic;
    if(areaCode == null) {
      List<DepartmentModel> departments = await departmentRepo
          .getOwnerDepartments(accountId: authModel.accountId);
      areaCode = departments[0].area.code;
    }
    ResponseListNew<IssueModel> res = await issueAdminRepo.getIssueRootAdministration(
      areaCodeStatic: areaCode,
      liststatus: listStatus,
      kindOfTime: kindOfTime,
      token: authModel.token,
      paginationModel: paginationModel
    );
    return res;
  }

}

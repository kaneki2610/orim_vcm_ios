import 'package:orim/base/base_reponse.dart';
import 'package:orim/base/viewmodel.dart';
import 'package:orim/model/auth/auth.dart';
import 'package:orim/model/department/department.dart';
import 'package:orim/repositories/auth/auth_repo.dart';
import 'package:orim/repositories/department/department_repo.dart';
import 'package:orim/repositories/issue/issue_repo.dart';

class ReportSpamViewModel extends BaseViewModel {
  IssueRepo issueRepo;
  AuthRepo authRepo;
  DepartmentRepo departmentRepo;

  Future<ResponseObject<bool>> reportSpam({String issueId}) async {
    AuthModel auth = await authRepo.getAuth();
    List<DepartmentModel> departments =
        await departmentRepo.getOwnerDepartments(accountId: auth.accountId);
    ResponseObject<bool> res = await issueRepo.reportSpam(
        token: auth.token,
        issueid: issueId,
        departmentId: departments[0].id,
        departmentName: departments[0].name,
        name: auth.fullName,
        accountId: auth.accountId);
    return res;
  }
}

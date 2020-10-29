import 'package:orim/base/base_reponse.dart';
import 'package:orim/model/auth/auth.dart';
import 'package:orim/model/department/department.dart';
import 'package:orim/repositories/auth/auth_repo.dart';
import 'package:orim/repositories/department/department_repo.dart';
import 'package:orim/repositories/issue_approve/issue_approve_repo.dart';

class SendInfoApproveViewModel {
  IssueApproveRepo issueApproveRepo;
  AuthRepo authRepo;
  DepartmentRepo departmentRepo;

  Future <ResponseObject<bool>>updateApprove({String issueId, String comment}) async {
    AuthModel auth = await authRepo.getAuth();
    List<DepartmentModel> departments =
        await departmentRepo.getOwnerDepartments(accountId: auth.accountId);
    return await issueApproveRepo.approve(
        token: auth.token,
        departmentIdAssigner: departments[0].id,
        departmentNameAssigner: departments[0].name,
        areaAssigner: departments[0].area.toJson(),
        nameAssigner: auth.fullName,
        accountIdAssigner: auth.accountId,
        issueId: issueId,
        comment: comment);
  }
}

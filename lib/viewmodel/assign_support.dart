import 'package:orim/base/base_reponse.dart';
import 'package:orim/base/viewmodel.dart';
import 'package:orim/model/auth/auth.dart';
import 'package:orim/model/department/department.dart';
import 'package:orim/model/officer.dart';
import 'package:orim/repositories/auth/auth_repo.dart';
import 'package:orim/repositories/department/department_repo.dart';
import 'package:orim/repositories/issue_need_assign/issue_need_assign_repo.dart';

class AssignSupportViewModel extends BaseViewModel {
  IssueNeedAssignRepo issueNeedAssignRepo;
  AuthRepo authRepo;
  DepartmentRepo departmentRepo;

  Future<ResponseObject<bool>> assignSupport({
    String issueId,
    String contentAssign,
    List<OfficerModel> assignee,
  }) async {
    AuthModel auth = await authRepo.getAuth();
    List<DepartmentModel> ownDepartments =
        await departmentRepo.getOwnerDepartments(accountId: auth.accountId);
    final myFirstOwnDepartment = ownDepartments[0];
    final res = await issueNeedAssignRepo.assignSupport(
      token: auth.token,
      departmentIdAssigner: myFirstOwnDepartment.id,
      departmentNameAssigner: myFirstOwnDepartment.name,
      nameAssigner: auth.fullName,
      issueId: issueId,
      areaAssigner: myFirstOwnDepartment.area?.toJson() ?? null,
      accountIdAssigner: auth.accountId,
      contentAssign: contentAssign,
      assignee: assignee,
    );
    return res;
  }
}

import 'package:orim/base/base_reponse.dart';
import 'package:orim/base/viewmodel.dart';
import 'package:orim/model/auth/auth.dart';
import 'package:orim/model/department/department.dart';
import 'package:orim/model/officer.dart';
import 'package:orim/repositories/auth/auth_repo.dart';
import 'package:orim/repositories/department/department_repo.dart';
import 'package:orim/repositories/issue_need_assign/issue_need_assign_repo.dart';

class AssignExecuteViewModel extends BaseViewModel<dynamic> {
  IssueNeedAssignRepo issueNeedAssignRepo;
  AuthRepo authRepo;
  DepartmentRepo departmentRepo;

  Future<ResponseObject<bool>> assignSpecialistExecute(
      {String issueId,
      String contentAssign,
      String supportContentAssign,
      List<OfficerModel> assignee,
      List<DepartmentModel> supporters}) async {
    AuthModel auth = await authRepo.getAuth();
    List<DepartmentModel> ownDepartments =
        await departmentRepo.getOwnerDepartments(accountId: auth.accountId);
    final myFirstOwnDepartment = ownDepartments[0];
    final res = await issueNeedAssignRepo.assignSpecialistExecute(
      token: auth.token,
      departmentIdAssigner: myFirstOwnDepartment.id,
      departmentNameAssigner: myFirstOwnDepartment.name,
      nameAssigner: auth.fullName,
      issueId: issueId,
      areaAssigner: myFirstOwnDepartment.area?.toJson() ?? null,
      accountIdAssigner: auth.accountId,
      contentAssign: contentAssign,
      supportContentAssign: supportContentAssign,
      assignee: assignee,
      supporters: supporters,
    );
    return res;
  }

  Future<ResponseObject<bool>> assignDepartmentExecute(
      {String issueId,
      String contentAssign,
      List<DepartmentModel> assignee}) async {
    AuthModel auth = await authRepo.getAuth();
    List<DepartmentModel> ownDepartments =
        await departmentRepo.getOwnerDepartments(accountId: auth.accountId);
    final myFirstOwnDepartment = ownDepartments[0];
    final res = await issueNeedAssignRepo.assignDepartmentExecute(
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

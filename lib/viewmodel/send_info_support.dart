import 'package:orim/base/base_reponse.dart';
import 'package:orim/base/viewmodel.dart';
import 'package:orim/model/auth/auth.dart';
import 'package:orim/model/department/department.dart';
import 'package:orim/repositories/auth/auth_repo.dart';
import 'package:orim/repositories/department/department_repo.dart';
import 'package:orim/repositories/issue_process/issue_process_repo.dart';

class SendInfoSupportViewModel extends BaseViewModel<dynamic> {
  AuthRepo authRepo;
  DepartmentRepo departmentRepo;
  IssueProcessRepo issueProcessRepo;

  Future<ResponseObject<bool>> sendInfoSupport({String issueId, String comment}) async {
    AuthModel auth = await authRepo.getAuth();
    List<DepartmentModel> departments =
        await departmentRepo.getOwnerDepartments(accountId: auth.accountId);
    return await issueProcessRepo.sendInfoSupport(
        token: auth.token,
        issueId: issueId,
        departmentIdAssigner: departments[0].id,
        areaAssigner: departments[0].area.toJson(),
        nameAssigner: auth.fullName,
        accountIdAssigner: auth.accountId,
        departmentNameAssigner: departments[0].name,
        comment: comment);
  }
}

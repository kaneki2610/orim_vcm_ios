import 'package:orim/base/base_reponse.dart';
import 'package:orim/base/viewmodel.dart';
import 'package:orim/model/auth/auth.dart';
import 'package:orim/model/department/department.dart';
import 'package:orim/repositories/auth/auth_repo.dart';
import 'package:orim/repositories/department/department_repo.dart';
import 'package:orim/repositories/issue_process/issue_process_repo.dart';

class SendInfoProcessViewModel extends BaseViewModel {
  IssueProcessRepo issueProcessRepo;
  AuthRepo authRepo;
  DepartmentRepo departmentRepo;

  Future<ResponseObject<bool>> sendExecute({String issueId, String comment, int categoryExeId}) async {
    AuthModel auth = await authRepo.getAuth();
    List<DepartmentModel> departments =
        await departmentRepo.getOwnerDepartments(accountId: auth.accountId);
    DepartmentModel myDepartment = departments[0];
    return await issueProcessRepo.sendInfoProcess(
      token: auth.token,
      issueId: issueId,
      comment: comment,
      categoryExeId: categoryExeId,
      departmentNameAssigner: myDepartment.name,
      departmentIdAssigner: myDepartment.id,
      assignerName: auth.fullName,
      accountIdAssigner: auth.accountId,
      areaAssigner: myDepartment.area.toJson(),
    );
  }
}

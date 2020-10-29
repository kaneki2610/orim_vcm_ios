import 'package:orim/base/base_reponse.dart';
import 'package:orim/base/viewmodel.dart';
import 'package:orim/model/auth/auth.dart';
import 'package:orim/model/department/department.dart';
import 'package:orim/repositories/auth/auth_repo.dart';
import 'package:orim/repositories/department/department_repo.dart';

class DepartmentSupportViewModel extends BaseViewModel<List<DepartmentModel>> {
  
  DepartmentRepo departmentRepo;
  AuthRepo authRepo;

  Future<ResponseListNew<DepartmentModel>> getSupports() async {
    AuthModel authModel = await authRepo.getAuth();
    ResponseListNew<DepartmentModel> res = await departmentRepo.getSupport(accountId: authModel.accountId);
    return res;
  }
}

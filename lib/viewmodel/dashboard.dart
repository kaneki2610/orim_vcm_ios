
import 'package:orim/base/base_reponse.dart';
import 'package:orim/base/viewmodel.dart';
import 'package:orim/model/auth/auth.dart';
import 'package:orim/model/dashboardarea/dashboard_area.dart';
import 'package:orim/model/dashboardarea/dashboard_object.dart';
import 'package:orim/model/department/department.dart';
import 'package:orim/repositories/auth/auth_repo.dart';
import 'package:orim/repositories/dashboard/dashboard_repo.dart';
import 'package:orim/repositories/department/department_repo.dart';

class DashBoardViewModel extends BaseViewModel<List<DashBoardAreaModel>> {

  AuthRepo authRepo;
  DashBoardRepo dashBoardRepo;
  DepartmentRepo departmentRepo;

  Future<ResponseObject<DashBoardObjectModel>> getTotalDashBoard(
      String kindOfTime) async {
    AuthModel authModel = await authRepo.getAuth();
    List<DepartmentModel> data = await departmentRepo.getOwnerDepartments(accountId: authModel.accountId);
    print("getAuth: " + authModel.token);
    ResponseObject<DashBoardObjectModel> response = await dashBoardRepo
        .getTotalDetailDashBoard(areaCodeStatic: data[0].area.code,
        kindOfTimes: kindOfTime,
        token: authModel.token);
    return response;
  }
  Future<List<DepartmentModel>> getAreaDepartmentStatic() async {
    AuthModel authModel = await authRepo.getAuth();
    List<DepartmentModel> data = await departmentRepo.getOwnerDepartments(accountId: authModel.accountId);
    return data;
  }
}
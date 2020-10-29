import 'package:flutter/cupertino.dart';
import 'package:orim/base/base_reponse.dart';
import 'package:orim/base/viewmodel.dart';
import 'package:orim/model/auth/auth.dart';
import 'package:orim/model/department/department.dart';
import 'package:orim/model/officer.dart';
import 'package:orim/repositories/auth/auth_repo.dart';
import 'package:orim/repositories/department/department_repo.dart';
import 'package:orim/repositories/officer/officer_repo.dart';

class OfficerViewModel extends BaseViewModel<List<OfficerModel>> {

  OfficerRepo officerRepo;
  AuthRepo authRepo;
  DepartmentRepo departmentRepo;

  Future<ResponseListNew<OfficerModel>> getOfficers() async {
    AuthModel authModel = await authRepo.getAuth();
    List<DepartmentModel> departments = await departmentRepo
        .getOwnerDepartments(accountId: authModel.accountId);
    ResponseListNew<OfficerModel> response = await officerRepo.getOfficer(departmentId: departments[0].id);
    if(response.isSuccess()) {
      data = response.datas;
    }
    return response;
  }
}

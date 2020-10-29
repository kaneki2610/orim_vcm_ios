import 'package:orim/base/base_reponse.dart';
import 'package:orim/model/department/department.dart';

abstract class DepartmentRepo {
  Future<ResponseListNew<DepartmentModel>> getSupport({String accountId});

  Future<ResponseListNew<DepartmentModel>> getUnits({String accountId});

  Future<bool> saveOwnerDepartments(
      {String accountId, List<DepartmentModel> list});

  Future<List<DepartmentModel>> getOwnerDepartments({String accountId});

  Future<bool> removeOwnerDepartment({String accountId});
}

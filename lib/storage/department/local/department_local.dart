import 'package:orim/model/department/department.dart';

abstract class DepartmentLocal {
  Future<bool> saveDepartments(
      {String accountId, List<DepartmentModel> departments});

  Future<List<DepartmentModel>> getOwnDepartments({ String accountId });

  Future<bool> removeDepartments({String accountId});
}

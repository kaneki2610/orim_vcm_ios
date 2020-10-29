import 'package:orim/base/base_reponse.dart';
import 'package:orim/model/department/department.dart';
import 'package:orim/repositories/department/department_repo.dart';
import 'package:orim/storage/department/local/department_local.dart';
import 'package:orim/storage/department/remote/department_remote.dart';

class DepartmentRepoImp implements DepartmentRepo {
  DepartmentRemote departmentRemote;
  DepartmentLocal departmentLocal;

  List<DepartmentModel> _ownerDepartments;

  @override
  Future<ResponseListNew<DepartmentModel>> getSupport({String accountId}) async {
    List<DepartmentModel> departments = _ownerDepartments ??
        await departmentLocal.getOwnDepartments(accountId: accountId);
    ResponseListNew<DepartmentModel> res = await departmentRemote.getSupports(departmentId: departments[0].id);
    return res;
  }

  @override
  Future<ResponseListNew<DepartmentModel>> getUnits({String accountId}) async {
    List<DepartmentModel> departments = _ownerDepartments ??
        await departmentLocal.getOwnDepartments(accountId: accountId);
    ResponseListNew<DepartmentModel> res = await departmentRemote.getUnit(departmentId: departments[0].id);
    return res;
  }

  @override
  Future<bool> saveOwnerDepartments(
      {String accountId, List<DepartmentModel> list}) async {
    _ownerDepartments = list;
      await departmentLocal.saveDepartments(
          accountId: accountId, departments: list);
    return true;
  }

  @override
  Future<List<DepartmentModel>> getOwnerDepartments({String accountId}) async {
    if (_ownerDepartments == null) {
      List<DepartmentModel> departments =
          await departmentLocal.getOwnDepartments(accountId: accountId);
      _ownerDepartments = departments;
      print("Ownerparment:"+_ownerDepartments[0].code);
    }
    return _ownerDepartments;
  }

  @override
  Future<bool> removeOwnerDepartment({String accountId}) async {
    _ownerDepartments = null;
    return await departmentLocal.removeDepartments(accountId: accountId);
  }
}

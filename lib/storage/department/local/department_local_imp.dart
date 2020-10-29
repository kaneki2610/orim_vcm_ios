import 'package:flutter/cupertino.dart';
import 'package:orim/model/department/department.dart';
import 'package:orim/storage/department/local/department_local.dart';
import 'package:orim/utils/storage/storage.dart';

class DepartmentLocalImp implements DepartmentLocal {

  Storage storage;
  final String key = 'department';

  @override
  Future<bool> saveDepartments(
      {String accountId, List<DepartmentModel> departments}) async {
    return await storage.writeList('key_$accountId', departments);
  }

  @override
  Future<List<DepartmentModel>> getOwnDepartments({String accountId}) async {
    List<DepartmentModel> list;
    try {
      List<dynamic> listDynamic = await storage.readList('key_$accountId');
      list = listDynamic.map((e) => DepartmentModel.fromJson(e)).toList();
    } catch (err) {
      throw err;
    }
    if (list != null) {
      return list;
    } else {
      throw 'getDepartments no data';
    }
  }

  @override
  Future<bool> removeDepartments({String accountId}) async {
    return await storage.delete('key_$accountId');
  }
}

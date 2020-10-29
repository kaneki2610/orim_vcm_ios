import 'package:orim/base/base_reponse.dart';
import 'package:orim/model/department/department.dart';

abstract class DepartmentRemote {
  Future<ResponseListNew<DepartmentModel>> getSupports({ String departmentId });
  Future<ResponseListNew<DepartmentModel>> getUnit({ String departmentId });
}
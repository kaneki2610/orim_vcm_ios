import 'dart:convert';

import 'package:http/http.dart';
import 'package:orim/base/base_reponse.dart';
import 'package:orim/entities/department_support/department_support_request.dart';
import 'package:orim/entities/department_support/department_support_response.dart';
import 'package:orim/entities/department_unit/department_unit_request.dart';
import 'package:orim/entities/department_unit/department_unit_response.dart';
import 'package:orim/model/department/department.dart';
import 'package:orim/storage/department/remote/department_remote.dart';
import 'package:orim/utils/api_service.dart';

class DepartmentRemoteImp implements DepartmentRemote {
  ApiService apiService;
  final String _urlGetSupport =
      'kong/api/permission/v1/department/get-department-support';
  final String _urlGetUnit =
      'kong/api/permission/v1/department/get-sub-department';

  @override
  Future<ResponseListNew<DepartmentModel>> getSupports(
      {String departmentId}) async {
    DepartmentSupportRequest request =
        DepartmentSupportRequest(departmentId: departmentId);
    Response response;
    try {
      response = await apiService
          .get('$_urlGetSupport?departmentId=${request.departmentId}');
      DepartmentSupportResponse res =
          DepartmentSupportResponse.fromJson(json.decode(response.body));
      if (response.statusCode >= 200 && response.statusCode < 300) {
        res.code = 1;
      }
      return res;
    } catch (err) {
      return ResponseListNew.initDefault();
    }
  }

  @override
  Future<ResponseListNew<DepartmentModel>> getUnit(
      {String departmentId}) async {
    DepartmentUnitRequest request =
        DepartmentUnitRequest(departmentId: departmentId);
    Response response;
    try {
      response = await apiService
          .get('$_urlGetUnit?departmentId=${request.departmentId}');
      DepartmentUnitResponse res =
          DepartmentUnitResponse.fromJson(json.decode(response.body));
      if (response.statusCode >= 200 && response.statusCode < 300) {
        res.code = 1;
      }
      return res;
    } catch (err) {
      return ResponseListNew.initDefault();
    }
  }
}

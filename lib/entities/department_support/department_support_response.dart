import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:orim/base/base_reponse.dart';
import 'package:orim/entities/object/department_support/department_support.dart';
import 'package:orim/model/department/department.dart';

part 'department_support_response.g.dart';

@JsonSerializable(nullable: true)
class DepartmentSupportResponse extends ResponseListNew<DepartmentModel> {
  DepartmentSupportResponse({String msg, int code, dynamic data})
      : super(code: code, msg: msg) {
    if (data is List) {
      final List<DepartmentSupport> departmentSupport =
          data.map((item) => DepartmentSupport.fromJson(item)).toList();
      this.datas = departmentSupport
          .map((item) => DepartmentModel.fromDepartmentSupport(item))
          .toList();
    } else if (data is Map<String, dynamic>) {
      Map<String, dynamic> map = data;
      this.datas = [];
      if (map["errors"] is List) {
        List<dynamic> errors = map["errors"] as List;
        this.msg = errors.first ?? "Error";
      }
    }
  }

  factory DepartmentSupportResponse.fromJson(dynamic json) =>
      _$DepartmentSupportResponseFromJson(json);
}

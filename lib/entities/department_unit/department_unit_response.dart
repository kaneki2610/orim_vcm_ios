import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:orim/base/base_reponse.dart';
import 'package:orim/entities/object/department_support/department_support.dart';
import 'package:orim/entities/object/department_unit/department_unit.dart';
import 'package:orim/model/department/department.dart';

part 'department_unit_response.g.dart';

@JsonSerializable(nullable: true)
class DepartmentUnitResponse extends ResponseListNew<DepartmentModel> {
  DepartmentUnitResponse({String msg, int code, dynamic data})
      : super(code: code, msg: msg) {
    if (data is List) {
      final List<DepartmentUnit> departmentUnit =
          data.map((item) => DepartmentUnit.fromJson(item)).toList();
      this.datas = departmentUnit
          .map((item) => DepartmentModel.fromDepartmentUnit(item))
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

  factory DepartmentUnitResponse.fromJson(dynamic json) =>
      _$DepartmentUnitResponseFromJson(json);
}

import 'package:json_annotation/json_annotation.dart';
import 'package:orim/entities/object/area/area.dart';
import 'package:orim/entities/object/department_support/department_support.dart';
import 'package:orim/entities/object/department_unit/department_unit.dart';

part 'department.g.dart';

@JsonSerializable(nullable: true)
class DepartmentModel {
  String code;
  String name;
  String id;
  Area area;

  DepartmentModel({this.code, this.name, this.id, this.area});

  factory DepartmentModel.fromJson(Map<String, dynamic> json) => _$DepartmentModelFromJson(json);
  Map<String, dynamic> toJson() => _$DepartmentModelToJson(this);

  static DepartmentModel fromDepartmentSupport(DepartmentSupport item) {
    return DepartmentModel(code: item.code, name: item.name, id: item.id, area: item.area);
  }
  
  static DepartmentModel fromDepartmentUnit(DepartmentUnit item) {
    return DepartmentModel(code: item.code, name: item.name, id: item.id, area: item.area);
  }
}

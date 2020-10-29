import 'package:json_annotation/json_annotation.dart';
import 'package:orim/entities/object/area/area.dart';

part 'department_unit.g.dart';

@JsonSerializable(nullable: true)
class DepartmentUnit {
  String code;
  String name;
  String parentId;
  Area area;
  String partition;
  String type;
  String id;

  DepartmentUnit(
    {this.code,
      this.name,
      this.parentId,
      this.area,
      this.partition,
      this.type,
      this.id});

  factory DepartmentUnit.fromJson(Map<String, dynamic> json) =>
    _$DepartmentUnitFromJson(json);

  Map<String, dynamic> toJson() => _$DepartmentUnitToJson(this);
}

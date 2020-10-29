import 'package:json_annotation/json_annotation.dart';
import 'package:orim/entities/object/area/area.dart';

part 'department_support.g.dart';

@JsonSerializable(nullable: true)
class DepartmentSupport {
  String code;
  String name;
  String parentId;
  Area area;
  String partition;
  String type;
  String id;

  DepartmentSupport(
      {this.code,
      this.name,
      this.parentId,
      this.area,
      this.partition,
      this.type,
      this.id});

  factory DepartmentSupport.fromJson(Map<String, dynamic> json) =>
      _$DepartmentSupportFromJson(json);

  Map<String, dynamic> toJson() => _$DepartmentSupportToJson(this);
}

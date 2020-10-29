import 'package:json_annotation/json_annotation.dart';
import 'package:orim/entities/object/organization/organization.dart';

part 'department.g.dart';

@JsonSerializable(nullable: true)
class Department {
  dynamic area;
  String code;
  String description;
  String id;
  String name;
  Organization organization;
  Department parent;
  String parentId;
  int status;
  dynamic type;

  Department(
      {this.area,
      this.code,
      this.description,
      this.id,
      this.name,
      this.organization,
      this.parent,
      this.parentId,
      this.status,
      this.type});

  factory Department.fromJson(Map<String, dynamic> json) =>
      _$DepartmentFromJson(json);

  Map<String, dynamic> toJson() => _$DepartmentToJson(this);
}

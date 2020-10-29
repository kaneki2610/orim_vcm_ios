import 'package:json_annotation/json_annotation.dart';
import 'package:orim/entities/object/department/department.dart';

part 'officer_entity.g.dart';

@JsonSerializable(nullable: true)
class OfficerEntity {
  String fullname;
  List<Department> departments;
  String id;

  OfficerEntity(this.fullname, this.departments, this.id);

  factory OfficerEntity.fromJson(Map<String, dynamic> json) => _$OfficerEntityFromJson(json);
  Map<String, dynamic> toJson() => _$OfficerEntityToJson(this);

  bool isNotHaveDepartment() => departments != null && departments.length > 0;
}
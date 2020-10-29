import 'package:json_annotation/json_annotation.dart';

part 'department_unit_request.g.dart';

@JsonSerializable(nullable: true)
class DepartmentUnitRequest {
  String departmentId;

  DepartmentUnitRequest({this.departmentId});

  factory DepartmentUnitRequest.fromJson(Map<String, dynamic> json) =>
      _$DepartmentUnitRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DepartmentUnitRequestToJson(this);
}

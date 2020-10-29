import 'package:json_annotation/json_annotation.dart';

part 'department_support_request.g.dart';

@JsonSerializable(nullable: true)
class DepartmentSupportRequest {
  String departmentId;

  DepartmentSupportRequest({this.departmentId});

  factory DepartmentSupportRequest.fromJson(Map<String, dynamic> json) =>
      _$DepartmentSupportRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DepartmentSupportRequestToJson(this);
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assign_execute_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SupportAssignee _$SupportAssigneeFromJson(Map<String, dynamic> json) {
  return SupportAssignee(
    Id: json['Id'] as String,
    ObjectType: json['ObjectType'] as String,
    Area: json['Area'] as Map<String, dynamic>,
    Name: json['Name'] as String,
  );
}

Map<String, dynamic> _$SupportAssigneeToJson(SupportAssignee instance) =>
    <String, dynamic>{
      'Id': instance.Id,
      'ObjectType': instance.ObjectType,
      'Area': instance.Area,
      'Name': instance.Name,
    };

AssigneeOfficer _$AssigneeOfficerFromJson(Map<String, dynamic> json) {
  return AssigneeOfficer(
    Id: json['Id'] as String,
    Name: json['Name'] as String,
    departmentName: json['departmentName'] as String,
  )..ObjectType = json['ObjectType'] as String;
}

Map<String, dynamic> _$AssigneeOfficerToJson(AssigneeOfficer instance) =>
    <String, dynamic>{
      'Id': instance.Id,
      'Name': instance.Name,
      'ObjectType': instance.ObjectType,
      'departmentName': instance.departmentName,
    };

AssigneeDepartment _$AssigneeDepartmentFromJson(Map<String, dynamic> json) {
  return AssigneeDepartment(
    Id: json['Id'] as String,
    Name: json['Name'] as String,
    Area: json['Area'] as Map<String, dynamic>,
  )..ObjectType = json['ObjectType'] as String;
}

Map<String, dynamic> _$AssigneeDepartmentToJson(AssigneeDepartment instance) =>
    <String, dynamic>{
      'Id': instance.Id,
      'Name': instance.Name,
      'ObjectType': instance.ObjectType,
      'Area': instance.Area,
    };

Assigner _$AssignerFromJson(Map<String, dynamic> json) {
  return Assigner(
    departmentName: json['departmentName'] as String,
    Name: json['Name'] as String,
    Area: json['Area'] as Map<String, dynamic>,
    Id: json['Id'] as String,
    DepartmentId: json['DepartmentId'] as String,
  )..ObjectType = json['ObjectType'] as String;
}

Map<String, dynamic> _$AssignerToJson(Assigner instance) => <String, dynamic>{
      'departmentName': instance.departmentName,
      'Name': instance.Name,
      'Area': instance.Area,
      'Id': instance.Id,
      'DepartmentId': instance.DepartmentId,
      'ObjectType': instance.ObjectType,
    };

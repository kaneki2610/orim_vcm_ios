// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'department.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Department _$DepartmentFromJson(Map<String, dynamic> json) {
  return Department(
    area: json['area'],
    code: json['code'] as String,
    description: json['description'] as String,
    id: json['id'] as String,
    name: json['name'] as String,
    organization: json['organization'] == null
        ? null
        : Organization.fromJson(json['organization'] as Map<String, dynamic>),
    parent: json['parent'] == null
        ? null
        : Department.fromJson(json['parent'] as Map<String, dynamic>),
    parentId: json['parentId'] as String,
    status: json['status'] as int,
    type: json['type'],
  );
}

Map<String, dynamic> _$DepartmentToJson(Department instance) =>
    <String, dynamic>{
      'area': instance.area,
      'code': instance.code,
      'description': instance.description,
      'id': instance.id,
      'name': instance.name,
      'organization': instance.organization,
      'parent': instance.parent,
      'parentId': instance.parentId,
      'status': instance.status,
      'type': instance.type,
    };

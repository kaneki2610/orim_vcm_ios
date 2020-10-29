// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'department_unit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DepartmentUnit _$DepartmentUnitFromJson(Map<String, dynamic> json) {
  return DepartmentUnit(
    code: json['code'] as String,
    name: json['name'] as String,
    parentId: json['parentId'] as String,
    area: json['area'] == null
        ? null
        : Area.fromJson(json['area'] as Map<String, dynamic>),
    partition: json['partition'] as String,
    type: json['type'] as String,
    id: json['id'] as String,
  );
}

Map<String, dynamic> _$DepartmentUnitToJson(DepartmentUnit instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'parentId': instance.parentId,
      'area': instance.area,
      'partition': instance.partition,
      'type': instance.type,
      'id': instance.id,
    };

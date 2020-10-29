// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assign.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Assign _$AssignFromJson(Map<String, dynamic> json) {
  return Assign(
    id: json['id'] as String,
    name: json['name'] as String,
    code: json['code'] as String,
    phoneNumber: json['phoneNumber'] as String,
    email: json['email'] as String,
    source: json['source'],
    departmentId: json['departmentId'] as String,
    parentid: json['parentid'] as String,
    departmentName: json['departmentName'] as String,
    area: json['area'] == null
        ? null
        : Area.fromJson(json['area'] as Map<String, dynamic>),
    objectType: json['objectType'] as String,
  );
}

Map<String, dynamic> _$AssignToJson(Assign instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'phoneNumber': instance.phoneNumber,
      'email': instance.email,
      'source': instance.source,
      'departmentId': instance.departmentId,
      'parentid': instance.parentid,
      'departmentName': instance.departmentName,
      'area': instance.area,
      'objectType': instance.objectType,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organization.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Organization _$OrganizationFromJson(Map<String, dynamic> json) {
  return Organization(
    address: json['address'] as String,
    code: json['code'] as String,
    createdBy: json['createdBy'] as String,
    createdOn: json['createdOn'] as String,
    description: json['description'],
    groupTemplateId: json['groupTemplateId'] as String,
    id: json['id'] as String,
    name: json['name'] as String,
    parentId: json['parentId'] as String,
    partition: json['partition'] as String,
    status: json['status'] as int,
    type: json['type'] as String,
    typeGroupTemplateId: json['typeGroupTemplateId'] as int,
    updatedOn: json['updatedOn'] as String,
  );
}

Map<String, dynamic> _$OrganizationToJson(Organization instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'description': instance.description,
      'address': instance.address,
      'status': instance.status,
      'parentId': instance.parentId,
      'groupTemplateId': instance.groupTemplateId,
      'typeGroupTemplateId': instance.typeGroupTemplateId,
      'partition': instance.partition,
      'type': instance.type,
      'id': instance.id,
      'createdOn': instance.createdOn,
      'updatedOn': instance.updatedOn,
      'createdBy': instance.createdBy,
    };

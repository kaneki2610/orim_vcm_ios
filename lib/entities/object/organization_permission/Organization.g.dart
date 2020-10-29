// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Organization.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrganizationPermission _$OrganizationPermissionFromJson(Map<String, dynamic> json) {
  return OrganizationPermission()
    ..code = json['code'] as String
    ..name = json['name'] as String
    ..description = json['description'] as String
    ..address = json['address'] as String
    ..status = json['status'] as num
    ..parentId = json['parentId'] as String
    ..groupTemplateId = json['groupTemplateId'] as String
    ..typeGroupTemplateId = json['typeGroupTemplateId'] as num
    ..area = json['area'] == null
        ? null
        : Area.fromJson(json['area'] as Map<String, dynamic>)
    ..partition = json['partition'] as String
    ..type = json['type'] as String
    ..id = json['id'] as String
    ..createdOn = json['createdOn'] as String
    ..createdBy = json['createdBy'] as String;
}

Map<String, dynamic> _$OrganizationPermissionToJson(OrganizationPermission instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'description': instance.description,
      'address': instance.address,
      'status': instance.status,
      'parentId': instance.parentId,
      'groupTemplateId': instance.groupTemplateId,
      'typeGroupTemplateId': instance.typeGroupTemplateId,
      'area': instance.area.toJson(),
      'partition': instance.partition,
      'type': instance.type,
      'id': instance.id,
      'createdOn': instance.createdOn,
      'createdBy': instance.createdBy
    };
Area _$AreaFromJson(Map<String, dynamic> json) {
  return Area()
    ..id = json['id'] as String
    ..code = json['code'] as String
    ..name = json['name'] as String
    ..status = json['status'] as num
    ..search = json['search'] as String
    ..parentCode = json['parentCode'] as String
    ..type = json['type'] as String;
}

Map<String, dynamic> _$AreaToJson(Area instance) => <String, dynamic>{
  'id': instance.id,
  'code': instance.code,
  'name': instance.name,
  'status': instance.status,
  'search': instance.search,
  'parentCode': instance.parentCode,
  'type': instance.type
};

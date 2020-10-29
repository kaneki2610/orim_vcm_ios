// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'area.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Area _$AreaFromJson(Map<String, dynamic> json) {
  return Area(
    id: json['id'] as String,
    code: json['code'] as String,
    parentCode: json['parentCode'] as String,
    type: json['type'] as String,
    name: json['name'] as String,
    status: json['status'] as int,
    search: json['search'] as String,
  );
}

Map<String, dynamic> _$AreaToJson(Area instance) => <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'parentCode': instance.parentCode,
      'type': instance.type,
      'name': instance.name,
      'status': instance.status,
      'search': instance.search,
    };

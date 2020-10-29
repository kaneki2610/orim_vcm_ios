// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ward_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WardResponse _$WardResponseFromJson(Map<String, dynamic> json) {
  return WardResponse(
    msg: json['msg'] as String,
    error: json['error'] as int,
    list: (json['list'] as List)
        .map((e) => WardEntity.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$WardResponseToJson(WardResponse instance) =>
    <String, dynamic>{
      'msg': instance.msg,
      'error': instance.error,
      'list': instance.list,
    };

WardEntity _$WardEntityFromJson(Map<String, dynamic> json) {
  return WardEntity(
    id: json['id'] as String,
    code: json['code'] as String,
    name: json['name'] as String,
    status: json['status'] as int,
    search: json['search'] as String,
    fts_key: json['fts_key'] as String,
    areaCode: json['areaCode'] as String,
    parentCode: json['parentCode'] as String,
    type: json['type'] as String,
  );
}

Map<String, dynamic> _$WardEntityToJson(WardEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
      'status': instance.status,
      'search': instance.search,
      'fts_key': instance.fts_key,
      'areaCode': instance.areaCode,
      'parentCode': instance.parentCode,
      'type': instance.type,
    };

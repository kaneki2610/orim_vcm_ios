// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'province_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProvinceResponse _$ProvinceResponseFromJson(Map<String, dynamic> json) {
  return ProvinceResponse(
    msg: json['msg'] as String,
    error: json['error'] as int,
    list: (json['list'] as List)
        ?.map((e) => e == null
            ? null
            : ProvinceEntity.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ProvinceResponseToJson(ProvinceResponse instance) =>
    <String, dynamic>{
      'msg': instance.msg,
      'error': instance.error,
      'list': instance.list,
    };

ProvinceEntity _$ProvinceEntityFromJson(Map<String, dynamic> json) {
  return ProvinceEntity(
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

Map<String, dynamic> _$ProvinceEntityToJson(ProvinceEntity instance) =>
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

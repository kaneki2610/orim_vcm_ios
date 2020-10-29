// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'area_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AreaModel _$AreaModelFromJson(Map<String, dynamic> json) {
  return AreaModel(
    msg: json['msg'] as String,
    error: json['error'] as int,
    currentProvince: json['currentProvince'] == null
        ? null
        : CurrentProvince.fromJson(
            json['currentProvince'] as Map<String, dynamic>),
    currentDistrict: json['currentDistrict'] == null
        ? null
        : CurrentDistrict.fromJson(
            json['currentDistrict'] as Map<String, dynamic>),
    currentWard: json['currentWard'] == null
        ? null
        : CurrentWard.fromJson(json['currentWard'] as Map<String, dynamic>),
    districtList: (json['districtList'] as List)
        ?.map((e) =>
            e == null ? null : DistrictList.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$AreaModelToJson(AreaModel instance) =>
    <String, dynamic>{
      'msg': instance.msg,
      'error': instance.error,
      'currentProvince': instance.currentProvince,
      'currentDistrict': instance.currentDistrict,
      'currentWard': instance.currentWard,
      'districtList': instance.districtList,
    };

CurrentProvince _$CurrentProvinceFromJson(Map<String, dynamic> json) {
  return CurrentProvince(
    id: json['id'] as String,
    code: json['code'] as String,
    name: json['name'] as String,
    areaCode: json['areaCode'] as String,
    parentCode: json['parentCode'] as String,
    type: json['type'] as String,
  );
}

Map<String, dynamic> _$CurrentProvinceToJson(CurrentProvince instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
      'areaCode': instance.areaCode,
      'parentCode': instance.parentCode,
      'type': instance.type,
    };

CurrentDistrict _$CurrentDistrictFromJson(Map<String, dynamic> json) {
  return CurrentDistrict(
    id: json['id'] as String,
    code: json['code'] as String,
    name: json['name'] as String,
    areaCode: json['areaCode'] as String,
    parentCode: json['parentCode'] as String,
    type: json['type'] as String,
  );
}

Map<String, dynamic> _$CurrentDistrictToJson(CurrentDistrict instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
      'areaCode': instance.areaCode,
      'parentCode': instance.parentCode,
      'type': instance.type,
    };

CurrentWard _$CurrentWardFromJson(Map<String, dynamic> json) {
  return CurrentWard(
    id: json['id'] as String,
    code: json['code'] as String,
    name: json['name'] as String,
    areaCode: json['areaCode'] as String,
    parentCode: json['parentCode'] as String,
    type: json['type'] as String,
  );
}

Map<String, dynamic> _$CurrentWardToJson(CurrentWard instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
      'areaCode': instance.areaCode,
      'parentCode': instance.parentCode,
      'type': instance.type,
    };

DistrictList _$DistrictListFromJson(Map<String, dynamic> json) {
  return DistrictList(
    id: json['id'] as String,
    code: json['code'] as String,
    name: json['name'] as String,
    areaCode: json['areaCode'] as String,
    parentCode: json['parentCode'] as String,
    type: json['type'] as String,
    wardList: (json['wardList'] as List)
        ?.map((e) =>
            e == null ? null : CurrentWard.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$DistrictListToJson(DistrictList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
      'areaCode': instance.areaCode,
      'parentCode': instance.parentCode,
      'type': instance.type,
      'wardList': instance.wardList,
    };

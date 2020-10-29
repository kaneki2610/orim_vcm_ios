// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'area_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AreaRequest _$AreaRequestFromJson(Map<String, dynamic> json) {
  return AreaRequest(
    latlng: json['latlng'] as String,
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$AreaRequestToJson(AreaRequest instance) =>
    <String, dynamic>{
      'latlng': instance.latlng,
      'name': instance.name,
    };

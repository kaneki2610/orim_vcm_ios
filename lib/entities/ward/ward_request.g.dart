// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ward_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WardRequest _$WardRequestFromJson(Map<String, dynamic> json) {
  return WardRequest(
    type: json['type'] as String,
    parentcode: json['parentcode'] as int,
  );
}

Map<String, dynamic> _$WardRequestToJson(WardRequest instance) =>
    <String, dynamic>{
      'type': instance.type,
      'parentcode': instance.parentcode,
    };

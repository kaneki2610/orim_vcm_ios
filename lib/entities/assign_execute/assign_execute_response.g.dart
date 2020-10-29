// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assign_execute_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssignResponse _$AssignResponseFromJson(Map<String, dynamic> json) {
  return AssignResponse(
    code: json['code'] as int,
    msg: json['msg'] as String,
    msgToken: json['msgToken'] as String,
  );
}

Map<String, dynamic> _$AssignResponseToJson(AssignResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'data': instance.data,
      'msgToken': instance.msgToken,
    };

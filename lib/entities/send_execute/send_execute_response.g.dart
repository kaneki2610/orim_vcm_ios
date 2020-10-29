// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_execute_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendExecuteResponse _$SendExecuteResponseFromJson(Map<String, dynamic> json) {
  return SendExecuteResponse(
    code: json['code'] as int,
    msg: json['msg'] as String,
    msgToken: json['msgToken'] as String,
  );
}

Map<String, dynamic> _$SendExecuteResponseToJson(
        SendExecuteResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'data': instance.data,
      'msgToken': instance.msgToken,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_approved_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendApprovedResponse _$SendApprovedResponseFromJson(Map<String, dynamic> json) {
  return SendApprovedResponse(
    code: json['code'] as int,
    msg: json['msg'] as String,
    data: true,
    msgToken: json['msgToken'] as String,
  );
}

Map<String, dynamic> _$SendApprovedResponseToJson(
        SendApprovedResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'data': instance.data,
      'msgToken': instance.msgToken,
    };

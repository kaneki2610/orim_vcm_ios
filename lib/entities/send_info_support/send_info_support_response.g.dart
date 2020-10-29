// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_info_support_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendInfoSupportResponse _$SendInfoSupportResponseFromJson(
    Map<String, dynamic> json) {
  return SendInfoSupportResponse(
    code: json['code'] as int,
    msg: json['msg'] as String,
    msgToken: json['msgToken'] as String,
  );
}

Map<String, dynamic> _$SendInfoSupportResponseToJson(
        SendInfoSupportResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'data': instance.data,
      'msgToken': instance.msgToken,
    };

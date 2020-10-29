// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_spam_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportSpamResponse _$ReportSpamResponseFromJson(Map<String, dynamic> json) {
  return ReportSpamResponse(
    code: json['code'] as int,
    msg: json['msg'] as String,
    msgToken: json['msgToken'] as String,
  );
}

Map<String, dynamic> _$ReportSpamResponseToJson(ReportSpamResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'data': instance.data,
      'msgToken': instance.msgToken,
    };

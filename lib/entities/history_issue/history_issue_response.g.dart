// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_issue_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryIssueResponse _$HistoryIssueResponseFromJson(Map<String, dynamic> json) {
  return HistoryIssueResponse(
    code: json['code'] as int,
    msg: json['msg'] as String,
    data: (json['data'] as List)
        ?.map(
            (e) => e == null ? null : Issue.fromJson(e as Map<String, dynamic>))
        ?.toList() ?? [],
    msgToken: json['msgToken'] as String,
  );
}

//Map<String, dynamic> _$HistoryIssueResponseToJson(
//        HistoryIssueResponse instance) =>
//    <String, dynamic>{
//      'code': instance.code,
//      'msg': instance.msg,
//      'data': instance.data,
//      'msgToken': instance.msgToken,
//    };

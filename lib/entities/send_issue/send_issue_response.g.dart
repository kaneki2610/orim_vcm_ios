// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_issue_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendIssueResponse _$SendIssueResponseFromJson(Map<String, dynamic> json) {
  return SendIssueResponse(
    code: json['code'] as int,
    msg: json['msg'] as String,
    data: json['data'] == null
        ? ""
        : (SendIssueDataResponse.fromJson(json['data'] as Map<String, dynamic>).id ?? ""),
    msgToken: json['msgToken'] as String,
  );
}

Map<String, dynamic> _$SendIssueResponseToJson(SendIssueResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'data': instance.data,
      'msgToken': instance.msgToken,
    };

SendIssueDataResponse _$SendIssueDataResponseFromJson(
    Map<String, dynamic> json) {
  return SendIssueDataResponse(
    id: json['id'] as String,
    status: json['status'] as int,
  );
}

Map<String, dynamic> _$SendIssueDataResponseToJson(
        SendIssueDataResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
    };

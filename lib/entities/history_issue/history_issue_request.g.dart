// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_issue_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryIssueRequest _$HistoryIssueRequestFromJson(Map<String, dynamic> json) {
  return HistoryIssueRequest(
    listid: (json['listid'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$HistoryIssueRequestToJson(
        HistoryIssueRequest instance) =>
    <String, dynamic>{
      'listid': instance.listid,
    };

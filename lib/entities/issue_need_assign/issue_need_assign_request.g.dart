// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'issue_need_assign_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IssueNeedAssignRequest _$IssueNeedAssignRequestFromJson(
    Map<String, dynamic> json) {
  return IssueNeedAssignRequest(
    listAssignStatus:
        (json['listAssignStatus'] as List)?.map((e) => e as int)?.toList(),
    assignee: (json['assignee'] as List)?.map((e) => e as String)?.toList(),
    liststatus: (json['liststatus'] as List)?.map((e) => e as int)?.toList(),
    listStatusReview: (json['listStatusReview'] as List)?.map((e) => e as int)?.toList(),
    take: json['take'] as int,
    skip: json['skip'] as int,
  );
}

Map<String, dynamic> _$IssueNeedAssignRequestToJson(
        IssueNeedAssignRequest instance) =>
    <String, dynamic>{
      'listAssignStatus': instance.listAssignStatus,
      'assignee': instance.assignee,
      'liststatus': instance.liststatus,
      'take': instance.take,
      'skip': instance.skip,
      'listStatusReview' : instance.listStatusReview
    };

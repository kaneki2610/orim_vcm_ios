// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'issues_area_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IssuesAreaRequest _$IssuesAreaRequestFromJson(Map<String, dynamic> json) {
  return IssuesAreaRequest(
    q: json['q'] as String,
    listStatus: json['listStatus'] as String,
    areaCode: json['areaCode'] as String,
  );
}

Map<String, dynamic> _$IssuesAreaRequestToJson(IssuesAreaRequest instance) =>
    <String, dynamic>{
      'q': instance.q,
      'pagination': instance.pagination,
      'listStatus': instance.listStatus,
      'areaCode': instance.areaCode,
    };

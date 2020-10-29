// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'issue_administration_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IssueAdministrationRequest _$IssueAdministrationRequestFromJson(
    Map<String, dynamic> json) {
  return IssueAdministrationRequest(
    liststatus: (json['liststatus'] as List)?.map((e) => e as int)?.toList(),
    areaCodeStatic: json['areaCodeStatic'] as String,
    kindOfTime: json['kindOfTime'] as String,
    take: json['take'] as int,
    skip: json['skip'] as int,
  );
}

Map<String, dynamic> _$IssueAdministrationRequestToJson(
        IssueAdministrationRequest instance) =>
    <String, dynamic>{
      'areaCodeStatic': instance.areaCodeStatic,
      'liststatus': instance.liststatus,
      'kindOfTime' : instance.kindOfTime,
      'take': instance.take,
      'skip': instance.skip,
    };

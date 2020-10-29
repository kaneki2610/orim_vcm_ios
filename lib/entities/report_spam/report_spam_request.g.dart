// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_spam_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportSpamRequest _$ReportSpamRequestFromJson(Map<String, dynamic> json) {
  return ReportSpamRequest(
    issueid: json['issueid'] as String,
    comment: json['comment'] as String,
    status: json['status'] as int,
  )..assigner = json['assigner'] == null
      ? null
      : Assigner.fromJson(json['assigner'] as Map<String, dynamic>);
}

Map<String, dynamic> _$ReportSpamRequestToJson(ReportSpamRequest instance) =>
    <String, dynamic>{
      'issueid': instance.issueid,
      'assigner': instance.assigner,
      'comment': instance.comment,
      'status': instance.status,
    };

Assigner _$AssignerFromJson(Map<String, dynamic> json) {
  return Assigner(
    departmentName: json['departmentName'] as String,
    Name: json['Name'] as String,
    Id: json['Id'] as String,
    ObjectType: json['ObjectType'] as String,
    DepartmentId: json['DepartmentId'] as String,
  );
}

Map<String, dynamic> _$AssignerToJson(Assigner instance) => <String, dynamic>{
      'departmentName': instance.departmentName,
      'Name': instance.Name,
      'Id': instance.Id,
      'ObjectType': instance.ObjectType,
      'DepartmentId': instance.DepartmentId,
    };

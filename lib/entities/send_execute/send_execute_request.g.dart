// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_execute_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendExecuteRequest _$SendExecuteRequestFromJson(Map<String, dynamic> json) {
  return SendExecuteRequest(
    comment: json['comment'] as String,
  )
    ..issueid = json['issueid'] as String
    ..status = json['status'] as int
    ..assigner = json['assigner'] == null
        ? null
        : Assigner.fromJson(json['assigner'] as Map<String, dynamic>);
}

Map<String, dynamic> _$SendExecuteRequestToJson(SendExecuteRequest instance) =>
    <String, dynamic>{
      'issueid': instance.issueid,
      'status': instance.status,
      'assigner': instance.assigner,
      'comment': instance.comment,
    };

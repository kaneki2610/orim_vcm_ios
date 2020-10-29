// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_approved_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendApprovedRequest _$SendApprovedRequestFromJson(Map<String, dynamic> json) {
  return SendApprovedRequest(
    comment: json['comment'] as String,
  )
    ..issueid = json['issueid'] as String
    ..assigner = json['assigner'] == null
        ? null
        : Assigner.fromJson(json['assigner'] as Map<String, dynamic>);
}

Map<String, dynamic> _$SendApprovedRequestToJson(
        SendApprovedRequest instance) =>
    <String, dynamic>{
      'issueid': instance.issueid,
      'assigner': instance.assigner,
      'comment': instance.comment,
    };

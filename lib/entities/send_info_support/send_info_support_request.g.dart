// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_info_support_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendInfoSupportRequest _$SendInfoSupportRequestFromJson(
    Map<String, dynamic> json) {
  return SendInfoSupportRequest(
    comment: json['comment'] as String,
  )
    ..issueid = json['issueid'] as String
    ..assigner = json['assigner'] == null
        ? null
        : Assigner.fromJson(json['assigner'] as Map<String, dynamic>);
}

Map<String, dynamic> _$SendInfoSupportRequestToJson(
        SendInfoSupportRequest instance) =>
    <String, dynamic>{
      'issueid': instance.issueid,
      'assigner': instance.assigner,
      'comment': instance.comment,
    };

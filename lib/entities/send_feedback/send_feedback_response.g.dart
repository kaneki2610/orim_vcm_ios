// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_feedback_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendFeedbackResponse _$SendFeedbackResponseFromJson(Map<String, dynamic> json) {
  return SendFeedbackResponse(
    code: json['code'] as int,
    msg: json['msg'] as String,
    data: json['data'] == null
        ? null
        : Data.fromJson(json['data'] as Map<String, dynamic>),
    msgToken: json['msgToken'] as String,
  );
}

Map<String, dynamic> _$SendFeedbackResponseToJson(
        SendFeedbackResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'data': instance.data,
      'msgToken': instance.msgToken,
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    id: json['id'] as String,
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'id': instance.id,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'marker_real_time_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MarkerRealTimeResponse _$MarkerRealTimeReponseFromJson(
    Map<String, dynamic> json) {

  return MarkerRealTimeResponse(
      code: (json['code'] ?? json["status"] ) as int,
      msg: json['msg'] as String,
      data: json['data'],
      msgToken: json['msgToken'] as String);
}

/*Map<String, dynamic> _$MarkerRealTimeReponseToJson(
        MarkerRealTimeResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'data': instance.data,
      'msgToken': instance.msgToken
    };*/

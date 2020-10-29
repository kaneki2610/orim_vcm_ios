// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'information_channel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InformationChannel _$InformationChannelFromJson(Map<String, dynamic> json) {
  return InformationChannel(
    uid: json['uid'] as String,
    callerid: json['callerid'] as String,
    agent: json['agent'] as String,
    smsid: json['smsid'] as String,
    phone: json['phone'] as String,
    message: json['message'] as String,
    username: json['username'] as String,
    msgid: json['msgid'] as String,
    fromdate: json['fromdate'] as String,
    todate: json['todate'] as String,
    deviceid: json['deviceid'] as String,
    typedeviceid: json['typedeviceid'] as String,
  );
}

Map<String, dynamic> _$InformationChannelToJson(InformationChannel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'callerid': instance.callerid,
      'agent': instance.agent,
      'smsid': instance.smsid,
      'msgid': instance.msgid,
      'phone': instance.phone,
      'message': instance.message,
      'username': instance.username,
      'fromdate': instance.fromdate,
      'todate': instance.todate,
      'deviceid': instance.deviceid,
      'typedeviceid': instance.typedeviceid,
    };

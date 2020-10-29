// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'marker_real_time_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MarkerRealTimeRequest _$MarkerRealTimeRequestFromJson(
    Map<String, dynamic> json) {
  return MarkerRealTimeRequest(
      areaCode: json['areaCode'] as String,
      fromDate: json['fromDate'] as String,
      toDate: json['toDate'] as String);
}

Map<String, dynamic> _$MarkerRealTimeRequestToJson(
        MarkerRealTimeRequest instance) =>
    <String, dynamic>{
      'areaCode': instance.areaCode,
      'fromDate': instance.fromDate,
      'toDate': instance.toDate
    };

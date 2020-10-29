// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logout_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LogoutResponse _$LogoutResponseFromJson(Map<String, dynamic> json) {
  return LogoutResponse(
    errors: json['errors'] as List,
    succeed: json['succeed'] as bool,
    failed: json['failed'] as bool,
    data: json['data'],
    functionName: json['functionName'] as String,
  );
}

Map<String, dynamic> _$LogoutResponseToJson(LogoutResponse instance) =>
    <String, dynamic>{
      'errors': instance.errors,
      'succeed': instance.succeed,
      'failed': instance.failed,
      'data': instance.data,
      'functionName': instance.functionName,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'permission_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PermissionRequest _$PermissionRequestFromJson(Map<String, dynamic> json) {
  return PermissionRequest(
    source: json['source'] as String,
    token: json['token'] as String,
    accountId: json['accountId'] as String,
  );
}

Map<String, dynamic> _$PermissionRequestToJson(PermissionRequest instance) =>
    <String, dynamic>{
      'source': instance.source,
      'token': instance.token,
      'accountId': instance.accountId,
    };

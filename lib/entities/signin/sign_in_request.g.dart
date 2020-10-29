// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_in_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignInRequest _$SignInRequestFromJson(Map<String, dynamic> json) {
  return SignInRequest()
    ..UserName = json['UserName'] as String
    ..Password = json['Password'] as String
    ..Source = json['Source'] as String
    ..DeviceId = json['DeviceId'] as String
    ..OperatingSystem = json['OperatingSystem'] as String;
}

Map<String, dynamic> _$SignInRequestToJson(SignInRequest instance) =>
    <String, dynamic>{
      'UserName': instance.UserName,
      'Password': instance.Password,
      'Source': instance.Source,
      'DeviceId': instance.DeviceId,
      'OperatingSystem': instance.OperatingSystem,
    };

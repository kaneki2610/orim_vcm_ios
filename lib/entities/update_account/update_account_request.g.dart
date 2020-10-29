// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_account_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateAccountRequest _$UpdateAccountRequestFromJson(Map<String, dynamic> json) {
  return UpdateAccountRequest(json['id'] as String,
      json['oldpassword'] as String, json['fullname'] as String);
}

Map<String, dynamic> _$UpdateAccountRequestToJson(
        UpdateAccountRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'oldpassword': instance.oldpassword,
      'fullname': instance.fullname
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfoData _$UserInfoDataFromJson(Map<String, dynamic> json) {
  return UserInfoData(
    name: json['name'] as String,
    phone: json['phone'] as String,
    identify: json['identify'] as String,
    enterprise: json['enterprise'] as String,
    address: json['address'] as String,
  );
}

Map<String, dynamic> _$UserInfoDataToJson(UserInfoData instance) =>
    <String, dynamic>{
      'name': instance.name,
      'phone': instance.phone,
      'identify': instance.identify,
      'enterprise': instance.enterprise,
      'address': instance.address,
    };

ResidentInfoData _$ResidentInfoDataFromJson(Map<String, dynamic> json) {
  return ResidentInfoData(
    name: json['name'] as String,
    phone: json['phone'] as String,
    identify: json['identify'] as String,
    enterprise: json['enterprise'] as String,
    address: json['address'] as String,
  );
}

Map<String, dynamic> _$ResidentInfoDataToJson(ResidentInfoData instance) =>
    <String, dynamic>{
      'name': instance.name,
      'phone': instance.phone,
      'identify': instance.identify,
      'enterprise': instance.enterprise,
      'address': instance.address,
    };
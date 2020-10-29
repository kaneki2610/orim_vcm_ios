// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personal_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonalInfoEntity _$PersonalInfoEntityFromJson(Map<String, dynamic> json) {
  return PersonalInfoEntity(
    accountId: json['accountId'] as String,
    fullname: json['fullname'] as String,
    address: json['address'] as String,
    email: json['email'] as String,
    phoneNumber: json['phoneNumber'] as String,
  );
}

Map<String, dynamic> _$PersonalInfoEntityToJson(PersonalInfoEntity instance) =>
    <String, dynamic>{
      'fullname': instance.fullname,
      'accountId': instance.accountId,
      'email': instance.email,
      'address': instance.address,
      'phoneNumber': instance.phoneNumber,
    };

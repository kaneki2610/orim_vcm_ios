// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personal_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonalInfoModel _$PersonalInfoModelFromJson(Map<String, dynamic> json) {
  return PersonalInfoModel(
    name: json['name'] as String,
    email: json['email'] as String,
    phoneNumber: json['phoneNumber'] as String,
    address: json['address'] as String,
    id: json['id'] as String,
    loginName: json['loginName'] as String,
    departmentName: json['departmentName'] as String,
  );
}

Map<String, dynamic> _$PersonalInfoModelToJson(PersonalInfoModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'address': instance.address,
      'id': instance.id,
      'loginName': instance.loginName,
      'departmentName': instance.departmentName,
    };

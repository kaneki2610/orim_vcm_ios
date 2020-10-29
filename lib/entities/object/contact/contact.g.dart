// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Contact _$ContactFromJson(Map<String, dynamic> json) {
  return Contact(
    name: json['name'] as String,
    phoneNumber: json['phoneNumber'] as String,
    address: json['address'] as String,
    email: json['email'] as String,
    accountId: json['accountId'] as int,
  );
}

Map<String, dynamic> _$ContactToJson(Contact instance) => <String, dynamic>{
      'name': instance.name,
      'phoneNumber': instance.phoneNumber,
      'address': instance.address,
      'email': instance.email,
      'accountId': instance.accountId,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_account_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateAccountRequest _$CreateAccountRequestFromJson(Map<String, dynamic> json) {
  return CreateAccountRequest()
    ..personalInformation = json['personalInformation'] == null
        ? null
        : PersonalInfoRequest.fromJson(
            json['personalInformation'] as Map<String, dynamic>)
    ..Source = json['Source'] as String
      ..fullname = json['fullname'];
}

Map<String, dynamic> _$CreateAccountRequestToJson(
        CreateAccountRequest instance) =>
    <String, dynamic>{
      'personalInformation': instance.personalInformation,
      'Source': instance.Source,
      'fullname': instance.fullname,
      'organization': {
        'id':instance.organizationId,
    },
    };

PersonalInfoRequest _$PersonalInfoRequestFromJson(Map<String, dynamic> json) {
  return PersonalInfoRequest(
    phoneNumber: json['phoneNumber'] as String,
  );
}

Map<String, dynamic> _$PersonalInfoRequestToJson(
        PersonalInfoRequest instance) =>
    <String, dynamic>{
      'phoneNumber': instance.phoneNumber,
    };

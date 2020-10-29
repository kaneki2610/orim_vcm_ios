// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_account_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateAccountResponse _$CreateAccountResponseFromJson(
    Map<String, dynamic> json) {
  return CreateAccountResponse(
    data: CreateAccountModel.fromJson(json)
  );
}

PersonalInformation _$PersonalInformationFromJson(Map<String, dynamic> json) {
  return PersonalInformation(
    code: json['code'] as String,
    name: json['name'] as String,
    email: json['email'] as String,
    phoneNumber: json['phoneNumber'] as String,
    imageAvatar: json['imageAvatar'] as String,
    address: json['address'] as String,
    partition: json['partition'] as String,
    id: json['id'] as String,
    createdOn: json['createdOn'] as String,
    createdBy: json['createdBy'] as String,
    errors: json["errors"],
  );
}

Map<String, dynamic> _$PersonalInformationToJson(
        PersonalInformation instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'imageAvatar': instance.imageAvatar,
      'address': instance.address,
      'partition': instance.partition,
      'id': instance.id,
      'createdOn': instance.createdOn,
      'createdBy': instance.createdBy,
      "errors": instance.errors,
    };

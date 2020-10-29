// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_account_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateAccountModel _$CreateAccountModelFromJson(Map<String, dynamic> json) {
  return CreateAccountModel(
    username: json['username'] as String,
    password: json['password'] as String,
    fullName: json['fullName'] as String,
    personalInformation: json['personalInformation'] == null
        ? null
        : PersonalInformation.fromJson(
        json['personalInformation'] as Map<String, dynamic>),
    status: json['status'] as int ?? 1,
    succeed: json['succeed'] as bool,
    idUser: json["id"] ?? "",
    errors: json['errors'] ?? [],
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
    };

Organization _$OrganizationFromJson(Map<String, dynamic> json) {
  return Organization(
    code: json['code'] as String,
    name: json['name'] as String,
    description: json['description'] as String,
    address: json['address'] as String,
    status: json['status'] as int,
    parentId: json['parentId'] as String,
    groupTemplateId: json['groupTemplateId'] as String,
    typeGroupTemplateId: json['typeGroupTemplateId'] as int,
    area: json['area'] == null
        ? null
        : Area.fromJson(json['area'] as Map<String, dynamic>),
    partition: json['partition'] as String,
    type: json['type'] as String,
    id: json['id'] as String,
    createdOn: json['createdOn'] as String,
    createdBy: json['createdBy'] as String,
  );
}

Map<String, dynamic> _$OrganizationToJson(Organization instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'description': instance.description,
      'address': instance.address,
      'status': instance.status,
      'parentId': instance.parentId,
      'groupTemplateId': instance.groupTemplateId,
      'typeGroupTemplateId': instance.typeGroupTemplateId,
      'area': instance.area,
      'partition': instance.partition,
      'type': instance.type,
      'id': instance.id,
      'createdOn': instance.createdOn,
      'createdBy': instance.createdBy,
    };

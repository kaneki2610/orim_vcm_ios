// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_in_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignInResponse _$SignInResponseFromJson(Map<String, dynamic> json) {
  return SignInResponse(
    msg: json['msg'] as String,
    code: 1,
    data: SignInModel.fromJson(json),
  );
}

SignInModel _$SignInModelFromJson(Map<String, dynamic> json) {
  return SignInModel(
    token: json['token'] as String,
    accountId: json['accountId'] as String,
    userName: json['userName'] as String,
    fullName: json['fullName'] as String,
    workspace: json['workspace'] as String,
    organization: json['organization'] == null
        ? null
        : Organization.fromJson(json['organization'] as Map<String, dynamic>),
    originOrganization: json['originOrganization'] == null
        ? null
        : Organization.fromJson(
            json['originOrganization'] as Map<String, dynamic>),
    infoDepartment: (json['infoDepartment'] as List)
        ?.map((e) => e == null
            ? null
            : InfoDepartment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    personalInformation: json['personalInformation'] == null
        ? null
        : PersonalInformation.fromJson(
            json['personalInformation'] as Map<String, dynamic>),
    configNumber: json['configNumber'] as String,
  );
}

Map<String, dynamic> _$SignInModelToJson(SignInModel instance) =>
    <String, dynamic>{
      'token': instance.token,
      'accountId': instance.accountId,
      'userName': instance.userName,
      'fullName': instance.fullName,
      'workspace': instance.workspace,
      'organization': instance.organization,
      'originOrganization': instance.originOrganization,
      'infoDepartment': instance.infoDepartment,
      'personalInformation': instance.personalInformation,
      'configNumber': instance.configNumber,
    };

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

InfoDepartment _$InfoDepartmentFromJson(Map<String, dynamic> json) {
  return InfoDepartment(
    code: json['code'] as String,
    name: json['name'] as String,
    description: json['description'] as String,
    parent: json['parent'] == null
        ? null
        : InfoDepartment.fromJson(json['parent'] as Map<String, dynamic>),
    status: json['status'] as int,
    organization: json['organization'] == null
        ? null
        : Organization.fromJson(json['organization'] as Map<String, dynamic>),
    partition: json['partition'] as String,
    id: json['id'] as String,
    createdOn: json['createdOn'] as String,
    createdBy: json['createdBy'] as String,
  );
}

Map<String, dynamic> _$InfoDepartmentToJson(InfoDepartment instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'description': instance.description,
      'parent': instance.parent,
      'status': instance.status,
      'organization': instance.organization,
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

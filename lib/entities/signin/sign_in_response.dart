import 'package:json_annotation/json_annotation.dart';
import 'package:orim/base/base_reponse.dart';
import 'package:orim/entities/object/area/area.dart';

part 'sign_in_response.g.dart';

@JsonSerializable(nullable: true)
class SignInResponse extends ResponseObject<SignInModel> {

  SignInResponse({String msg, int code,  dynamic data}) : super(msg: msg, code: code) {
    this.data = data;
  }

  factory SignInResponse.fromJson(Map<String, dynamic> json) =>
      _$SignInResponseFromJson(json);

}

@JsonSerializable(nullable: true)
class SignInModel {
  String token;
  String accountId;
  String userName;
  String fullName;
  String workspace;
  Organization organization;
  Organization originOrganization;
  List<InfoDepartment> infoDepartment;
  PersonalInformation personalInformation;
  String configNumber;

  SignInModel(
      {this.token,
      this.accountId,
      this.userName,
      this.fullName,
      this.workspace,
      this.organization,
      this.originOrganization,
      this.infoDepartment,
      this.personalInformation,
      this.configNumber});

  factory SignInModel.fromJson(Map<String, dynamic> json) => _$SignInModelFromJson(json);
  Map<String, dynamic> toJson() => _$SignInModelToJson(this);
}

@JsonSerializable(nullable: true)
class PersonalInformation {
  String code;
  String name;
  String email;
  String phoneNumber;
  String imageAvatar;
  String address;
  String partition;
  String id;
  String createdOn;
  String createdBy;

  PersonalInformation(
      {this.code,
      this.name,
      this.email,
      this.phoneNumber,
      this.imageAvatar,
      this.address,
      this.partition,
      this.id,
      this.createdOn,
      this.createdBy});

  factory PersonalInformation.fromJson(Map<String, dynamic> json) => _$PersonalInformationFromJson(json);
  Map<String, dynamic> toJson() => _$PersonalInformationToJson(this);
}

@JsonSerializable(nullable: true)
class InfoDepartment {
  String code;
  String name;
  String description;
  InfoDepartment parent;
  int status;
  Organization organization;
  String partition;
  String id;
  String createdOn;
  String createdBy;

  InfoDepartment(
      {this.code,
      this.name,
      this.description,
      this.parent,
      this.status,
      this.organization,
      this.partition,
      this.id,
      this.createdOn,
      this.createdBy});

  factory InfoDepartment.fromJson(Map<String, dynamic> json) => _$InfoDepartmentFromJson(json);
  Map<String, dynamic> toJson() => _$InfoDepartmentToJson(this);
}

@JsonSerializable(nullable: true)
class Organization {
  String code;
  String name;
  String description;
  String address;
  int status;
  String parentId;
  String groupTemplateId;
  int typeGroupTemplateId;
  Area area;
  String partition;
  String type;
  String id;
  String createdOn;
  String createdBy;

  Organization(
      {this.code,
      this.name,
      this.description,
      this.address,
      this.status,
      this.parentId,
      this.groupTemplateId,
      this.typeGroupTemplateId,
      this.area,
      this.partition,
      this.type,
      this.id,
      this.createdOn,
      this.createdBy});

  factory Organization.fromJson(Map<String, dynamic> json) => _$OrganizationFromJson(json);
  Map<String, dynamic> toJson() => _$OrganizationToJson(this);
}

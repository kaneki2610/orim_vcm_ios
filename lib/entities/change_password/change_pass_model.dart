import 'package:json_annotation/json_annotation.dart';
import 'package:orim/entities/object/area/area.dart';

part 'change_pass_model.g.dart';

@JsonSerializable(nullable: true)
class ChangePassModel {
  String username;
  String password;
  String fullName;
  Organization organization;
  PersonalInformation personalInformation;
  int status;

  ChangePassModel(
      {this.username,
        this.password,
        this.fullName,
        this.organization,
        this.personalInformation,
        this.status});

  factory ChangePassModel.fromJson(Map<String, dynamic> json) => _$ChangePassModelFromJson(json);
  Map<String, dynamic> toJson() => _$ChangePassModelToJson(this);
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

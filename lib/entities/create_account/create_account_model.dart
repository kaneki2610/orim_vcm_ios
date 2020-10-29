import 'package:json_annotation/json_annotation.dart';
import 'package:orim/entities/object/area/area.dart';

part 'create_account_model.g.dart';

@JsonSerializable(nullable: true)
class CreateAccountModel {
  String username;
  String password;
  String fullName;
  PersonalInformation personalInformation;
  int status;
  bool succeed;
  String idUser;
  List<dynamic>errors;

  CreateAccountModel(
      {this.username,
        this.password,
        this.fullName,
        this.personalInformation,
        this.status,
        this.succeed,
        this.errors,
      this.idUser});

  factory CreateAccountModel.fromJson(Map<String, dynamic> json) => _$CreateAccountModelFromJson(json);

  bool isCreateSuccessed(){
      return this.status == 0;
  }

  bool isExistAccount(){
    String exist = "PhoneNumber-Already-Exists";
    bool resuft = false;
    if(this.errors.length > 0){
      this.errors.forEach((element) {
        if(element == exist){
          resuft = true;
        }
      });
    }
    return resuft;
  }

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

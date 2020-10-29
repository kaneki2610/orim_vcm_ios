import 'package:json_annotation/json_annotation.dart';

part 'personal_info.g.dart';

@JsonSerializable(nullable: true)
class PersonalInfoModel {
  String name;
  String email;
  String phoneNumber;
//  String imageAvatar;
  String address;
//  String partition;
  String id; // CMND hoac passport
  String loginName;
  String departmentName;

  PersonalInfoModel(
      {this.name,
      this.email,
      this.phoneNumber,
//      this.imageAvatar,
      this.address,
//      this.partition,
      this.id,
      this.loginName,
      this.departmentName});

  factory PersonalInfoModel.fromJson(Map<String, dynamic> json) => _$PersonalInfoModelFromJson(json);
  Map<String, dynamic> toJson() => _$PersonalInfoModelToJson(this);
}

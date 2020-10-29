import 'package:json_annotation/json_annotation.dart';

part 'personal_info.g.dart';

@JsonSerializable(nullable: true)
class PersonalInfoEntity {
  String fullname;
  String accountId;
  String email;
  String address;
  String phoneNumber;

  PersonalInfoEntity(
      {this.accountId,
      this.fullname,
      this.address,
      this.email,
      this.phoneNumber});

  factory PersonalInfoEntity.fromJson(Map<String, dynamic> json) =>
      _$PersonalInfoEntityFromJson(json);

  Map<String, dynamic> toJson() => _$PersonalInfoEntityToJson(this);
}

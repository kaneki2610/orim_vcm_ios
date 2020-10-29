import 'package:json_annotation/json_annotation.dart';

part 'user_info_data.g.dart';

@JsonSerializable()
class UserInfoData {
  String name;
  String phone;
  String identify;
  String enterprise;
  String address;

  UserInfoData({ this.name = "", this.phone = "", this.identify = "", this.enterprise = "", this.address = "" });
  factory UserInfoData.fromJson(Map<String, dynamic> json) => _$UserInfoDataFromJson(json);
  Map<String, dynamic> toJson() => _$UserInfoDataToJson(this);
}

class ResidentInfoData {
  String name;
  String phone;
  String identify;
  String enterprise;
  String address;

  ResidentInfoData(
      { this.name = "", this.phone = "", this.identify = "", this.enterprise = "", this.address = "" });
  factory ResidentInfoData.fromJson(Map<String, dynamic> json) => _$ResidentInfoDataFromJson(json);
  Map<String, dynamic> toJson() => _$ResidentInfoDataToJson(this);
}
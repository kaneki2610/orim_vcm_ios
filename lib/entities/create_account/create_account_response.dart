import 'package:json_annotation/json_annotation.dart';
import 'package:orim/base/base_reponse.dart';
import 'package:orim/entities/create_account/create_account_model.dart';
import 'package:orim/entities/object/area/area.dart';

part 'create_account_response.g.dart';

@JsonSerializable(nullable: true)
class CreateAccountResponse extends ResponseObject<CreateAccountModel> {

  CreateAccountResponse({int code, String msg, dynamic data})
      : super(code: code, msg: msg) {
    this.data = data;
  }

  factory CreateAccountResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateAccountResponseFromJson(json);
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
  List<String> errors;

  PersonalInformation({this.code,
    this.name,
    this.email,
    this.phoneNumber,
    this.imageAvatar,
    this.address,
    this.partition,
    this.id,
    this.errors,
    this.createdOn,
    this.createdBy});

  factory PersonalInformation.fromJson(Map<String, dynamic> json) =>
      _$PersonalInformationFromJson(json);

  Map<String, dynamic> toJson() => _$PersonalInformationToJson(this);
}

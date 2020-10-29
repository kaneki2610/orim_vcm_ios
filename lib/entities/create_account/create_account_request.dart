import 'package:json_annotation/json_annotation.dart';

part 'create_account_request.g.dart';

@JsonSerializable(nullable: true)
class CreateAccountRequest {
  PersonalInfoRequest personalInformation;
  String Source;
  String fullname;
  String organizationId;

  CreateAccountRequest(
      {String phoneNumber,
      String source,
      String fullname,
      String organizationId})
      : this.personalInformation =
            PersonalInfoRequest(phoneNumber: phoneNumber),
        this.Source = source,
        this.fullname = fullname,
        this.organizationId = organizationId;

  factory CreateAccountRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateAccountRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateAccountRequestToJson(this);
}

@JsonSerializable(nullable: true)
class PersonalInfoRequest {
  String phoneNumber;

  PersonalInfoRequest({String phoneNumber}) : this.phoneNumber = phoneNumber;

  factory PersonalInfoRequest.fromJson(Map<String, dynamic> json) =>
      _$PersonalInfoRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PersonalInfoRequestToJson(this);
}

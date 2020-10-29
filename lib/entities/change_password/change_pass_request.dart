import 'package:json_annotation/json_annotation.dart';
import 'package:orim/utils/encrypt_utils.dart';

part 'change_pass_request.g.dart';

@JsonSerializable(nullable: true)
class ChangePassRequest {
  String password;

  ChangePassRequest({String password})
      : this.password = EncryptUtils.encryptPassword(password);

  factory ChangePassRequest.fromJson(Map<String, dynamic> json) =>  _$ChangePassRequestFromJson(json);
  Map<String, dynamic> toJson() => _$ChangePassRequestToJson(this);
}

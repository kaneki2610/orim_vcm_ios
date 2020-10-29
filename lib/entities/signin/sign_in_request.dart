import 'dart:io';

import 'package:json_annotation/json_annotation.dart';
import 'package:orim/utils/encrypt_utils.dart';

part 'sign_in_request.g.dart';

@JsonSerializable(nullable: true)
class SignInRequest {
  String UserName;
  String Password;
  String Source = 'mobile';
  String DeviceId;
  String OperatingSystem;

  SignInRequest({String userName, String password, String deviceId})
      : this.UserName = userName,
        this.Password = EncryptUtils.encryptPassword(password),
        this.OperatingSystem =
            Platform.isIOS ? 'i' : Platform.isAndroid ? 'a' : 'unknown',
        this.DeviceId = deviceId;

  factory SignInRequest.fromJson(Map<String, dynamic> json) =>
      _$SignInRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SignInRequestToJson(this);
}

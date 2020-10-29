import 'package:json_annotation/json_annotation.dart';

part 'info_login.g.dart';

@JsonSerializable(nullable: false)
class InfoLogin {
  String username;
  String password;

  InfoLogin({ this.username, this.password });

  factory InfoLogin.fromJson(Map<String, dynamic> json) =>
    _$InfoLoginFromJson(json);

  Map<String, dynamic> toJson() => _$InfoLoginToJson(this);
}
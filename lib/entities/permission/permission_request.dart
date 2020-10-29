import 'package:json_annotation/json_annotation.dart';

part 'permission_request.g.dart';

@JsonSerializable(nullable: true)
class PermissionRequest {
  String source;
  String token;
  String accountId;

  PermissionRequest(
      {this.source = 'menu_app', this.token = '', this.accountId = ''});

  factory PermissionRequest.fromJson(Map<String, dynamic> json) =>
      _$PermissionRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PermissionRequestToJson(this);
}

import 'package:json_annotation/json_annotation.dart';

part 'logout_request.g.dart';

@JsonSerializable(nullable: true)
class LogoutRequest {
  final String source;

  const LogoutRequest({this.source = 'mobile'});

  factory LogoutRequest.fromJson(Map<String, dynamic> json) =>
      _$LogoutRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LogoutRequestToJson(this);
}

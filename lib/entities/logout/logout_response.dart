import 'package:json_annotation/json_annotation.dart';

part 'logout_response.g.dart';

@JsonSerializable(nullable: true)
class LogoutResponse {
  List<dynamic> errors;
  bool succeed;
  bool failed;
  dynamic data;
  String functionName;

  LogoutResponse(
      {this.errors, this.succeed, this.failed, this.data, this.functionName});

  factory LogoutResponse.fromJson(Map<String, dynamic> json) =>
    _$LogoutResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LogoutResponseToJson(this);
}

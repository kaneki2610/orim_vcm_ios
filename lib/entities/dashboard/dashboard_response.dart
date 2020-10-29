import 'package:json_annotation/json_annotation.dart';
import 'package:orim/base/base_reponse.dart';
import 'package:orim/base/response.dart';
import 'package:orim/model/dashboardarea/dashboard_object.dart';

part  'dashboard_response.g.dart';

@JsonSerializable(nullable: true)
class DashBoardResponse extends ResponseObject<DashBoardObjectModel> {
  DashBoardResponse({ int code, String msg, String msgToken, dynamic data})
      : super(code: code, msg: msg, msgToken: msgToken) {
    this.data = data;
  }
  factory DashBoardResponse.fromJson(Map<String, dynamic> json) =>
      _$DashBoardResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DashBoardResponseToJson(this);
}
import 'package:json_annotation/json_annotation.dart';

part 'dasboard_request.g.dart';
@JsonSerializable(nullable: true)
class DashboardRequest {
  String areaCodeStatic;
  String kindOfTime;

  DashboardRequest({this.areaCodeStatic, this.kindOfTime});

  factory DashboardRequest.fromJson(Map<String, dynamic> json) => _$dashboardRequestFromJson(json);
  Map<String, dynamic> toJson() => _$DashBoardRequestToJson(this);

  Map<String, String> getHeaders(String token) {
    return Map.from({
      'Content-Type': 'application/json',
      'token': token
    });
  }
}
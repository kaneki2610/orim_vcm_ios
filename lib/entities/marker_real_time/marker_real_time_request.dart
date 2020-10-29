import 'package:json_annotation/json_annotation.dart';

part 'marker_real_time_request.g.dart';

@JsonSerializable()
class MarkerRealTimeRequest{
  String areaCode;
  String fromDate;
  String toDate;
  MarkerRealTimeRequest({this.areaCode, this.fromDate, this.toDate});
  factory MarkerRealTimeRequest.fromJson(Map<String, dynamic> json) =>
      _$MarkerRealTimeRequestFromJson(json);

  Map<String, dynamic> toJson() => _$MarkerRealTimeRequestToJson(this);

  String get getUrl{
    return "?areaCode=$areaCode&toDate=$toDate&fromDate=$fromDate";
  }
}


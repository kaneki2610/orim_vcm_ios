import 'package:json_annotation/json_annotation.dart';

part 'area_request.g.dart';

@JsonSerializable()
class AreaRequest {
  String latlng;
  String name;

  AreaRequest({ this.latlng, this.name});

  factory AreaRequest.fromJson(Map<String, dynamic> json) =>
      _$AreaRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AreaRequestToJson(this);
}
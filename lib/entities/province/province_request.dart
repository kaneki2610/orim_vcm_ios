import 'package:json_annotation/json_annotation.dart';

part 'province_request.g.dart';

@JsonSerializable()
class ProvinceRequest {
  String type;

  ProvinceRequest({ this.type = "city" });

  factory ProvinceRequest.fromJson(Map<String, dynamic> json) =>
      _$ProvinceRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ProvinceRequestToJson(this);
}
import 'package:json_annotation/json_annotation.dart';

part 'ward_request.g.dart';

@JsonSerializable()
class WardRequest {
  String type;
  int parentcode;

  WardRequest({this.type = 'district', this.parentcode});

  factory WardRequest.fromJson(Map<String, dynamic> json) =>
      _$WardRequestFromJson(json);

  Map<String, dynamic> toJson() => _$WardRequestToJson(this);
}

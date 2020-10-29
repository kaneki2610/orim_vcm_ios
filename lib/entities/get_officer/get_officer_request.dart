import 'package:json_annotation/json_annotation.dart';

part 'get_officer_request.g.dart';

@JsonSerializable(nullable: true)
class GetOfficerRequest {
  final String departmentId;

  GetOfficerRequest({this.departmentId});

  factory GetOfficerRequest.fromJson(Map<String, dynamic> json) => _$GetOfficerRequestFromJson(json);
  Map<String, dynamic> toJson() => _$GetOfficerRequestToJson(this);
}
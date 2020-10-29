import 'package:json_annotation/json_annotation.dart';
import 'package:orim/base/base_reponse.dart';
import 'package:orim/entities/object/organization_permission/Organization.dart';
import 'package:orim/model/organization_permission/organization_permisstion.dart';

part 'organization_response.g.dart';

@JsonSerializable(nullable: true)

class OrganizationResponse extends ResponseObject<OrganizationModel> {
  OrganizationResponse({int code, String msg, Map<String, dynamic> data, String msgToken})
      : super(code: code, msg: msg, msgToken: msgToken) {
    this.data = OrganizationModel.from(OrganizationPermission.fromJson(data));
}

  factory OrganizationResponse.fromJson(Map<String, dynamic> json) =>
      _$OrganizationResponseFromJson(json);

/*  Map<String, dynamic> toJson() => _$MarkerRealTimeReponseToJson(this);*/
}
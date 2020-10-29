
import 'package:json_annotation/json_annotation.dart';
import 'package:orim/entities/object/organization_permission/Organization.dart';

part 'organization_permisstion.g.dart';

@JsonSerializable()
class OrganizationModel {
  String id;

  OrganizationModel(this.id);

  factory OrganizationModel.fromJson(Map<String, dynamic> json) =>
      _$OrganizationModelFromJson(json);

  factory OrganizationModel.from(OrganizationPermission org) =>
      OrganizationModel(org.id);

  Map<String, dynamic> toJson() => _$OrganizationModelToJson(this);

}
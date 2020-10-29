import 'package:json_annotation/json_annotation.dart';

part 'organization.g.dart';

@JsonSerializable(nullable: true)
class Organization {
  String code;
  String name;
  dynamic description;
  String address;
  int status;
  String parentId;
  String groupTemplateId;
  int typeGroupTemplateId;
  String partition;
  String type;
  String id;
  String createdOn;
  String updatedOn;
  String createdBy;

  Organization(
    {this.address,
      this.code,
      this.createdBy,
      this.createdOn,
      this.description,
      this.groupTemplateId,
      this.id,
      this.name,
      this.parentId,
      this.partition,
      this.status,
      this.type,
      this.typeGroupTemplateId,
      this.updatedOn});

  factory Organization.fromJson(Map<String, dynamic> json) =>
    _$OrganizationFromJson(json);

  Map<String, dynamic> toJson() => _$OrganizationToJson(this);
}
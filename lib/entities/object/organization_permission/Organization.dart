import 'package:json_annotation/json_annotation.dart';

part 'Organization.g.dart';

@JsonSerializable()
class OrganizationPermission {
    OrganizationPermission();

    String code;
    String name;
    String description;
    String address;
    num status;
    String parentId;
    String groupTemplateId;
    num typeGroupTemplateId;
    Area area;
    String partition;
    String type;
    String id;
    String createdOn;
    String createdBy;
    
    factory OrganizationPermission.fromJson(Map<String,dynamic> json) => _$OrganizationPermissionFromJson(json);
    Map<String, dynamic> toJson() => _$OrganizationPermissionToJson(this);
}

@JsonSerializable()
class Area {
    Area();

    String id;
    String code;
    String name;
    num status;
    String search;
    String parentCode;
    String type;

    factory Area.fromJson(Map<String,dynamic> json) => _$AreaFromJson(json);
    Map<String, dynamic> toJson() => _$AreaToJson(this);
}
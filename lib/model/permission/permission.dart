import 'package:json_annotation/json_annotation.dart';
import 'package:orim/entities/permission/permission_response.dart';
part 'permission.g.dart';
@JsonSerializable(nullable: true)
class PermissionModel {
  String code;
  String name;
  String id;

  PermissionModel({this.code, this.name, this.id});

  factory PermissionModel.fromJson(Menu menu) => _$PermissionModelFromJson(menu);
  Map<String, dynamic> toJson() => _$PermissionModelToJson(this);

}

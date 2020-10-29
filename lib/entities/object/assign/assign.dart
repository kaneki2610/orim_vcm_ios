import 'package:json_annotation/json_annotation.dart';
import 'package:orim/entities/object/area/area.dart';

part 'assign.g.dart';

@JsonSerializable(nullable: true)
class Assign {
  String id;
  String name;
  String code;
  String phoneNumber;
  String email;
  dynamic source;
  String departmentId;
  String parentid;
  String departmentName;
  Area area;
  String objectType;

  Assign(
      {this.id,
      this.name,
      this.code,
      this.phoneNumber,
      this.email,
      this.source,
      this.departmentId,
      this.parentid,
      this.departmentName,
      this.area,
      this.objectType});

  factory Assign.fromJson(Map<String, dynamic> json) => _$AssignFromJson(json);
  Map<String, dynamic> toJson() => _$AssignToJson(this);
}

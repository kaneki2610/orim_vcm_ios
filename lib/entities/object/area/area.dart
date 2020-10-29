import 'package:json_annotation/json_annotation.dart';

part 'area.g.dart';

@JsonSerializable(nullable: true)
class Area {
  String id;
  String code;
  String parentCode;
  String type;
  String name;
  int status;
  String search;

  Area(
      {this.id,
      this.code,
      this.parentCode,
      this.type,
      this.name,
      this.status,
      this.search});

  factory Area.fromJson(Map<String, dynamic> json) => _$AreaFromJson(json);

  Map<String, dynamic> toJson() => _$AreaToJson(this);
}

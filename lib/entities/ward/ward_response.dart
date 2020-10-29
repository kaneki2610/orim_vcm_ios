import 'package:json_annotation/json_annotation.dart';

part 'ward_response.g.dart';

@JsonSerializable(nullable: false)
class WardResponse {
  String msg;
  int error;
  List<WardEntity> list;

  WardResponse({this.msg, this.error, this.list});

  factory WardResponse.fromJson(Map<String, dynamic> json) =>
      _$WardResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WardResponseToJson(this);
}

@JsonSerializable(nullable: true)
class WardEntity {
  String id;
  String code;
  String name;
  int status;
  String search;
  String fts_key;
  String areaCode;
  String parentCode;
  String type;

  WardEntity(
      {this.id,
      this.code,
      this.name,
      this.status,
      this.search,
      this.fts_key,
      this.areaCode,
      this.parentCode,
      this.type});

  factory WardEntity.fromJson(Map<String, dynamic> json) =>
      _$WardEntityFromJson(json);

  Map<String, dynamic> toJson() => _$WardEntityToJson(this);
}

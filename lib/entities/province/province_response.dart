import 'package:json_annotation/json_annotation.dart';

part 'province_response.g.dart';

@JsonSerializable(nullable: true)
class ProvinceResponse {
  String msg;
  int error;
  List<ProvinceEntity> list;

  ProvinceResponse({this.msg, this.error, this.list});

  factory ProvinceResponse.fromJson(Map<String, dynamic> json) =>
      _$ProvinceResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProvinceResponseToJson(this);
}

@JsonSerializable(nullable: true)
class ProvinceEntity {
  String id;
  String code;
  String name;
  int status;
  String search;
  String fts_key;
  String areaCode;
  String parentCode;
  String type;

  ProvinceEntity(
      {this.id,
      this.code,
      this.name,
      this.status,
      this.search,
      this.fts_key,
      this.areaCode,
      this.parentCode,
      this.type});

  factory ProvinceEntity.fromJson(Map<String, dynamic> json) =>
      _$ProvinceEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ProvinceEntityToJson(this);
}

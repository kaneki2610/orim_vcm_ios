import 'package:json_annotation/json_annotation.dart';

part 'area_model.g.dart';

@JsonSerializable(nullable: true)
class AreaModel {
  String msg;
  int error;
  CurrentProvince currentProvince;
  CurrentDistrict currentDistrict;
  CurrentWard currentWard;
  List<DistrictList> districtList;

  AreaModel({this.msg, this.error, this.currentProvince, this.currentDistrict, this.currentWard, this.districtList});

  factory AreaModel.fromJson(Map<String, dynamic> json) =>
      _$AreaModelFromJson(json);

  Map<String, dynamic> toJson() => _$AreaModelToJson(this);
}

@JsonSerializable(nullable: true)
class CurrentProvince {
  String id;
  String code;
  String name;
  String areaCode;
  String parentCode;
  String type;

  CurrentProvince(
      {this.id,
        this.code,
        this.name,
        this.areaCode,
        this.parentCode,
        this.type});

  factory CurrentProvince.fromJson(Map<String, dynamic> json) =>
      _$CurrentProvinceFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentProvinceToJson(this);
}

@JsonSerializable(nullable: true)
class CurrentDistrict {
  String id;
  String code;
  String name;
  String areaCode;
  String parentCode;
  String type;

  CurrentDistrict(
      {this.id,
        this.code,
        this.name,
        this.areaCode,
        this.parentCode,
        this.type});

  factory CurrentDistrict.fromJson(Map<String, dynamic> json) =>
      _$CurrentDistrictFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentDistrictToJson(this);
}

@JsonSerializable(nullable: true)
class CurrentWard {
  String id;
  String code;
  String name;
  String areaCode;
  String parentCode;
  String type;

  CurrentWard(
      {this.id,
        this.code,
        this.name,
        this.areaCode,
        this.parentCode,
        this.type});

  factory CurrentWard.fromJson(Map<String, dynamic> json) =>
      _$CurrentWardFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentWardToJson(this);
}

@JsonSerializable(nullable: true)
class DistrictList {
  String id;
  String code;
  String name;
  String areaCode;
  String parentCode;
  String type;
  List<CurrentWard> wardList;

  DistrictList(
      {this.id,
        this.code,
        this.name,
        this.areaCode,
        this.parentCode,
        this.type,
        this.wardList});

  factory DistrictList.fromJson(Map<String, dynamic> json) =>
      _$DistrictListFromJson(json);

  Map<String, dynamic> toJson() => _$DistrictListToJson(this);
}


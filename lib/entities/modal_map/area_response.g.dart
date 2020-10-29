// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'area_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AreaResponse _$AreaResponseFromJson(Map<String, dynamic> json) {
  return AreaResponse(
    msg: json['msg'] as String,
    code: json['error'] == 0 ? 1 : 401,
    data: AreaModel.fromJson(json),
  );
}
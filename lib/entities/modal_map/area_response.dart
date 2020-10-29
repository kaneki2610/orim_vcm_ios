import 'package:json_annotation/json_annotation.dart';
import 'package:orim/base/base_reponse.dart';
import 'package:orim/model/area/area_model.dart';

part 'area_response.g.dart';

@JsonSerializable(nullable: true)
class AreaResponse extends ResponseObject<AreaModel> {

  AreaResponse({String msg, int code,  dynamic data}) : super(msg: msg, code: code) {
    this.data = data;
  }

  factory AreaResponse.fromJson(Map<String, dynamic> json) =>
      _$AreaResponseFromJson(json);

}


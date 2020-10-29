import 'package:json_annotation/json_annotation.dart';
import 'package:orim/base/base_reponse.dart';
import 'package:orim/entities/change_password/change_pass_model.dart';
import 'package:orim/entities/object/area/area.dart';

part 'change_pass_response.g.dart';

@JsonSerializable(nullable: true)
class ChangePassResponse extends ResponseObject<ChangePassModel> {

  ChangePassResponse({int code, String msg, dynamic data}) : super(code: code, msg: msg) {
    this.data = data;
  }

  factory ChangePassResponse.fromJson(Map<String, dynamic> json) => _$ChangePassResponseFromJson(json);
}

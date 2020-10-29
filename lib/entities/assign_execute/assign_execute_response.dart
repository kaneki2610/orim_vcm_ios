import 'package:json_annotation/json_annotation.dart';
import 'package:orim/base/base_reponse.dart';
import 'package:orim/base/response.dart';

part 'assign_execute_response.g.dart';

@JsonSerializable(nullable: true)
class AssignResponse extends ResponseObject<bool> {
  AssignResponse({int code, String msg, String msgToken})
      : super(code: code, msg: msg, msgToken: msgToken){
    this.data = this.isSuccess();
  }

  factory AssignResponse.fromJson(Map<String, dynamic> json) => _$AssignResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AssignResponseToJson(this);
}

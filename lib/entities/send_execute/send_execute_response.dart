import 'package:json_annotation/json_annotation.dart';
import 'package:orim/base/base_reponse.dart';
import 'package:orim/base/response.dart';

part 'send_execute_response.g.dart';

@JsonSerializable(nullable: true)
class SendExecuteResponse extends ResponseObject<bool> {
  SendExecuteResponse({int code, String msg,  String msgToken})
    : super(code: code, msg: msg, msgToken: msgToken){
    this.data = this.isSuccess();
  }

  factory SendExecuteResponse.fromJson(Map<String, dynamic> json) => _$SendExecuteResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SendExecuteResponseToJson(this);
}
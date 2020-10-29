import 'package:json_annotation/json_annotation.dart';
import 'package:orim/base/base_reponse.dart';
import 'package:orim/base/response.dart';

part 'send_approved_response.g.dart';

@JsonSerializable(nullable: true)
class SendApprovedResponse extends ResponseObject<bool> {
  SendApprovedResponse({int code, String msg, bool data, String msgToken})
    : super(code: code, msg: msg, data: data, msgToken: msgToken);

  factory SendApprovedResponse.fromJson(Map<String, dynamic> json) =>
    _$SendApprovedResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SendApprovedResponseToJson(this);
}

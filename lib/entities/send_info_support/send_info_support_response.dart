import 'package:json_annotation/json_annotation.dart';
import 'package:orim/base/base_reponse.dart';
import 'package:orim/base/response.dart';

part 'send_info_support_response.g.dart';

@JsonSerializable(nullable: true)
class SendInfoSupportResponse extends ResponseObject<bool> {
  SendInfoSupportResponse({int code, String msg, String msgToken})
      : super(code: code, msg: msg,  msgToken: msgToken){
   this.data = this.isSuccess();
  }

  factory SendInfoSupportResponse.fromJson(Map<String, dynamic> json) =>
      _$SendInfoSupportResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SendInfoSupportResponseToJson(this);
}

import 'package:json_annotation/json_annotation.dart';
import 'package:orim/base/base_reponse.dart';
import 'package:orim/base/response.dart';

part 'report_spam_response.g.dart';

@JsonSerializable(nullable: true)
class ReportSpamResponse extends ResponseObject<bool> {
  ReportSpamResponse({int code, String msg, String msgToken}): super(code: code, msg: msg, msgToken: msgToken){
    this.data = this.isSuccess();
  }

  factory ReportSpamResponse.fromJson(Map<String, dynamic> json) =>
    _$ReportSpamResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ReportSpamResponseToJson(this);
}
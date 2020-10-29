import 'package:json_annotation/json_annotation.dart';
import 'package:orim/base/response.dart';

part 'send_feedback_response.g.dart';

@JsonSerializable(nullable: true)
class SendFeedbackResponse extends BaseResponse<Data> {
  SendFeedbackResponse({int code, String msg, Data data, String msgToken}): super(code: code, msg: msg, data: data, msgToken: msgToken);

  factory SendFeedbackResponse.fromJson(Map<String, dynamic> json) =>
      _$SendFeedbackResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SendFeedbackResponseToJson(this);
}

@JsonSerializable(nullable: true)
class Data {
  String id;

  Data({this.id});

  factory Data.fromJson(Map<String, dynamic> json) =>
      _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

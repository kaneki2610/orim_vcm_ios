import 'package:json_annotation/json_annotation.dart';

part 'send_feedback_resquest.g.dart';

@JsonSerializable(nullable: true)
class SendFeedbackRequest {
  final String Id;
  final double Rating;
  final String RatingComment;

  const SendFeedbackRequest({this.Id, this.Rating, this.RatingComment});

  factory SendFeedbackRequest.fromJson(Map<String, dynamic> json) =>
      _$SendFeedbackRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SendFeedbackRequestToJson(this);
}

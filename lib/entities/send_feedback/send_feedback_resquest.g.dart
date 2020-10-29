// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_feedback_resquest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendFeedbackRequest _$SendFeedbackRequestFromJson(Map<String, dynamic> json) {
  return SendFeedbackRequest(
    Id: json['Id'] as String,
    Rating: (json['Rating'] as num)?.toDouble(),
    RatingComment: json['RatingComment'] as String,
  );
}

Map<String, dynamic> _$SendFeedbackRequestToJson(
        SendFeedbackRequest instance) =>
    <String, dynamic>{
      'Id': instance.Id,
      'Rating': instance.Rating,
      'RatingComment': instance.RatingComment,
    };

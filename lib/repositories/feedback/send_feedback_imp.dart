import 'dart:convert';

import 'package:http/http.dart';
import 'package:orim/entities/send_feedback/send_feedback_response.dart';
import 'package:orim/entities/send_feedback/send_feedback_resquest.dart';
import 'package:orim/repositories/feedback/send_feedback_repo.dart';
import 'package:orim/utils/api_service.dart';

class SendFeedbackImp implements SendFeedbackRepo {

  ApiService apiService;
  final String _subURL = 'kong/api/core/v1/issue/update/rating';

  @override
  Future<bool> sendFeedback({String id, double mark, String commentRating}) async {
    SendFeedbackRequest request = SendFeedbackRequest(Id: id, Rating: mark, RatingComment: commentRating);
    Response response = await apiService.post(_subURL, data: request);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      SendFeedbackResponse sendFeedResponse = SendFeedbackResponse.fromJson(json.decode(response.body));
      if (sendFeedResponse.isSuccess()) {
        return true;
      } else {
        throw sendFeedResponse.msg ?? sendFeedResponse.code;
      }
    } else {
      throw response.body ?? response.statusCode;
    }
  }
}

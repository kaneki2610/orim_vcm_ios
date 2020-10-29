abstract class SendFeedbackRepo {
  Future<bool> sendFeedback({ String id, double mark, String commentRating });
}
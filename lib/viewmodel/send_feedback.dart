import 'package:orim/base/viewmodel.dart';
import 'package:orim/repositories/feedback/send_feedback_repo.dart';

class SendFeedbackViewModel extends BaseViewModel {

  SendFeedbackRepo sendFeedbackRepo;

  Future<bool> sendFeedback({ String id, double mark, String comment }) async {
    try {
      bool res = await sendFeedbackRepo.sendFeedback(
          id: id, mark: mark, commentRating: comment);
      return res;
    } catch (err) {
      throw err;
    }
  }
}

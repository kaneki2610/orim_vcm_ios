abstract class IssueDetailView {
  Future<bool> showLoading();
  Future<bool> hideLoading();
  void sendFeedbackSuccess();
  void sendFeedbackFailed(String msg);
  bool back();
}
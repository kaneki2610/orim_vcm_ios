abstract class IssueNeedSupportView {
  void showMessageTimeout();

  void showMessage({String msg});

  void showMessageNotPermission();

  void showMessageExpired();

  void showMessageSendInfoSupportSuccess();

  void showMessageSendInfoSupportFailed();

  Future<bool> showLoading();

  Future<bool> hideLoading();
}

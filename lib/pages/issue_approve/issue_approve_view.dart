abstract class IssueApproveView {
  void showMessage({String msg});

  void showApproveSuccess();

  void showApproveFailed();

  void showMessageTimeout();

  void showMessageExpired();

  void showMessageNotPermission();

  Future<void> hideLoading();

  Future<void> showLoading();
}
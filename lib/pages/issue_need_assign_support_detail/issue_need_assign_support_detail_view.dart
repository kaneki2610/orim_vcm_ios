abstract class IssueNeedAssignSupportDetailView {
  void showMessageTimeout();

  Future<void> showMessage({String msg});

  Future<void> showMessageOfficerMissing();

  Future<void> showMessagePermissionDeny();
  Future<void> showMessageExpired();

  void assignSupportSucceed();

  void assignSupportFailed();

  Future<void> showLoading();

  Future<void> hideLoading();
}

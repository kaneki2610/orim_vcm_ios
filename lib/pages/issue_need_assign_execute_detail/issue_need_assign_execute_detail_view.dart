abstract class IssueNeedAssignDetailView {
  Future<void> showMessage({String msg});

  Future<void> showErrorNoSelectSpecialist();

  Future<void> showErrorNoSelectDepartment();

  Future<void> sendAssignExecuteSuccess();

  Future<void> showMessageTimeout();

  Future<void> dontHavePermission();

  Future<void> sendAssignExecuteFailed();

  Future<void> showLoading();

  Future<void> hideLoading();

  void sendReportSucceed();

  void sendReportFailed();

  void back();

  void showMessageExpired();

  Future<void> showPopUpSupportError();

  Future<void> showPopUpUnitError();
}

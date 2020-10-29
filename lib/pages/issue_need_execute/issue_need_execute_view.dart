abstract class IssueNeedExecuteView {
  Future<void> showMessage({String msg});

  Future<void> showMessageNoCategoryExecute();

  void openCategoriesExecute();

  void showTimeout();

  void showNotPermission();

  void showMesageExpired();

  void sendExecuteSuccess();

  void sendExecuteFailed();

  Future<void> showLoading();

  Future<void> hideLoading();

  void showMessageErrorWhenUploading();
}

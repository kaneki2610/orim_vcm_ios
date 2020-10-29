abstract class ChangePasswordView {
  Future<bool> showLoading();

  Future<bool> hideLoading();

  Future<void> showToastWithMessage(String msg);
}

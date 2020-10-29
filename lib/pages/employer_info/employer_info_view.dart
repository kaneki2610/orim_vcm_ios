abstract class EmployerInfoView {
  Future<bool> showLoading();

  Future<bool> hideLoading();

  void showMessageWhenLogoutSucceed();

  void showMessageWhenLogoutFailed(String msg);

  void showMessageWhenLogoutTimeout();
}

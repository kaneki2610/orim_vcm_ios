abstract class ModalMapView {
  Future<bool> showLoading();

  Future<bool> hideLoading();

  void showToastWithMessage(String msg);
}

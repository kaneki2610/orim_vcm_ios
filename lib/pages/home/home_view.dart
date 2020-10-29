import 'package:orim/model/notification/notification.dart';

abstract class HomeView {
  Future<bool> showLoading();
  Future<bool> hideLoading();
  void showMessageWhenLogoutSucceed();
  void showMessageWhenLogoutFailed(String msg);
  void showMessageWhenLogoutTimeout();
  void showNotification({Notification notification});
  void showUpdateApp(String url);
  void showPopupTokenExpired(Function callback);

}
abstract class IssueProcessView {
  Future<void> showMessage({String msg});

  Future<void> showMessageExpired();

  Future<void> showNotPermission();

  Future<void> showTimeout();
}
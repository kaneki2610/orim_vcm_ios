import 'dart:async';

class TaskRunner {

  Duration _duration;
  Timer _timer;

  void executeImediately(Function() callback) {
    cancel();
    _duration = Duration();
    _timer = Timer(_duration, callback);
  }

  void executeDelay(Function() callback, {int seconds = 0, int milliseconds = 0}) {
    cancel();
    _duration = Duration(seconds: seconds, milliseconds: milliseconds);
    _timer = Timer(_duration, callback);
  }

  void cancel() {
    _timer?.cancel();
  }
}

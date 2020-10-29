import 'dart:async';

import 'package:orim/base/subject.dart';

abstract class BaseObserver<T> {
  PublishSubject<T> _dataObserver = PublishSubject<T>();

  StreamSubscription<T> listener({Function(T) onDataChange, Function() onDone, Function onError, bool cancelOnError = false}) {
    return _dataObserver.listen(onDataChange, onDone: onDone, onError: onError, cancelOnError: cancelOnError);
  }

  // ignore: unnecessary_getters_setters
  T get data => _dataObserver.value;

  // ignore: unnecessary_getters_setters
  set data(T value) {
    _dataObserver.value = value;
  }

  PublishSubject<T> get dataObserver => _dataObserver;

  void dispose() {
    _dataObserver.close();
  }
}
import 'dart:isolate';

class TaskUtil {
  run(dynamic function, {Function callback}) async {
    ReceivePort receivePort = ReceivePort();
    Isolate.spawn((SendPort sendPort) async => sendPort.send(await function),
        receivePort.sendPort);
    receivePort.listen((data) {
      if (callback != null) {
        callback(data);
      }
      receivePort.close();
    });
  }
}

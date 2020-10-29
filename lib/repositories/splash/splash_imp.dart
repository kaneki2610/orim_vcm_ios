import 'package:flutter/cupertino.dart';
import 'package:orim/repositories/splash/splash.dart';
import 'package:orim/utils/storage/storage.dart';

class SplashImp implements SplashRepo {

  Storage storage;
  final String _key = 'isReadIntro';

  @override
  Future<bool> getIsReadIntro() async {
    try {
      final Map<String, dynamic> map = await storage.readObject(_key);
      if (map != null) {
        if (map[_key] is bool) {
          final bool res = map[_key] as bool;
          return res;
        }
      }
      return false;
    } catch (err) {
      print(err);
      return false;
    }
  }

  @override
  Future<void> setReadIntro() async {
    Map<String, dynamic> map = Map.from({
      _key: true
    });
    await storage.writeObject(_key, map);
  }

}
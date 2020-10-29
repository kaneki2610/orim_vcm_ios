import 'package:flutter/cupertino.dart';
import 'package:orim/base/viewmodel.dart';
import 'package:orim/repositories/splash/splash.dart';

class SplashViewModel extends BaseViewModel {

  SplashRepo repo;

  Future<bool> userIsReadIntro() async {
    return await repo.getIsReadIntro();
  }

  Future<void> setUserReadIntro() async {
    return await repo.setReadIntro();
  }

}
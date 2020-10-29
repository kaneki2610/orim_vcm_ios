import 'package:flutter/cupertino.dart';
import 'package:orim/base/bloc.dart';
import 'package:orim/model/auth/auth.dart';
import 'package:orim/model/personal_info/personal_info.dart';
import 'package:orim/model/user_info_data/user_info_data.dart';
import 'package:orim/navigator_service.dart';
import 'package:orim/pages/intro/intro_page.dart';
import 'package:orim/viewmodel/splash.dart';
import 'package:orim/viewmodel/user_info.dart';
import 'package:orim/viewmodel/user_info_personal.dart';
import 'package:provider/provider.dart';

class SplashBloc extends BaseBloc {
  SplashBloc({BuildContext context}) : super(context: context);

  SplashViewModel _splashViewModel;
  UserInfoViewModel _userInfoViewModel;
  UserInfoPersonalViewModel _userInfoPersonalViewModel;

  @override
  void updateDependencies(BuildContext context) {
    super.updateDependencies(context);
    _splashViewModel = Provider.of<SplashViewModel>(context);
    _userInfoViewModel = Provider.of<UserInfoViewModel>(context);
    _userInfoPersonalViewModel =
        Provider.of<UserInfoPersonalViewModel>(context);
  }

  Future<void> next() async {
//    await authViewModel.saveStatus(false);
//    await _userInfoPersonalViewModel.reset();
    final bool userIsReadIntro = await _splashViewModel.userIsReadIntro();
    if (userIsReadIntro) {
      bool logIn = await authViewModel.readStatus();
      AuthModel authorData;
      PersonalInfoModel personInfo;
      authorData = await authViewModel.getAuth();
      personInfo = await _userInfoPersonalViewModel.getUserInfo();

      if (logIn) {
        await permissionViewModel.getPermissionLocal();
        if(this.permissionViewModel.data == null){
          if(this.permissionViewModel.data.length == 0){
            await permissionViewModel.getPermission();
          }else{
            permissionViewModel.getPermission();
          }
        }else{
          permissionViewModel.getPermission();
        }
        await _userInfoPersonalViewModel.saveInfoPersonal(
            model: personInfo);
        _userInfoViewModel.data = UserInfoData(
          name: authorData.fullName,
          phone: personInfo.phoneNumber,
          identify: personInfo.id,
          enterprise: "",
          address: personInfo.address,
        );
      }
      NavigatorService.switchHome(context);
    } else {
      IntroPageArguments arguments = IntroPageArguments();
      NavigatorService.switchIntro(context, arguments: arguments);
    }
  }

  @override
  void dispose() {
    _splashViewModel.dispose();
  }
}

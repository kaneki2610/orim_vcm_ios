import 'package:orim/base/subject.dart';
import 'package:orim/model/personal_info/personal_info.dart';
import 'package:orim/navigator_service.dart';
import 'package:orim/pages/employer_info/employer_info_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:orim/base/bloc.dart';

class EmployerInfoBloc extends BaseBloc {
  EmployerInfoBloc(
      {@required BuildContext context, @required EmployerInfoView view})
      : super(context: context) {
    this.view = view;
  }
  EmployerInfoView view;

  BehaviorSubject<PersonalInfoModel> _personalInfoSubject = BehaviorSubject();

  Stream<PersonalInfoModel> get personalInfoStream => _personalInfoSubject.stream;

  @override
  void updateDependencies(BuildContext context) {
    super.updateDependencies(context);
  }

  void getEmployerInfo() async {
    await this.view.showLoading();
    PersonalInfoModel personInfo = await this.userInfoPersonalViewModel.getUserInfo();
    if(personInfo != null) {
      _personalInfoSubject.value = personInfo;
    }
    await this.view.hideLoading();
  }

  Future<void> logout() async {
    await this.view.showLoading();
     await this.authViewModel.logout();
    this.permissionViewModel.resetMenu();
    this.userInfoPersonalViewModel.reset();
    this.view.showMessageWhenLogoutSucceed();
    await this.view.hideLoading();
    this.backThePreviousPage();
  }

  void backThePreviousPage() {
    NavigatorService.popToRoot(context);
  }

  @override
  void dispose() {
    _personalInfoSubject.close();
  }
}

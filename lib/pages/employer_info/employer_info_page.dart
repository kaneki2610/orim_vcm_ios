import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:orim/base/page.dart';
import 'package:orim/components/input_decoration_widget.dart';
import 'package:orim/components/loading.dart';
import 'package:orim/components/raised_buttom_custom.dart';
import 'package:orim/components/title_container.dart';
import 'package:orim/config/colors_resource.dart';
import 'package:orim/config/dimens_resource.dart';
import 'package:orim/config/imgs_resource.dart';
import 'package:orim/config/strings_resource.dart';
import 'package:orim/model/personal_info/personal_info.dart';
import 'package:orim/pages/employer_info/employer_info_bloc.dart';
import 'package:orim/pages/employer_info/employer_info_view.dart';
import 'package:orim/utils/alert_dialog.dart';
import 'package:orim/utils/widget/widget.dart';

import '../../navigator_service.dart';

class EmployerInfoPage extends StatefulWidget {
  const EmployerInfoPage();

  static const routeName = 'EmployerInfo';

  @override
  State<StatefulWidget> createState() {
    return _EmployerInfoPageState();
  }
}

class _EmployerInfoPageState
    extends BaseState<EmployerInfoBloc, EmployerInfoPage>
    implements EmployerInfoView {
  @override
  void initBloc() {
    this.bloc = EmployerInfoBloc(context: context, view: this);
  }

  @override
  void onPostFrame() {
    this.bloc.getEmployerInfo();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    this.bloc.updateDependencies(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorsResource.backgroundColorIntro,
        appBar: AppBar(
            backgroundColor: ColorsResource.backgroundColorIntro,
            title: Text(StringResource.getText(context, "employer_info"))),
        body: Container(
            padding: EdgeInsets.only(
                left: DimenResource.paddingInput,
                right: DimenResource.paddingInput),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: DimenResource.paddingContent),
                ImageView.asset(ImageResource.logo_intro_p1, scale: 1.5),
                SizedBox(height: DimenResource.paddingContent),
                Text(
                  StringResource.getText(context, "title_employer_info"),
                  style: TextStyle(color: ColorsResource.textColorTutorial),
                ),
                SizedBox(height: DimenResource.paddingInput),
                Center(
                  child: ImageView.asset(ImageResource.user_icon, scale: 5.0),
                ),
                SizedBox(height: DimenResource.marginContent),
                Expanded(
                  child: StreamBuilder(
                      stream: this.bloc.personalInfoStream,
                      builder:
                          (context, AsyncSnapshot<PersonalInfoModel> snapshot) {
                        if (snapshot.hasData) {
                          PersonalInfoModel personalInfoModel = snapshot.data;
                          if (personalInfoModel != null) {
                            return ListView(
                              children: <Widget>[
                                _textInfoWidget(context, "login_name",
                                    "${personalInfoModel.loginName}"),
                                _textInfoWidget(context, "first_and_last_name",
                                    "${personalInfoModel.name}"),
                                _textInfoWidget(context, "telephone",
                                    "${personalInfoModel.phoneNumber}"),
                                _textInfoWidget(context, "email",
                                    "${personalInfoModel.email}"),
                                _textInfoWidget(context, "department",
                                    "${personalInfoModel.departmentName}"),
                              ],
                            );
                          } else {
                            return Center(
                              child: Text(StringResource.getText(
                                  context, 'no_employer_data')),
                            );
                          }
                        } else {
                          return Center(
                            child: Loading(),
                          );
                        }
                      }),
                ),
                Center(
                  child: RaisedButtonCustom(
                      backgroundColor: Colors.red,
                      width: 250.0,
                      text: StringResource.getText(context, "logout_menu")
                          .toUpperCase(),
                      onPressed: () {
                        this._logout();
                      }),
                ),
                Container(
                  height: 70,
                  padding: EdgeInsets.only(bottom: 10, top: 10),
                  alignment: Alignment.center,
                  color: ColorsResource.backgroundColorIntro,
                  child: Text(
                    StringResource.getText(context, 'dev_unit') + ': VNPT',
                    style: TextStyle(
                        color: ColorsResource.textColorTutorial, fontSize: 16),
                  ),
                )
              ],
            )));
  }

  Widget _textInfoWidget(BuildContext context, String key, String value) {
    return Container(
      padding: EdgeInsets.only(bottom: DimenResource.paddingButton),
      child: Text(
        "${StringResource.getText(context, key)}:  ${value ?? ""}",
        style: TextStyle(color: ColorsResource.textColorTutorial),
      ),
    );
  }

  void _logout() {
    AlertDialogBuilder(
            context: context,
            title: StringResource.getText(context, 'logout_title_warning'),
            content: StringResource.getText(context, 'logout_content_warning'))
        .show(cancelable: true, actions: <Widget>[
      AlertDialogBuilder.button(
          text: StringResource.getText(context, 'no'),
          onPress: () => NavigatorService.back(context)),
      AlertDialogBuilder.button(
          text: StringResource.getText(context, 'yes'), onPress: logout)
    ]);
  }

  Future<void> logout() async {
    if (NavigatorService.back(context)) {
      await this.bloc.logout();
    }
  }

  @override
  Future<bool> hideLoading() async {
    return await this.progressDialogLoading.hide();
  }

  @override
  Future<bool> showLoading() async {
    return await this.progressDialogLoading.show();
  }

  @override
  void showMessageWhenLogoutFailed(String msg) {
    Fluttertoast.showToast(
        msg: StringResource.getText(context, 'logout_failed - $msg'));
  }

  @override
  void showMessageWhenLogoutSucceed() {
    Fluttertoast.showToast(
        msg: StringResource.getText(context, 'logout_succeed'));
  }

  @override
  void showMessageWhenLogoutTimeout() {
    Fluttertoast.showToast(msg: StringResource.getText(context, 'time_out'));
  }

  @override
  void dispose() {
    this.bloc.dispose();
    super.dispose();
  }
}

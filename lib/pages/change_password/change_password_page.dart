import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:orim/base/page.dart';
import 'package:orim/components/input_decoration_widget.dart';
import 'package:orim/components/raised_buttom_custom.dart';
import 'package:orim/components/title_container.dart';
import 'package:orim/config/enum_packages/enum_change_password.dart';
import 'package:orim/config/strings_resource.dart';
import 'package:orim/pages/change_password/change_password_bloc.dart';
import 'package:orim/pages/change_password/change_password_view.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage();

  static const routeName = 'ChangePass';

  @override
  State<StatefulWidget> createState() {
    return _ChangePasswordPageState();
  }
}

class _ChangePasswordPageState
    extends BaseState<ChangePasswordBloc, ChangePasswordPage>
    implements ChangePasswordView {
  @override
  void initBloc() {
    this.bloc = ChangePasswordBloc(context: context, view: this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    this.bloc.updateDependencies(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: TitleContainer(
          titleText: StringResource.getText(context, 'change_password_menu'),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Center(
          child: Form(
            child: Column(
              children: <Widget>[
                StreamBuilder<Object>(
                    stream: this.bloc.passwordStream,
                    builder: (context, snapshot) {
                      return TextField(
                        controller: this.bloc.passwordController,
                        obscureText: true,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        onChanged: (value) => this.bloc.onChangePassword(value),
                        decoration: buildInputDecoration(
                            StringResource.getText(context, "new_password")),
                      );
                    }),
                SizedBox(height: 8),
                StreamBuilder<Object>(
                    stream: this.bloc.confirmPasswordStream,
                    builder: (context, snapshot) {
                      return TextField(
                        controller: this.bloc.confirmPasswordController,
                        obscureText: true,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        onChanged: (value) =>
                            this.bloc.onChangeConfirmPassword(value),
                        decoration: buildInputDecoration(StringResource.getText(
                            context, "input_new_password")),
                      );
                    }),
                StreamBuilder(
                    stream: this.bloc.submitStream,
                    builder: (context, snapshot) {
                      return RaisedButtonCustom(
                        text: StringResource.getText(context, "update_pass")
                            .toUpperCase(),
                        onPressed: snapshot.hasData
                            ? snapshot.data ? this.bloc.submit : null
                            : null,
                      );
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Future<bool> hideLoading() async {
    await progressDialogLoading.hide();
    return true;
  }

  @override
  Future<bool> showLoading() async {
    await progressDialogLoading.show();
    return true;
  }

  @override
  Future<void> showToastWithMessage(String msg) async {
    await Fluttertoast.showToast(msg: msg);
  }

  @override
  void dispose() {
    this.bloc.dispose();
    super.dispose();
  }
}

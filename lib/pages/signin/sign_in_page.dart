import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:orim/base/page.dart';
import 'package:orim/components/container/background_container.dart';
import 'package:orim/components/raised_buttom_custom.dart';
import 'package:orim/components/text_input_form_field.dart';
import 'package:orim/config/colors_resource.dart';
import 'package:orim/config/dimens_resource.dart';
import 'package:orim/config/imgs_resource.dart';
import 'package:orim/config/strings_resource.dart';
import 'package:orim/pages/signin/sign_in_bloc.dart';
import 'package:orim/pages/signin/sign_in_view.dart';

class SignInPage extends StatefulWidget {
  static const String routeName = 'SignIn';

  @override
  State<StatefulWidget> createState() {
    return _SignInState();
  }
}

class _SignInState extends BaseState<SignInBloc, SignInPage> implements SignInView {

  @override
  void initBloc() {
    bloc = SignInBloc(context: context, view: this);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void onPostFrame() {
    // TODO: implement onPostFrame
    super.onPostFrame();
    this.bloc.rememberLogin();

  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc.updateDependencies(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BackgroundContainer(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(bottom: 5.0),
                child: Image.asset(
                  ImageResource.logo,
                  scale: 1.5,
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    top: DimenResource.paddingContent,
                    bottom: DimenResource.paddingContent),
                alignment: Alignment.centerLeft,
                child: Text(
                  StringResource.getText(context, 'sign_in_app_content'),
                  style: TextStyle(
                      color: ColorsResource.textColorUpdateInfo,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              BackgroundContainerForm(
                child: Container(
                  padding: EdgeInsets.only(left: 50.0, right: 50.0),
                  margin: EdgeInsets.only(top: 50.0, bottom: 50.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(50.0),
                    ),
                  ),
                  child: Form(
                    child: Column(
                      children: <Widget>[
                        _titleForm(
                            content: StringResource.getText(context, 'login')
                                .toUpperCase(),
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                        Container(
                          height: 5.0,
                        ),
                        _titleForm(
                            content: StringResource.getText(
                                    context, 'sign_in_please')
                                .toUpperCase(),
                            fontSize: 16,
                            fontWeight: FontWeight.normal),
                        Container(
                          height: 10.0,
                        ),
                        StreamBuilder(
                          stream: bloc.usernameErrorObserver,
                          builder: (context, AsyncSnapshot<String> snapshot) {
                            return TextInputFormField(
                              keyboardType: TextInputType.text,
                              prefixIcon: Icon(Icons.person),
                              hintText: StringResource.getText(
                                  context, "sign_in_username"),
                              textEditingController:
                                  bloc.usernameController,
                              focusNode: bloc.usernameFocusNode,
                              errorText:
                                  snapshot.hasError ? snapshot.error : null,
                              onSubmitted: (_) =>
                                  bloc.passwordFocusNode.requestFocus(),
                            );
                          },
                        ),
                        StreamBuilder(
                            stream: bloc.passwordErrorObserver,
                            builder: (context, AsyncSnapshot<String> snapshot) {
                              return TextInputFormField(
                                keyboardType: TextInputType.text,
                                obscureText: true,
                                prefixIcon: Icon(Icons.vpn_key),
                                hintText: StringResource.getText(
                                    context, "sign_in_password"),
                                textEditingController:
                                    bloc.passwordController,
                                focusNode: bloc.passwordFocusNode,
                                errorText:
                                    snapshot.hasError ? snapshot.error : null,
                                onSubmitted: (_) => this.bloc.login()
                              );
                            }),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            StreamBuilder(
                              stream: bloc.rememberPasswordObserver,
                              builder: (context, AsyncSnapshot<bool> snapshot) {
                                return Checkbox(
                                  value:
                                      snapshot.hasData ? snapshot.data : false,
                                  onChanged:
                                      bloc.onChangeRememeberPassword,
                                );
                              },
                            ),
                            Text(StringResource.getText(
                                context, 'sign_in_remember_password')),
                          ],
                        ),
                        RaisedButtonCustom(
                          text: StringResource.getText(context, 'login')
                              .toUpperCase(),
                          onPressed: () {
                            this.bloc.login();
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _titleForm({String content, double fontSize, FontWeight fontWeight}) {
    return Container(
      child: Text(
        content,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  @override
  Future<void> showLoginFail() async {
    await this.showPopupWithAction(StringResource.getText(context, 'sign_in_failed'), actions: null);
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
}

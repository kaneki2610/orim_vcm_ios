import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:orim/base/page.dart';
import 'package:orim/components/container_appbar.dart';
import 'package:orim/components/drawer_toggle.dart';
import 'package:orim/components/raised_buttom_custom.dart';
import 'package:orim/components/text_input_form_field.dart';
import 'package:orim/config/colors_resource.dart';
import 'package:orim/config/dimens_resource.dart';
import 'package:orim/config/strings_resource.dart';
import 'package:orim/pages/home/tab/info/info_bloc.dart';

import '../../../../navigator_service.dart';

class InfoPage extends StatefulWidget {
  static const String routeName = 'info_tab';
  final bool isBack;
  const InfoPage(this.isBack);

  @override
  State<StatefulWidget> createState() {
    return _InfoPageState();
  }
}

class _InfoPageState extends BaseState<InfoBloc, InfoPage>
    with AutomaticKeepAliveClientMixin<InfoPage> {
  @override
  void initBloc() {
    bloc = InfoBloc(context: context, isBack: this.widget.isBack);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc.updateDependencies(context);
    bloc?.loadData();
  }

  @override
  void dispose() {
    super.dispose();
    bloc?.dispose();
  }

  @override
  void updateKeepAlive() {}

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Container(
//      padding: EdgeInsets.only(
//          left: DimenResource.paddingContent,
//          right: DimenResource.paddingContent,
//          top: DimenResource.paddingContent),
      child: Material(
        elevation: 16.0,
        child: Container(
          padding: EdgeInsets.all(DimenResource.paddingContent),
          child: Form(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  StreamBuilder(
                    stream: bloc.errorName,
                    builder: (context, snapshot) => TextInputFormField(
                      keyboardType: TextInputType.text,
                      onSubmitted: (value) =>
                          bloc.identifyFocusNode.requestFocus(),
                      hintText: StringResource.getText(
                              context, "first_and_last_name") +
                          ' ' +
                          StringResource.getText(context, "require"),
                      textEditingController: bloc.nameController,
                      focusNode: bloc.nameFocusNode,
                      errorText: snapshot.hasError ? snapshot.error : null,
                    ),
                  ),
                  StreamBuilder(
                    stream: bloc.errorIdentify,
                    builder: (context, snapshot) => TextInputFormField(
                      keyboardType: TextInputType.number,
                      onSubmitted: (value) =>
                          bloc.phoneFocusNode.requestFocus(),
                      hintText:
                          StringResource.getText(context, "identify_number"),
                      textEditingController: bloc.identifyController,
                      focusNode: bloc.identifyFocusNode,
                      errorText: snapshot.hasError ? snapshot.error : null,
                    ),
                  ),
                  StreamBuilder(
                    stream: bloc.errorPhone,
                    builder: (context, snapshot) => TextInputFormField(
                      keyboardType: TextInputType.phone,
                      onSubmitted: (value) =>
                          bloc.enterpriseFocusNode.requestFocus(),
                      hintText:
                          StringResource.getText(context, "phone_number") +
                              ' ' +
                              StringResource.getText(context, "require"),
                      textEditingController: bloc.phoneController,
                      focusNode: bloc.phoneFocusNode,
                      errorText: snapshot.hasError ? snapshot.error : null,
                    ),
                  ),
                  StreamBuilder(
                    stream: bloc.errorEnterprise,
                    builder: (context, snapshot) => TextInputFormField(
                      keyboardType: TextInputType.text,
                      onSubmitted: (value) =>
                          bloc.addressFocusNode.requestFocus(),
                      hintText:
                          StringResource.getText(context, "enterprise_name"),
                      textEditingController: bloc.enterpriseController,
                      focusNode: bloc.enterpriseFocusNode,
                      errorText: snapshot.hasError ? snapshot.error : null,
                    ),
                  ),
                  TextInputFormField(
                    keyboardType: TextInputType.text,
                    onSubmitted: (value) => onSubmit(),
                    hintText: StringResource.getText(context, "address"),
                    textEditingController: bloc.addressController,
                    focusNode: bloc.addressFocusNode,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    height: DimenResource.heightButtonUpdataInfo,
                    child: RaisedButtonCustom(
                        text: StringResource.getText(context, 'title_info_tab'),
                        onPressed: () {
                          onSubmit();
                        })
                /*    child: RaisedButton(
                      onPressed: onSubmit,
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          side: BorderSide(
                              color: Theme.of(context).primaryColor)),
                      child: Text(
                        StringResource.getText(context, 'title_info_tab')
                            .toUpperCase(),
                      ),
                    ),*/
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  onSubmit() async {
    if (await bloc.saveInfo()) {
      saveDataSuccess();
      FocusScope.of(context).unfocus();
    } else {
      saveDataFailed();
    }
  }

  void saveDataSuccess() {
    Fluttertoast.showToast(
        msg: StringResource.getText(context, 'update_info_success'));
    if(this.bloc.isBack){
      NavigatorService.back(context);
    }
  }

  void saveDataFailed() {
    Fluttertoast.showToast(
        msg: StringResource.getText(context, 'update_info_failed'));
  }
}

class InfoPageTabbar extends StatelessWidget implements PreferredSizeWidget {
  final double height;

  const InfoPageTabbar({
    Key key,
    this.height = DimenResource.heightTabbar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ContainerAppbar(
      backgroundColor: Theme.of(context).primaryColor,
      isLightStatus: true,
      child: AppBar(
        leading: DrawerToggle(),
        title: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  child: Text(
                    StringResource.getText(context, 'title_info_tab'),
                    style: TextStyle(
                        color: ColorsResource.iconColorTabbar,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              InkWell(
                onTap: () => showExplain(context),
                child: Icon(
                  Icons.info_outline,
                  color: ColorsResource.iconColorTabbar,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);

  void showExplain(BuildContext context) {
    final snackBar = SnackBar(
        content: Text(StringResource.getText(context, 'explain_info_update')));
    Scaffold.of(context).showSnackBar(snackBar);
  }
}

class InfoLoginPage extends StatelessWidget {
  static const String routeName = 'info_login_tab';
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  InfoLoginPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: this._scaffoldKey,
      appBar: AppBar(
        title: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  child: Text(
                    StringResource.getText(context, 'title_info_tab'),
                    style: TextStyle(
                        color: ColorsResource.iconColorTabbar,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              InkWell(
                onTap: () => showExplain(context),
                child: Icon(
                  Icons.info_outline,
                  color: ColorsResource.iconColorTabbar,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: InfoPage(true),
      ),
    );
  }

  void showExplain(BuildContext context) {
    final snackBar = SnackBar(
        content: Text(StringResource.getText(context, 'explain_info_update')));
    this._scaffoldKey.currentState.showSnackBar(snackBar);
  }
}

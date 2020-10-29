import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:orim/components/container/background_container.dart';
import 'package:orim/components/text_input_form_field.dart';
import 'package:orim/config/colors_resource.dart';
import 'package:orim/config/dimens_resource.dart';
import 'package:orim/config/imgs_resource.dart';
import 'package:orim/config/strings_resource.dart';
import 'package:orim/pages/home/home_page.dart';
import 'package:orim/pages/update_info/update_info_bloc.dart';

class UpdateInfoPage extends StatefulWidget {
  static const routeName = 'UpdateInfo';

  @override
  State<StatefulWidget> createState() {
    return _UpdateInfoState();
  }
}

class _UpdateInfoState extends State<UpdateInfoPage> {
  UpdateInfoBloc _updateInfoBloc;

  @override
  void initState() {
    _updateInfoBloc = UpdateInfoBloc(context: context);
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {

    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateInfoBloc?.updateDependencies(context);
  }

  @override
  void dispose() {
    _updateInfoBloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundContainer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 30, bottom: 30),
            child: Text(
              StringResource.getText(context, 'update_info').toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: ColorsResource.textColorUpdateInfo,
                  fontSize: DimenResource.textTitleSize,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            child: Text(
              StringResource.getText(context, 'update_info_explain'),
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: ColorsResource.textColorUpdateInfo, fontSize: 16.0),
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
                    StreamBuilder(
                      stream: _updateInfoBloc.errorName,
                      builder: (context, snapshot) => TextInputFormField(
                        keyboardType: TextInputType.text,
                        hintText: StringResource.getText(
                                context, "first_and_last_name") +
                            ' ' +
                            StringResource.getText(context, "require"),
                        textEditingController: _updateInfoBloc.nameController,
                        focusNode: _updateInfoBloc.nameFocusNode,
                        errorText: snapshot.hasError ? snapshot.error : null,
                        onSubmitted: (_) =>
                            _updateInfoBloc.identifyFocusNode.requestFocus(),
                      ),
                    ),
                    StreamBuilder(
                      stream: _updateInfoBloc.errorIdentify,
                      builder: (context, snapshot) => TextInputFormField(
                        keyboardType: TextInputType.number,
                        hintText:
                            StringResource.getText(context, "identify_number"),
                        textEditingController:
                            _updateInfoBloc.identifyController,
                        focusNode: _updateInfoBloc.identifyFocusNode,
                        errorText: snapshot.hasError ? snapshot.error : null,
                        onSubmitted: (_) =>
                            _updateInfoBloc.phoneFocusNode.requestFocus(),
                      ),
                    ),
                    StreamBuilder(
                      stream: _updateInfoBloc.errorPhone,
                      builder: (context, snapshot) => TextInputFormField(
                        keyboardType: TextInputType.phone,
                        hintText:
                            StringResource.getText(context, "phone_number") +
                                ' ' +
                                StringResource.getText(context, "require"),
                        textEditingController: _updateInfoBloc.phoneController,
                        focusNode: _updateInfoBloc.phoneFocusNode,
                        errorText: snapshot.hasError ? snapshot.error : null,
                        onSubmitted: (_) =>
                            _updateInfoBloc.enterpriseFocusNode.requestFocus(),
                      ),
                    ),
                    StreamBuilder(
                      stream: _updateInfoBloc.errorEnterprise,
                      builder: (context, snapshot) => TextInputFormField(
                        keyboardType: TextInputType.text,
                        hintText:
                            StringResource.getText(context, "enterprise_name"),
                        textEditingController:
                            _updateInfoBloc.enterpriseController,
                        focusNode: _updateInfoBloc.enterpriseFocusNode,
                        errorText: snapshot.hasError ? snapshot.error : null,
                        onSubmitted: (_) =>
                            _updateInfoBloc.addressFocusNode.requestFocus(),
                      ),
                    ),
                    TextInputFormField(
                      keyboardType: TextInputType.text,
                      onSubmitted: (value) => onSubmit(),
                      hintText: StringResource.getText(context, "address"),
                      textEditingController: _updateInfoBloc.addressController,
                      focusNode: _updateInfoBloc.addressFocusNode,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Row(children: <Widget>[
                              Expanded(
                                child:  MaterialButton(
                                  height: DimenResource.heightButton,
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(DimenResource.borderRadiusButton),
                                      side: BorderSide(
                                          color: ColorsResource.textButtonSkip)),
                                  onPressed: _skip,
                                  textColor: ColorsResource.textButtonSkip,
                                  child: Text(
                                      StringResource.getText(context, "skip")
                                          .toUpperCase()),
                                ),
                              ),
                              SizedBox(width: 5.0,),
                            ],)
                          ),
                          Expanded(
                            flex: 1,
                            child:Row(
                              children: <Widget>[
                                SizedBox(width: 5.0,),
                                Expanded(
                                  child: MaterialButton(
                                    height: DimenResource.heightButton,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(DimenResource.borderRadiusButton),
                                        side: BorderSide(
                                            color: ColorsResource.textButtonUpdate)),
                                    onPressed: onSubmit,
                                    textColor: ColorsResource.textButtonUpdate,
                                    child: Text(
                                        StringResource.getText(context, "update")
                                            .toUpperCase()),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onSubmit() async {
    if (await _updateInfoBloc.updateInfo()) {
      await _updateInfoBloc.userIsReadIntro();
      saveDataSuccess();
      FocusScope.of(context).unfocus();
      _updateInfoBloc.gotoHome();
    } else {
      saveDataFailed();
    }
  }

  void _skip() async {
    await _updateInfoBloc.userIsReadIntro();
    _updateInfoBloc.gotoHome();
  }

  void saveDataSuccess() {
    Fluttertoast.showToast(
        msg: StringResource.getText(context, 'update_info_success'));
  }

  void saveDataFailed() {
    Fluttertoast.showToast(
        msg: StringResource.getText(context, 'update_info_failed'));
  }
}

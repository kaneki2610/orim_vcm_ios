import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orim/components/text_input_form_field.dart';
import 'package:orim/components/title_container.dart';
import 'package:orim/config/dimens_resource.dart';
import 'package:orim/config/strings_resource.dart';
import 'package:orim/pages/send_complain/modal/modal_info/modal_info_bloc.dart';

import '../../../../components/raised_buttom_custom.dart';

class ModalInfoPage extends StatefulWidget {
  static const String routeName = 'ModalInfoState';

  final ModalInfoArguments arguments;

  ModalInfoPage({ @required this.arguments });

  @override
  State<StatefulWidget> createState() {
    return ModalInfoState();
  }

}

class ModalInfoState extends State<ModalInfoPage> {
  ModalInfoBloc _modalInfoBloc;

  @override
  void initState() {
    _modalInfoBloc = ModalInfoBloc(context: context);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _modalInfoBloc?.updateDependencies(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TitleContainer(
          titleText: StringResource.getText(context, 'info_title'),
        )
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
//              padding: EdgeInsets.only(
//                  left: DimenResource.paddingContent,
//                  right: DimenResource.paddingContent,
//                  top: DimenResource.paddingContent),
                child: Container(
                  padding: EdgeInsets.all(DimenResource.paddingContent),
                  child: Form(
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          StreamBuilder(
                            stream: _modalInfoBloc.errorName,
                            builder: (context, snapshot) => TextInputFormField(
                              keyboardType: TextInputType.text,
                              onSubmitted: (value) =>
                                  _modalInfoBloc.phoneFocusNode.requestFocus(),
                              hintText: StringResource.getText(
                                  context, "first_and_last_name") +
                                  ' ' +
                                  StringResource.getText(context, "require"),
                              textEditingController: _modalInfoBloc.nameController,
                              focusNode: _modalInfoBloc.nameFocusNode,
                              errorText: snapshot.hasError ? snapshot.error : null,
                            ),
                          ),
                          StreamBuilder(
                            stream: _modalInfoBloc.errorPhone,
                            builder: (context, snapshot) => TextInputFormField(
                              keyboardType: TextInputType.phone,
                              onSubmitted: (_) => updateInfo,
                              hintText:
                              StringResource.getText(context, "phone_number") +
                                  ' ' +
                                  StringResource.getText(context, "require"),
                              textEditingController: _modalInfoBloc.phoneController,
                              focusNode: _modalInfoBloc.phoneFocusNode,
                              errorText: snapshot.hasError ? snapshot.error : null,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10.0),
                            height: DimenResource.heightButtonUpdataInfo,
                            child: RaisedButtonCustom(
                                text: StringResource.getText(context, 'title_info_tab'),
                                onPressed: updateInfo,),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ),
          ],
        ),
      ),
    );
  }


  void updateInfo() async {
    bool res = await _modalInfoBloc.submit();
    if (res) {
      String name = _modalInfoBloc.nameController.text;
      String phone = _modalInfoBloc.phoneController.text;
      if (_modalInfoBloc.back()) {
        widget.arguments.callback(name, phone);
      };
    }
  }

  @override
  void dispose() {
    _modalInfoBloc.dispose();
    super.dispose();
  }
}

class ModalInfoArguments {
  Function(String, String) callback;

  ModalInfoArguments({ this.callback });
}

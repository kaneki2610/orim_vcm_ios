import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orim/components/raised_buttom_custom.dart';
import 'package:orim/config/dimens_resource.dart';
import 'package:orim/config/strings_resource.dart';
import 'package:orim/pages/issue_detail/widget/issue_standard_info.dart';

class IssueLocation extends StatelessWidget {
  const IssueLocation({this.location, this.onPressButton});

  final String location;
  final Function onPressButton;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        IssueStandardInfo(icon: Icons.location_on,
            title: StringResource.getText(context, 'address'),
            content: location),
        _buttonViewOnMap(context),
      ],
    );
  }

  Widget _buttonViewOnMap(BuildContext context) {
    final Color colorTitle = Theme.of(context).primaryColor;
    return RaisedButtonCustom(
      text: StringResource.getText(context, 'view_on_map'),
      onPressed: onPressButton,
    );
  }

}
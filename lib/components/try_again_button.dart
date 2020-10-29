import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orim/config/strings_resource.dart';

class TryAgainButton extends StatelessWidget {
  final Function onPressed;

  const TryAgainButton({ this.onPressed });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
        onPressed: onPressed,
        color: Theme.of(context).primaryColor,
        textColor: Colors.white,
        child: Text(StringResource.getText(context, 'try_again')),
      ),
    );
  }
}

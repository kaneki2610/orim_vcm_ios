import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:orim/config/dimens_resource.dart';

class TextInputFormField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final String errorText;
  final TextEditingController textEditingController;
  final FocusNode focusNode;
  final InputBorder border;
  final InputBorder disabledBorder;
  final InputBorder focusedBorder;
  final TextInputType keyboardType;
  final ValueChanged<String> onSubmitted;
  final Widget prefixIcon;
  final bool obscureText;

  const TextInputFormField(
      {this.labelText, this.textEditingController, this.focusNode, this.hintText, this.obscureText, this.prefixIcon, this.border, this.keyboardType, this.onSubmitted, this.disabledBorder, this.focusedBorder, this.errorText});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
      height: 60,
      child: TextFormField(
        onFieldSubmitted: onSubmitted,
        keyboardType: keyboardType,
        autocorrect: false,
        focusNode: focusNode,
        controller: textEditingController,
        obscureText: obscureText ?? false,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          labelText: labelText,
          hintText: hintText,
          contentPadding: EdgeInsets.all(10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(DimenResource.borderRadiusButton)),
          ),
          disabledBorder: disabledBorder ?? OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(DimenResource.borderRadiusButton)),
            borderSide: BorderSide(
              color: Colors.grey,
            ),
          ),
          focusedBorder: focusedBorder ?? OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(DimenResource.borderRadiusButton)),
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
            ),
          ),
          errorText: errorText,
        ),
      ),
    );
  }
}
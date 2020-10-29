import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {

  final Color colorIcon;

  const CustomBackButton({ this.colorIcon });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back, color: this.colorIcon ?? Colors.white),
      onPressed: () => Navigator.pop(context, false),
    );
  }

}
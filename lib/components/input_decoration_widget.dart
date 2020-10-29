import 'package:flutter/material.dart';
import 'package:orim/config/colors_resource.dart';

InputDecoration buildInputDecoration(String name) {
  return InputDecoration(
    contentPadding: EdgeInsets.only(left: 30),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(color: Colors.blue,)),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(color: Colors.grey)),
    hintText: '$name',
    hintStyle: TextStyle(color: ColorsResource.inputColor),
  );
}